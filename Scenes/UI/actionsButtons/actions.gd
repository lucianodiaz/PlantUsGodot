extends CanvasLayer
class_name Actions

@export var mainClass:Main
func _ready():
	mainClass = get_parent().get_parent()
	mainClass.connect("hideUIInfo",_on_hideUIInfo)
	
func _on_enter_mouse():
	mainClass.setUISelection(true)
	
	
func _on_exit_mouse():
	mainClass.setUISelection(false)

func _on_hideUIInfo():
	for c in get_children():
		c.hideBar()
