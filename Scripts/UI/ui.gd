extends CanvasLayer
class_name UI

@export var button:TextureButton
@export var text:Label
@export var textSeeds:Label

@export var animationPlayer:AnimationPlayer

@onready var global:PlayerInfoScript = get_node("/root/PlayerInfoScript")

signal on_menu_pressed

func _ready():
	text.visible = false
	animationPlayer.play("idle")
	global.update_seed.connect(_on_update_seeds)
	_on_update_seeds()

func _on_update_seeds():
	textSeeds.text = str("Seeds: ",global.cantSeeds)

func _on_menu_button_pressed():
	emit_signal("on_menu_pressed")

func setOnText(v):
	text.visible = v

func setText(s):
	text.text = s
