extends Dieable
class_name Living

export var max_health: float = 10
onready var health: float = max_health

func hurt(points: float) -> bool:
	health -= points
	if health <= 0:
		die()
		return true
	return false
