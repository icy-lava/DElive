extends Label

func update_progress(level: int) -> void:
	text = "%d" % level

func _on_ProgressManager_progress_changed(level: int) -> void:
	update_progress(level)
