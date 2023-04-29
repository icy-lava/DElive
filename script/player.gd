extends KinematicBody2D
class_name Player

var velocity: Vector2 = Vector2.ZERO
var direction: Vector2 = Vector2.RIGHT
var fire_interval: int = 20
var last_shot_frame: int = Game.get_frame_id() - fire_interval
export (PackedScene) var bullet_scene: PackedScene

func _physics_process(delta: float) -> void:
	# process movement
	var input: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = Game.damp(velocity, input * 900, 0.00001, delta)
	velocity = move_and_slide(velocity)
	
	# face the mouse
	direction = (get_global_mouse_position() - position).normalized()
	rotation = direction.angle()
	
	# shooting
	var shot_time: int = Game.get_frame_id() - last_shot_frame
	if shot_time >= fire_interval and Input.is_action_pressed("shoot"):
		shoot()

func shoot():
	var bullet: Bullet = bullet_scene.instance()
	bullet.direction = direction
	bullet.position = position + direction * 72
	get_parent().add_child(bullet)
	last_shot_frame = Game.get_frame_id()
