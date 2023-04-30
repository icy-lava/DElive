extends Node2D
class_name Gun

export var fire_interval: int = 20
var last_shot_frame: int = Game.get_frame_id() - fire_interval
export (PackedScene) var bullet_scene: PackedScene
export var knockback: float = 500
export var bullet_speed: float = 2200

func shoot():
	var shot_time: int = Game.get_frame_id() - last_shot_frame
	if shot_time >= fire_interval:
		var bullet: Bullet = Game.spawn(bullet_scene, global_position)
		bullet.shooter = owner
		bullet.speed = bullet_speed
		bullet.direction = Vector2(cos(global_rotation), sin(global_rotation))
		if 'velocity' in bullet.shooter:
			bullet.shooter.velocity -= bullet.direction * knockback
		last_shot_frame = Game.get_frame_id()
