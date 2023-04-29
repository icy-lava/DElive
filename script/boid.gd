extends Living
class_name Boid

var velocity := Vector2.ZERO
var direction := Vector2.RIGHT

func _physics_process(delta: float) -> void:
	var boids := get_tree().get_nodes_in_group('boid')
	
	var center := Vector2.ZERO
	var center_weight: float = 0
	var center_distance: float = 1200
	
	var repel := Vector2.ZERO
	var repel_distance: float = 600
	
	var maintain := Vector2.ZERO
	var maintain_weight: float = 0
	var maintain_distance: float = 1500
	
	for boid in boids:
		var delta_position: Vector2 = boid.position - position
		var distance = delta_position.length()
		
		if distance < center_distance:
			var weight: float = (center_distance - distance) / center_distance
			center_weight += weight
			center += boid.position * weight
		
		if distance < repel_distance:
			var weight: float = (repel_distance - distance) / repel_distance
			repel -= delta_position.normalized() * weight
		
		if distance < maintain_distance:
			var weight: float = (maintain_distance - distance) / maintain_distance
			if boid == self:
				weight *= 0.5
			maintain_weight += weight
			maintain += boid.velocity * weight
	
	var target: Player = Game.get_nearest_player(global_position)
	
	center /= center_weight
	var pdiff := center - position
	maintain /= maintain_weight
	
	velocity += pdiff * delta * 5
	velocity += repel * delta * 600
#	velocity += maintain * delta * 0.1
	Game.damp(velocity, maintain, 0.5, delta)
	if target != null:
		var delta_pos := target.position - position
		var tdir := delta_pos.normalized()
		velocity += tdir * delta * 1500
		var tdirp := tdir.rotated(PI / 2)
		var perp: Vector2 = tdirp * velocity.dot(tdirp)
#		velocity -= perp
#		velocity = Game.damp(velocity, velocity * velocity.normalized().dot(tdir), 0.01, delta)
		velocity = Game.damp(velocity, velocity - perp * 2, 0.8, delta)
	
	velocity = move_and_slide(velocity)
	velocity = Game.damp(velocity, Vector2.ZERO, 0.9, delta)
	
	direction = velocity.normalized()
	rotation = direction.angle()
