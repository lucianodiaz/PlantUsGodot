extends CanvasLayer
class_name ShopList

@export var vBox:VBoxContainer
@onready var global:PlayerInfoScript = get_node("/root/PlayerInfoScript")
@export var itemScene:PackedScene

signal on_selected_pot

func _ready():
	for i in global.items:
		var item:Items = itemScene.instantiate()
		item._setScenePath(i["scn"])
		item._setName(i["Name"])
		item._setButtonTexture(i["img"])
		item._setSize(i["maxSize"])
		item.on_buy_item.connect(_on_select_pot)
		vBox.add_child(item)


func _on_select_pot(src):
	print(src)
	emit_signal("on_selected_pot",src)
	visible = false
