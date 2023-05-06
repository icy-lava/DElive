extends Node2D
class_name Level

onready var progress_manager := get_tree().root.find_node("ProgressManager", true, false)
onready var sequence: AnimationPlayer = $Sequence

func _physics_process(delta: float) -> void:
	if can_advance():
		if progress_manager != null:
			progress_manager.next_level()
		else:
			print_debug("level complete, no progress manager to continue")
			queue_free()

func can_advance() -> bool:
	if sequence.is_playing(): return false
#	if len(get_tree().get_nodes_in_group("enemy")) > 0: return false
	if len(get_tree().get_nodes_in_group("ufo")) > 0: return false
	if len(get_tree().get_nodes_in_group("box")) > 0: return false
	if len(get_tree().get_nodes_in_group("truck")) > 0: return false
#	if len(get_tree().get_nodes_in_group("bomb")) > 0: return false
	return true
