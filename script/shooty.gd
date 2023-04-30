extends Living
class_name Shooty

var velocity := Vector2.ZERO
onready var gun := $Rotating/Gun

func _physics_process(delta: float) -> void:
	var player := Game.get_nearest_player(global_position)
	var want_velocity := Vector2.ZERO
	var direction := Vector2(cos($Rotating.rotation), sin($Rotating.rotation))
	var want_direction := direction
	if player != null:
		var delta_pos := player.global_position - global_position
		want_direction = delta_pos.normalized()
		want_velocity = direction * 800
	
	direction = Game.damp(direction, want_direction, 0.01, delta)
	$Rotating.rotation = direction.angle()
	
	velocity = Game.damp(velocity, want_velocity, 0.01, delta)
	
	var enemies := get_tree().get_nodes_in_group('enemy')
	var repel := Vector2.ZERO
	var repel_distance: float = 600
	
	for enemy in enemies:
		var delta_position: Vector2 = enemy.global_position - global_position
		var distance = delta_position.length()
		
		if distance < repel_distance:
			var weight: float = (repel_distance - distance) / repel_distance
			repel -= delta_position.normalized() * weight
	
	velocity += repel * delta * 500
	velocity = move_and_slide(velocity)
	
	if player != null:
		gun.shoot()
