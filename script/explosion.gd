extends Node2D
class_name Explosion

export var radius: float = 500
export var radius_mult: float = 1
export var damage: float = 3
var killer: Living = null

func _physics_process(delta: float) -> void:
	update()

func _ready() -> void:
	call_deferred('apply_damage')
	Game.play_sound($ExplosionPlayer, 0.1)

func _draw() -> void:
	draw_circle(Vector2.ZERO, radius * radius_mult, Color.white)

func try_hurt(node: Node2D) -> bool:
	if node is Living:
		var living := node as Living
		if living.global_position.distance_to(global_position) < radius:
			if living.hurt(damage):
				if is_instance_valid(killer) and killer.has_signal('kill'):
					killer.emit_signal('kill', living)
			else:
				if is_instance_valid(killer) and killer.has_signal('damage'):
					killer.emit_signal('damage', living)
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
