extends Living
class_name Player

var velocity: Vector2 = Vector2.ZERO
var direction: Vector2 = Vector2.RIGHT
onready var gun := $Rotating/Gun

func _physics_process(delta: float) -> void:
	# process movement
	var input: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = Game.damp(velocity, input * 1300, 0.001, delta)
	velocity = move_and_slide(velocity)
	
	# face the mouse
	direction = (get_global_mouse_position() - position).normalized()
	$Rotating.rotation = direction.angle()
	
	health = min(health + delta * 0.2, max_health)
	
	# shooting
	if Input.is_action_pressed("shoot"):
		if gun.shoot():
			var sound: AudioStreamPlayer = $ShootPlayer
			sound.stop()
			sound.pitch_scale = pow(2, rand_range(-0.07, 0.07))
			sound.play()


func _on_Player_on_hit() -> void:
	if health <= 0:
		Game.play_sound($DeathPlayer, 0)
	else:
		Game.play_sound($HurtPlayer, 0.25)
