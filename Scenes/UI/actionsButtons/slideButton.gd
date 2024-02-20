extends Button

var expanded:bool = false
var initialSize:Vector2 = Vector2(0.2,0.4)
@export var barSprite:Sprite2D
@export var actionFather:Actions

func _ready():
	actionFather = get_parent()
	connect("pressed",_on_pressed)
	connect("mouse_entered",_on_mouse_entered)
	connect("mouse_exited",_on_mouse_exited)

func _on_mouse_entered():
	actionFather._on_enter_mouse()

func _on_mouse_exited():
	actionFather._on_exit_mouse()

func expandBar():
	var tween:Tween = get_tree().create_tween()
	barSprite.scale.y = 1
	tween.tween_property(barSprite,"scale",Vector2(1,1),0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.play()
	await (tween.finished)
	expanded = true

func hideBar():
	var tween:Tween = get_tree().create_tween()
	tween.tween_property(barSprite,"scale",initialSize,0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.play()
	await (tween.finished)
	expanded = false

func _on_pressed():
	if expanded:
		hideBar()
	else:
		expandBar()


func _on_water_input(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		hideBar()
		actionFather.giveWater()

func _on_rake_input(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		hideBar()
		actionFather.rakeAction()

func _on_love_input(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		hideBar()
		actionFather.giveLove()
