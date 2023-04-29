extends Node2D
class_name Box

export var max_time: float = 20
onready var time: float = max_time
export var spawn_scene: PackedScene

func _ready() -> void:
	assert(spawn_scene != null, "didn't specify what the box should spawn")

func _physics_process(delta: float) -> void:
	time -= delta
	$BoxTime.text = ("%0.1f" % time) if time <= 9.9 else str(int(time))
	if time <= 0:
		trigger()

func trigger():
	Game.spawn(spawn_scene, global_position)
	queue_free()
