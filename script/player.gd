extends KinematicBody2D
class_name Player

var velocity: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	var input: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = Game.damp(velocity, input * 500, 0.00001, delta)
	velocity = move_and_slide(velocity)
