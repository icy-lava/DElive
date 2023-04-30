extends Node2D
class_name ProgressManager

var current_level: int = 0
var last_phase: int = 0
signal progress_changed(level, phase)

func emit_progress_changed() -> void:
	emit_signal("progress_changed", current_level, last_phase)

func _ready() -> void:
	emit_progress_changed()

func _physics_process(delta: float) -> void:
	var level := get_level()
	if level == null:
		var name := "res://level/level%s.tscn" % current_level
		var scene := load(name)
		if scene != null:
			level = Game.spawn(scene, global_position)
		else:
			print_debug("no more levels!")
			queue_free()
	else:
		last_phase = level.current_phase
		emit_progress_changed()

func get_level() -> Level:
	var level: Level = owner.find_node("Level", true, false)
	return level

func next_level() -> void:
	current_level += 1
	last_phase = 0
	emit_progress_changed()
	get_level().queue_free()
