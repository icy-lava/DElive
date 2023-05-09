extends Node2D

onready var player: Player = Game.get_nearest_player(Vector2.ZERO)
export var radius: float = 48

func _physics_process(delta: float) -> void:
	update()

func get_boid_pip_count() -> int:
	if is_instance_valid(player):
		return player.boid_chain
	return 0

func get_shooty_pip_count() -> int:
	if is_instance_valid(player):
		return player.shooty_chain
	return 0

func _draw() -> void:
	var pip_radius: float = 6
	var angle_interval: float = PI / 8
	
	var bpip: int = get_boid_pip_count()
	if bpip > 0:
		var angle_range: float = (bpip - 1) * angle_interval
		for i in bpip:
			var div: int = 1
			if bpip > 1: div = bpip - 1
			var angle: float = PI * 0.5 - angle_range * 0.5 + float(i) / div * angle_range
			draw_circle(Vector2(cos(angle), sin(angle)) * radius, pip_radius, Color("d81a2e"))
	
	angle_interval *= 2
	var spip: int = get_shooty_pip_count()
	if spip > 0:
		var angle_range: float = (spip - 1) * angle_interval
		for i in spip:
			var div: int = 1
			if spip > 1: div = spip - 1
			var angle: float = PI * -0.5 - angle_range * 0.5 + float(i) / div * angle_range
			draw_circle(Vector2(cos(angle), sin(angle)) * radius, pip_radius, Color("d81a2e"))

