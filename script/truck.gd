extends KinematicBody2D
class_name Truck

export(Array, AudioEffectAmplify) var drop_scenes: Array
onready var Dropper: DropSpawn = find_node("DropSpawn")

func _ready() -> void:
	Dropper.drop_scenes = drop_scenes

func drop() -> void:
	Dropper.drop()
