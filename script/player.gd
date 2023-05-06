extends Living
class_name Player

var velocity: Vector2 = Vector2.ZERO
var direction: Vector2 = Vector2.RIGHT
onready var gun := $Rotating/Gun
var using_controller := false

export var boid_chain_max: int = 6
var boid_chain: int = 0
export var shooty_chain_max: int = 3
var shooty_chain: int = 0

export var boost_frames_increment: int = 300
var boost_frames: int = 0
var boost_active: bool = false
onready var gun_initial_interval: int = gun.fire_interval
onready var gun_boost_interval: int = gun_initial_interval / 2

signal kill(other)
signal damage(other)
signal boost_on
signal boost_off

func _physics_process(delta: float) -> void:
	# process movement
	var input: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = Game.damp(velocity, input * 1300, 0.001, delta)
	velocity = move_and_slide(velocity)
	
	var aim_direction: Vector2 = Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down", 0.4)
	if aim_direction.length() > 0.5:
		using_controller = true
	
	# face the mouse
	if using_controller:
		if aim_direction != Vector2.ZERO:
			direction = aim_direction.normalized()
	else:
		direction = (get_global_mouse_position() - position).normalized()
	$Rotating.rotation = direction.angle()
	
#	health = min(health + delta * 0.2, max_health)
	
	# shooting
	if Input.is_action_pressed("shoot"):
		if gun.shoot():
			var sound: AudioStreamPlayer = $ShootPlayer
			sound.stop()
			sound.pitch_scale = pow(2, rand_range(-0.07, 0.07))
			sound.play()
	
	var boost_actual: bool = boost_frames > 0
	if boost_actual and !boost_active:
		emit_signal("boost_on")
	if !boost_actual and boost_active:
		emit_signal("boost_off")
	boost_active = boost_actual
	
	boost_frames = max(boost_frames - 1, 0)

func _input(event: InputEvent) -> void:
	var motion := event as InputEventMouseMotion
	if motion and motion.relative != Vector2.ZERO:
		using_controller = false

func addBoidChain(count: int) -> void:
	boid_chain += max(count, 0)
	if health == max_health:
		boid_chain = 0
	while boid_chain >= boid_chain_max:
		boid_chain -= boid_chain_max
		health = min(health + 1, max_health)

func addShootyChain(count: int) -> void:
	shooty_chain += max(count, 0)
	while shooty_chain >= shooty_chain_max:
		shooty_chain -= shooty_chain_max
		boost_frames += boost_frames_increment

func _on_Player_on_hit() -> void:
	addBoidChain(-1)
	addShootyChain(-1)
	if health <= 0:
		Game.play_sound($DeathPlayer, 0)
	else:
		Game.play_sound($HurtPlayer, 0.25)

func _on_Player_kill(other: Living) -> void:
	if other.name.match("*Boid*"):
		addBoidChain(1)
	elif other.name.match("*Shooty*"):
		addShootyChain(1)

func _on_Player_boost_on() -> void:
	print('boost ON')
	gun.fire_interval = gun_boost_interval

func _on_Player_boost_off() -> void:
	print('boost off')
	gun.fire_interval = gun_initial_interval
