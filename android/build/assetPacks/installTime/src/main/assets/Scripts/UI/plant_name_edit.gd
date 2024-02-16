extends CanvasLayer
class_name PlantNameEdit

var plantReference:Plant

func _ready():
	var ledit:LineEdit = $lineEdit
func _on_line_edit_text_submitted(new_text):
	#print(new_text)
	assert(plantReference,"Plant Reference dosen't exist")
	plantReference.setNamePlant(new_text)
	visible = false
	$lineEdit.text = ""

func setPlantReference(p:Plant):
	visible = true
	plantReference=p


func _on_button_pressed():
	if $lineEdit.text != "":
		assert(plantReference,"Plant Reference dosen't exist")
		plantReference.setNamePlant($lineEdit.text)
		visible = false
		$lineEdit.text = ""
