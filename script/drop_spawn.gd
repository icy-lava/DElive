extends Node2D
class_name DropSpawn

export(Array, AudioEffectAmplify) var drop_scenes: Array
var current_drop: int = 0

onready var spawn_point := owner.find_node("SpawnPoint", true, false)

func _ready() -> void:
	if spawn_point == null:
		spawn_point = owner

func drop():
	assert(len(drop_scenes) > 0, "there's nothing to spawn, add some drop scenes")
	
	var info: SpawnInfo = drop_scenes[current_drop]
	var scene := info.spawn_scene
	var instance: Node2D
	if info.boxed:
		var box: Box = Game.spawn(preload("res://object/box.tscn"), spawn_point.global_position)
		box.max_time = info.box_time
		box.time = info.box_time
		box.spawn_scene = scene
		box.spawn_count = info.spawn_count
		
		instance = box
	else:
		if info.spawn_count > 1:
			var spawner: Spawner = Game.spawn(preload("res://object/spawner.tscn"), spawn_point.global_position)
			spawner.spawn_scene = scene
			spawner.count = info.spawn_count
		else:
			instance = Game.spawn(scene, spawn_point.global_position)
	
	if instance is RigidBody2D:
		var body := instance as RigidBody2D
		body.angular_velocity = rand_range(-20, 20)
		body.linear_velocity = Vector2(cos(global_rotation), sin(global_rotation)) * rand_range(-1000, -500)
	
	current_drop = (current_drop + 1) % len(drop_scenes)
