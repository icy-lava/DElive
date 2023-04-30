extends Label

func update_progress(level: int, phase: int) -> void:
	text = "%d-%d" % [level + 1, phase + 1]

func _on_ProgressManager_progress_changed(level: int, phase: int) -> void:
	update_progress(level, phase)
