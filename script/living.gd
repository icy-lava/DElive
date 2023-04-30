extends Dieable
class_name Living

export var max_health: float = 10
onready var health: float = max_health

signal on_hit

func hurt(points: float) -> bool:
	health -= points
	emit_signal("on_hit")
	if health <= 0:
		die()
		return true
	return false
