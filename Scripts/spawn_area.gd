extends Area2D
class_name SpawnArea

signal on_click
var mouseInside = false
@export var baseSprite:Sprite2D

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and mouseInside:
		mouseInside = false
		
		var pos = get_global_mouse_position()
		#var newY = baseSprite.texture.get_size().y * baseSprite.scale.y
		emit_signal("on_click",self,Vector2(pos.x,(pos.y)))


func _on_mouse_entered():
	mouseInside = true;


func _on_mouse_exited():
	mouseInside = false
