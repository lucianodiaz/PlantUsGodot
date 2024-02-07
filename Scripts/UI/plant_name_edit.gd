extends CanvasLayer
class_name PlantNameEdit

var plantReference:Plant

func _on_line_edit_text_submitted(new_text):
	print(new_text)
	assert(plantReference,"Plant Reference dosen't exist")
	plantReference.setNamePlant(new_text)
	visible = false

func setPlantReference(p:Plant):
	visible = true
	plantReference=p
