extends Node2D
class_name Spawner

export var count: int = 1
export var radius: float = 25
export var spawn_scene: PackedScene

func _ready() -> void:
	call_deferred('spawn')

func spawn() -> void:
	for i in count:
		var angle := float(i) / count * TAU + PI / 2
		var distance: float = radius if count > 1 else 0
		var direction: Vector2 = Vector2(cos(angle), sin(angle))
		var offset: Vector2 = direction * distance + Vector2(rand_range(0, 5), 0).rotated(rand_range(0, TAU))
		var instance := Game.spawn(spawn_scene, global_position + offset)
		instance.velocity = direction * 50
	
	queue_free()
