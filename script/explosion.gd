extends Node2D

export var radius: float = 500
export var radius_mult: float = 1
export var damage: float = 3

func _physics_process(delta: float) -> void:
	update()

func _ready() -> void:
	call_deferred('apply_damage')

func _draw() -> void:
	draw_circle(Vector2.ZERO, radius * radius_mult, Color.white)

func try_hurt(node: Node2D) -> bool:
	if node is Living:
		var living := node as Living
		if living.global_position.distance_to(global_position) < radius:
			living.hurt(damage)
			return true
	return false

func try_impact(node: Node2D) -> bool:
	if 'velocity' in node:
		var direction: Vector2 = node.global_position - global_position
		var impact: float = sqrt(1 - direction.length() / radius)
		node.velocity += direction.normalized() * impact * 3000
		return true
	return false

func apply_damage() -> void:
	for enemy in get_tree().get_nodes_in_group('enemy'):
		if try_hurt(enemy): try_impact(enemy)
	for player in get_tree().get_nodes_in_group('player'):
		if try_hurt(player): try_impact(player)
