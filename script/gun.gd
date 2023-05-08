extends Node2D
class_name Gun

export var fire_interval: int = 20
var last_shot_frame: int = Game.get_frame_id() - fire_interval
export (PackedScene) var bullet_scene: PackedScene
export var knockback: float = 500
export var bullet_speed: float = 2200
export var bullet_count: int = 1
export var angle_interval: float = PI / 6

func shoot() -> bool:
	var shot_time: int = Game.get_frame_id() - last_shot_frame
	if shot_time >= fire_interval:
		for i in bullet_count:
			var angle: float = 0
			if bullet_count > 1: angle = (float(i) / (bullet_count - 1) - 0.5) * (angle_interval * (bullet_count - 1))
			var bullet: Bullet = Game.spawn(bullet_scene, get_parent().global_position + position.rotated(angle + global_rotation))
			angle = angle / 3 + global_rotation
			bullet.shooter = owner
			bullet.speed = bullet_speed
			bullet.direction = Vector2(cos(angle), sin(angle))
			if 'velocity' in bullet.shooter:
				bullet.shooter.velocity -= bullet.direction * knockback / bullet_count * sqrt(bullet_count)
		last_shot_frame = Game.get_frame_id()
		return true
	return false
