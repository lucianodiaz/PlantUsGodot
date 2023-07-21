extends Node

signal on_click

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		self.visible = false
		emit_signal("on_click",self)


func _on_mouse_entered():
	var label = get_node("Label")
	label.visible = true


func _on_mouse_exited():
	var label = get_node("Label")
	label.visible = false
