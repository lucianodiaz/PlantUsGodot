extends CanvasLayer

@export var button:TextureButton

signal on_menu_pressed

func _on_menu_button_pressed():
	emit_signal("on_menu_pressed")
