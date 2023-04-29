extends Node2D

export var count: int = 1
export var radius: float = 100
export var spawn_scene: PackedScene

func _ready() -> void:
	for i in count:
		var angle := float(i) / count * TAU + PI / 2
		var distance: float = radius if count > 1 else 0
		var offset: Vector2 = Vector2(cos(angle), sin(angle)) * distance
		Game.spawn(spawn_scene, global_position + offset)
	
	queue_free()
