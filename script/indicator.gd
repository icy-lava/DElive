extends Node2D

func _input(event: InputEvent) -> void:
	var motion = event as InputEventMouseMotion
	if motion:
		global_position = get_global_mouse_position()

func _physics_process(delta: float) -> void:
	var sscale = 1.0 / Game.get_scale()
	$Pips.scale = Vector2(sscale, sscale)
