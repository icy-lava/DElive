extends Living
class_name Player

var velocity: Vector2 = Vector2.ZERO
var direction: Vector2 = Vector2.RIGHT

func _physics_process(delta: float) -> void:
	# process movement
	var input: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = Game.damp(velocity, input * 1300, 0.001, delta)
	velocity = move_and_slide(velocity)
	
	# face the mouse
	direction = (get_global_mouse_position() - position).normalized()
	rotation = direction.angle()
	
	# shooting
	if Input.is_action_pressed("shoot"):
		$Gun.shoot()
