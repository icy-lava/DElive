extends Dieable
class_name Bullet

var shooter: Node2D = null
var direction: Vector2 = Vector2.RIGHT
var speed: float = 2200
var life_max: float = 0.6
onready var life: float = life_max
var velocity: Vector2 = Vector2.ZERO
var safe: bool = true
var damage: int = 1

func _physics_process(delta: float) -> void:
	velocity = direction * speed
	velocity = move_and_slide(velocity)
	speed = Game.damp(Vector2(speed, 0), Vector2.ZERO, 0.25, delta).x
	life -= delta
	if not safe or life <= 0:
		die()
	safe = false
	modulate.a = sqrt(life / life_max)

func _on_Hurtbox_body_entered(body: Node) -> void:
	if body == shooter:
		return
	if body is Living:
		var living: Living = body
		if is_instance_valid(shooter):
			if living.hurt(damage):
				if shooter.has_signal('kill'):
					shooter.emit_signal('kill', living)
			else:
				if shooter.has_signal('damage'):
					shooter.emit_signal('damage', living)
		if living is Player:
			living.velocity += velocity * 0.3
		elif living is UFO:
			living.velocity += velocity * 0.1
		else:
			living.velocity += velocity * 0.5
		if not living is Boid:
			Game.play_sound($HitPlayer, 0.25)
			die()
	var bomb := body as Bomb
	if bomb:
		bomb.explode(shooter)
		Game.play_sound($HitPlayer, 0.25)
		die()
	if body.is_in_group('box'):
		var box: RigidBody2D = body
		var offset: Vector2 = global_position - box.global_position
		box.apply_impulse(offset, velocity * 4)
		Game.play_sound($HitPlayer, 0.25)
		die()
	if body.get_collision_layer_bit(5):
		Game.play_sound($HitPlayer, 0.25)
		die()
