extends Node2D
class_name Level

onready var sequence: AnimationPlayer = find_node("Sequence", true, false)
onready var progress_manager := get_tree().root.find_node("ProgressManager", true, false)
var current_phase: int = 0

func _physics_process(delta: float) -> void:
	if can_advance():
		current_phase += 1
		var name: String = "phase%d" % current_phase
		if sequence.has_animation(name):
			sequence.play(name)
		elif progress_manager != null:
			progress_manager.next_level()

func can_advance() -> bool:
	if sequence.is_playing(): return false
	if len(get_tree().get_nodes_in_group("box")) > 0: return false
	if len(get_tree().get_nodes_in_group("enemy")) > 0: return false
	if len(get_tree().get_nodes_in_group("truck")) > 0: return false
	return true
