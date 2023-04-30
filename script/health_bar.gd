extends ProgressBar
class_name HealthBar

func _physics_process(delta: float) -> void:
	call_deferred('update_healthbar')

func update_healthbar() -> void:
	var parent := get_parent()
	var value := max(float(parent.health) / float(parent.max_health), 0)
	if value < 1:
		show()
		self.value = min_value + value * (max_value - min_value)
	else:
		hide()
