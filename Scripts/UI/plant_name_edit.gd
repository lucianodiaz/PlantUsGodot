extends Control

var plantReference:Plant

func _on_line_edit_text_submitted(new_text):
	print(new_text)
	plantReference.setNamePlant(new_text)


func setPlantReference(p:Plant):
	plantReference=p
