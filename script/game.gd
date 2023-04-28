extends Node

func _ready() -> void:
	OS.set_window_title("ldjam 53")
	set_background_color(Color(0, 0, 0))

func set_background_color(color: Color):
	VisualServer.set_default_clear_color(color)

func damp(from: Vector2, to: Vector2, smoothing: float, delta: float) -> Vector2:
	return lerp(from, to, 1.0 - pow(smoothing, delta))

func get_frame_id() -> int:
	return Engine.get_physics_frames()

func get_framerate() -> int:
	return Engine.iterations_per_second

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("quit"):
		get_tree().quit()
		return
	
	if event.is_action_pressed("fullscreen"):
		OS.window_fullscreen = not OS.window_fullscreen
		return

func reset_scene() -> void:
	if get_tree().reload_current_scene() != OK:
		assert(false, 'failed to reset current scene')
