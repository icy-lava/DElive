extends Living
class_name UFO

var velocity := Vector2.ZERO
onready var Dropper: DropSpawn = find_node("DropSpawn")

export var spawn_interval: int = 0
var last_spawn_frame: int = Game.get_frame_id()

func _physics_process(delta: float) -> void:
	var player := Game.get_nearest_player(global_position)
	
	var want_velocity := Vector2.ZERO
	if player != null:
		var delta_pos := player.global_position - global_position
		var want_direction := delta_pos.rotated(-PI / 2).normalized()
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
		want_velocity = want_direction * 1000
	
	velocity = Game.damp(velocity, want_velocity, 0.2, delta)
	velocity = move_and_slide(velocity)
	
	if spawn_interval > 0:
		var frame_count: int = Game.get_frame_id() - last_spawn_frame
		if frame_count >= spawn_interval:
			last_spawn_frame = Game.get_frame_id()
			drop()
	
	$UFOSprite.rotation -= delta * 3

func drop() -> void:
	Dropper.drop()
