extends Node2D
class_name ProgressManager

var current_level: int = 0
signal progress_changed(level)

func emit_progress_changed() -> void:
	emit_signal("progress_changed", current_level)

func _ready() -> void:
	emit_progress_changed()

func _physics_process(delta: float) -> void:
	var level := get_level()
	if level == null:
		var name := "res://level/level%s.tscn" % current_level
		var scene := load(name)
		if scene != null:
			level = Game.spawn(scene, global_position)
			print(level)
		else:
			print_debug("no more levels!")
			queue_free()

func get_level() -> Level:
	var level: Level = owner.find_node("Level", true, false)
	return level

func next_level() -> void:
	current_level += 1
	emit_progress_changed()
	get_level().queue_free()
