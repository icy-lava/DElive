extends KinematicBody2D
class_name Bullet

var direction: Vector2 = Vector2.RIGHT
var speed: float = 1100
var safe: bool = true
var damage: int = 1

func _physics_process(delta: float) -> void:
	move_and_slide(direction * speed)
	if not safe:
		queue_free()
	safe = false

func die():
	queue_free()

func _on_Hurtbox_body_entered(body: Node) -> void:
	if body.is_in_group('enemy'):
		body.hurt(damage)
		die()
	if body.get_collision_layer_bit(5):
		die()
