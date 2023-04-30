extends AudioEffectAmplify
class_name SpawnInfo

# Godot 3 really doesn't like custom resources, but there's a hack to make it work
# https://godotengine.org/qa/8139/need-help-with-exporting-a-custom-ressource-type#a8146

# Also I made it an AudioEffectAmplify because the context menu for selecting a Resource
# goes offscreen because there's like 1000 options, and I can't select Make Unique.
# Just ignore the amplify option when configuring it

# Nevermind, I guess all of the above is irrelevant, because I can select the
# Resource without dragging in the saved file.
# It's still helpful to make it an AudioEffectAmplify (because of the huge menu).

# if you need this Resource as an array:
# export(Array, AudioEffectAmplify) var xyz: Array

export var boxed: bool = false
export var box_time: float = 5
export var spawn_count: int = 1
export var spawn_scene: PackedScene
