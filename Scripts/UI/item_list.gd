extends HBoxContainer
class_name Items

signal on_buy_item

@onready var button:TextureButton = TextureButton.new()
@onready var nameLabel:Label = Label.new()
@onready var costLabel:Label= Label.new()
@onready var sizeLabel:Label= Label.new()

var pathToScene:String=""
func _ready():
	button = get_node("textureButton")
	nameLabel = get_node("Name")
	costLabel = get_node("Cost")
	sizeLabel = get_node("Size")
	

func _setScenePath(src):
	pathToScene = src

func _setButtonTexture(src):
	button = get_node("textureButton")
	var texture:Texture2D = load(src)
	button.texture_normal = texture
	button.texture_disabled = texture
	button.texture_focused = texture
	button.texture_hover = texture
	button.texture_pressed = texture

func _setName(n):
	nameLabel = get_node("Name")
	nameLabel.text = n

func _setCost(n):
	costLabel = get_node("Cost")
	costLabel.text = n
	

func _setSize(s:SizesEnum.Sizes):
	sizeLabel = get_node("Size")
	match s:
		SizesEnum.Sizes.TINY:
			sizeLabel.text = "Size: Tiny"
		SizesEnum.Sizes.MEDIUM:
			sizeLabel.text = "Size: Medium"
		SizesEnum.Sizes.BIG:
			sizeLabel.text = "Size: Big"


func _on_button_pressed():
	emit_signal("on_buy_item",pathToScene)
