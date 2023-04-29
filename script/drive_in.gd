extends Path2D

export var drive_in_time: float = 1
export var drive_out_time: float = 1
export var drop_off_time: float = 0.4

func _on_DriveAnimation_animation_started(anim_name: String) -> void:
	var animation := $DriveAnimation
	if anim_name == 'drive_in':
		animation.playback_speed = 1 / drive_in_time
	if anim_name == 'drive_out':
		animation.playback_speed = 1 / drive_out_time
	if anim_name == 'drop_off':
		animation.playback_speed = 1 / drop_off_time

func die() -> void:
	queue_free()
