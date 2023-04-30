extends RigidBody2D
class_name Bomb

export var max_time: float = 5
onready var time: float = max_time
export var radius: float = 600
export var explosion_scene: PackedScene

func _physics_process(delta: float) -> void:
	time -= delta
	$BombText.text = '%0.1f' % time
	if time <= 0:
		explode()
	update()

func _draw() -> void:
	var life: float = lerp(pow(1 - time / max_time, 0.25), 1, 0.1)
	var color := Color('#ffffffff')
	color.a = life * 0.15
	draw_circle(Vector2.ZERO, radius, color)

func explode() -> void:
	Game.spawn(explosion_scene, global_position).radius = radius
	queue_free()
