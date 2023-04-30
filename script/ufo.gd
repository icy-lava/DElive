extends Living
class_name UFO

var velocity := Vector2.ZERO
onready var Dropper: DropSpawn = find_node("DropSpawn")
onready var move_clockwise := randf() > 0.5

export var spawn_interval: int = 0
export(Array, AudioEffectAmplify) var drop_scenes: Array
var last_spawn_frame: int = Game.get_frame_id()
var last_position := global_position

func _ready() -> void:
	Dropper.drop_scenes = drop_scenes

func is_on_path() -> bool:
	return get_parent().name == "FlyFollow"

func _physics_process(delta: float) -> void:
	if is_on_path():
		position = Vector2.ZERO
	else:
		var player := Game.get_nearest_player(global_position)

		var want_velocity := Vector2.ZERO
		if player != null:
			var delta_pos := player.global_position - global_position
			var want_direction := delta_pos.rotated(-PI / 2).normalized()
			if not move_clockwise:
				want_direction *= -1
			var amplitude: float = 300
			var margin: float = 100
			var radius: float = 400

			var importance: float = abs(delta_pos.length() - radius)
			importance = max(importance - margin, 0)
			importance = min(importance / (amplitude - margin), 1)
			importance = pow(importance, 2)

			var offset_direction := delta_pos.normalized()
			if delta_pos.length() < radius:
				offset_direction *= -1
			offset_direction = lerp(offset_direction, want_direction, 0.5).normalized()
			want_direction = lerp(want_direction, offset_direction, importance).normalized()
			want_velocity = want_direction * 800

		velocity = Game.damp(velocity, want_velocity, 0.05, delta)
		velocity = move_and_slide(velocity)

	if spawn_interval > 0:
		var frame_count: int = Game.get_frame_id() - last_spawn_frame
		if frame_count >= spawn_interval:
			last_spawn_frame = Game.get_frame_id()
			drop()

	$UFOSprite.rotation -= 3 * (delta if move_clockwise else -delta)
	var delta_pos := global_position - last_position
	last_position = global_position
	$DropSpawn.rotation = delta_pos.angle() + PI

func drop() -> void:
	if is_on_path() or Game.get_nearest_player(global_position) != null:
		Dropper.drop()
