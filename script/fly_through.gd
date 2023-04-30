extends Path2D

export var fly_through_time: float = 1
export var die_on_end: bool = true

func get_ufo() -> UFO:
	var ufo: UFO = find_node('UFO', true, false)
	return ufo

func start() -> void:
	$FlyAnimation.play("fly_through")
	var ufo := get_ufo()
	pause_mode = Node.PAUSE_MODE_INHERIT

func _on_FlyAnimation_animation_started(anim_name: String) -> void:
	var animation: AnimationPlayer = $FlyAnimation
	if anim_name == 'fly_through':
		if fly_through_time == 0:
			animation.play(animation.animation_get_next(anim_name))
			return
		animation.playback_speed = 1 / fly_through_time

func die() -> void:
	if not die_on_end:
		var ufo := get_ufo()
		if ufo != null:
			var pos := ufo.global_position
			ufo.get_parent().remove_child(ufo)
			get_parent().add_child(ufo)
			move_child(ufo, get_index())
			ufo.global_position = pos
	queue_free()
