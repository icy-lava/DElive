extends Node

var background_color: Color = Color("#131d25") setget set_background_color, get_background_color
var levels: Array = []

func set_background_color(color: Color) -> void:
	VisualServer.set_default_clear_color(color)

func get_background_color() -> Color:
	return background_color

func _ready() -> void:
#	OS.set_window_title("ldjam 53")
	randomize()
	set_background_color(background_color)
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	
	var level: int = 0
	while true:
		var name := "res://level/level%s.tscn" % level
		var scene := load(name)
		if scene == null: break
		levels.append(scene)
		level += 1

func spawn(scene: PackedScene, global_position: Vector2) -> Node2D:
	var instance: Node2D = scene.instance()
	instance.global_position = global_position
	get_tree().current_scene.add_child(instance)
	return instance

func damp(from: Vector2, to: Vector2, smoothing: float, delta: float) -> Vector2:
	return lerp(from, to, 1.0 - pow(smoothing, delta))

func get_nearest_player(global_position: Vector2) -> Player:
	var result: Player = null
	for _player in get_tree().get_nodes_in_group('player'):
		var player: Player = _player
		var dist: float = player.global_position.distance_to(global_position)
		if result == null or dist < result.global_position.distance_to(global_position):
			result = player
	return result

func get_frame_id() -> int:
	return Engine.get_physics_frames()

func get_framerate() -> int:
	return Engine.iterations_per_second

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("hard_reset"):
		reset_scene()
		return
	
	if event.is_action_pressed("quit"):
		get_tree().quit()
		return
	
	if event.is_action_pressed("fullscreen"):
		OS.window_fullscreen = not OS.window_fullscreen
		return

func reset_scene() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	if get_tree().reload_current_scene() != OK:
		assert(false, 'failed to reset current scene')

func death_sound(sound: AudioStreamPlayer, octave_range: float) -> void:
	sound.get_parent().remove_child(sound)
	get_tree().root.add_child(sound)
	sound.stop()
	sound.connect("finished", sound, "queue_free")
	sound.pitch_scale = pow(2, rand_range(-octave_range, octave_range))
	sound.play()

func play_sound(sound: AudioStreamPlayer, octave_range: float) -> void:
	var clone := sound.duplicate()
	get_tree().root.add_child(clone)
	Game.death_sound(clone, octave_range)
