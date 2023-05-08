extends Node2D
class_name Spawner

export var count: int = 1
export var radius: float = 25
export var spawn_scene: PackedScene
onready var progress_manager: ProgressManager = get_tree().root.find_node("ProgressManager", true, false)

func _ready() -> void:
	call_deferred('spawn')

func spawn() -> void:
	var difficulty: int = 1
	if progress_manager != null: difficulty = progress_manager.difficulty
	var actual_count: int = count * difficulty
	for i in actual_count:
		var angle := float(i) / actual_count * TAU + PI / 2
		var distance: float = radius if actual_count > 1 else 0
		var direction: Vector2 = Vector2(cos(angle), sin(angle))
		var offset: Vector2 = direction * distance + Vector2(rand_range(0, 35), 0).rotated(rand_range(0, TAU))
		var instance := Game.spawn(spawn_scene, global_position + offset)
		instance.velocity = direction * 50
		if instance is Shooty:
			instance.get_node('Rotating').rotation = offset.angle()
	
	queue_free()
