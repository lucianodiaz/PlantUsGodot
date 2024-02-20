extends Node2D
class_name WindowEnviroment
signal on_touch_window
@export var animationPlayer:AnimationPlayer
var isOpen:bool= true

func _ready():
	pass


func _on_touch(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if isOpen:
			animationPlayer.play("close")
			isOpen=false
			await (animationPlayer.animation_finished)
			emit_signal("on_touch_window")
			pass
		else:
			animationPlayer.play_backwards("close")
			isOpen = true
			await (animationPlayer.animation_finished)
			emit_signal("on_touch_window")
			pass
