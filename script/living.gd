extends Dieable
class_name Living

export var max_health: float = 10
onready var health: float = max_health

signal on_hit

func is_dead() -> bool:
	return health <= 0

func hurt(points: float) -> bool:
	if not is_dead():
		health -= points
		emit_signal("on_hit")
		if is_dead():
			die()
			return true
	return false
