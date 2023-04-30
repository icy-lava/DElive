extends KinematicBody2D
class_name Dieable

signal dying

func die() -> void:
	emit_signal("dying")
	queue_free()
