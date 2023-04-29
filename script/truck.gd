extends KinematicBody2D
class_name Truck

export(Array, PackedScene) var drop_scenes: Array
var current_drop: int = 0

onready var spawn_point := $SpawnPoint

func drop():
	assert(len(drop_scenes) > 0, "there's nothing to spawn, add some drop scenes")
	
	var scene: PackedScene = drop_scenes[current_drop]
	var instance := Game.spawn(scene)
	instance.global_position = spawn_point.global_position
	
	current_drop = (current_drop + 1) % len(drop_scenes)
