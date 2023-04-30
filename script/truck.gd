extends KinematicBody2D
class_name Truck

onready var Dropper: DropSpawn = find_node("DropSpawn")

func drop() -> void:
	Dropper.drop()
