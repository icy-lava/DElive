extends Living
class_name Blade

var direction := Vector2.RIGHT
var velocity := Vector2.ZERO
var speed: float = 1200
var safe := true

func _physics_process(delta: float) -> void:
	if velocity != Vector2.ZERO:
		direction = velocity.normalized()
	velocity = direction * speed
	velocity = move_and_slide(velocity)
	if not safe:
		die()
	safe = false
	$BladeSprite.rotation += delta * TAU

func _on_Hurtbox_body_entered(body: Node) -> void:
	if body is Player:
		body.hurt(1)
		die()
	if body.get_collision_layer_bit(5):
		die()
