extends Area2D
class_name Safezone

func _physics_process(delta: float) -> void:
	for body in get_overlapping_bodies():
		if 'safe' in body:
			body.safe = true
