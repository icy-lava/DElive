extends Node2D
class_name ProgressManager

var current_level: int = 9
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
		if not try_load(current_level):
			current_level = 0
			difficulty += 1
			if not try_load(current_level):
				assert(false, "what")

func try_load(level: int) -> bool:
	if get_level() == null:
		var name := "res://level/level%s.tscn" % level
		var scene := load(name)
		if scene != null:
			Game.spawn(scene, global_position)
			return true
	return false

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
