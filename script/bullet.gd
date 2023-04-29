extends KinematicBody2D
class_name Bullet

var direction: Vector2 = Vector2.RIGHT
var speed: float = 800
var safe: bool = true

func _physics_process(delta: float) -> void:
	move_and_slide(direction * speed)
	if not safe:
		queue_free()
	safe = false
