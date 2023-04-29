extends Node2D
class_name Gun

export var fire_interval: int = 20
var last_shot_frame: int = Game.get_frame_id() - fire_interval
export (PackedScene) var bullet_scene: PackedScene
export var knockback: float = 500

func shoot():
	var shot_time: int = Game.get_frame_id() - last_shot_frame
	if shot_time >= fire_interval:
		var bullet: Bullet = Game.spawn(bullet_scene, global_position)
		bullet.shooter = get_parent()
		bullet.direction = Vector2(cos(global_rotation), sin(global_rotation))
		if 'velocity' in get_parent():
			get_parent().velocity -= bullet.direction * knockback
		last_shot_frame = Game.get_frame_id()
