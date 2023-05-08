extends Node2D
class_name ProgressManager

var current_level: int = 0
var current_progress: int = current_level
var difficulty: int = 1
var player_died := false
signal progress_changed(level)
signal game_over()

func emit_progress_changed() -> void:
	emit_signal("progress_changed", current_progress)

func _ready() -> void:
	emit_progress_changed()

func _physics_process(delta: float) -> void:
	if Game.get_nearest_player(Vector2.ZERO) == null:
		if not player_died:
			player_died = true
			emit_signal("game_over")
	
	if get_level() == null:
		var level_count := len(Game.levels)
		while current_level >= level_count:
			current_level -= level_count
			difficulty += 1
		
		var scene := Game.levels[current_level] as PackedScene
		if scene != null:
			Game.spawn(scene, global_position)

func get_level() -> Level:
	var level: Level = owner.find_node("Level", true, false)
	return level

func next_level() -> void:
	if player_died: return
	current_level += 1
	current_progress += 1
	emit_progress_changed()
	get_level().queue_free()

func _input(event: InputEvent) -> void:
	if player_died and event.is_action_pressed("restart"):
		Game.reset_scene()
		return
