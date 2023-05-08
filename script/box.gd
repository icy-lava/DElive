extends RigidBody2D
class_name Box

export var max_time: float = 20
onready var time: float = max_time
export var spawn_scene: PackedScene
var spawn_count: int = 1

func _physics_process(delta: float) -> void:
	time -= delta
	$BoxTime.text = ("%0.1f" % time) if time <= 9.9 else str(int(time))
	if time <= 0:
		trigger()

func trigger():
	var spawner: Spawner = Game.spawn(preload("res://object/spawner.tscn"), global_position)
	spawner.spawn_scene = spawn_scene
	spawner.count = spawn_count
	queue_free()
