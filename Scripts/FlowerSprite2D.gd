extends Sprite2D

var flowerPotName:String = "flowerpot"
var index:int = 1;
var isPressed:bool = false

func changeTexture(newTExture:Texture):
	texture = newTExture
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("clicked")
		if  !isPressed:
			isPressed = true
			index = index +1
			if index > 3:
				index = 1
		var newTexture = load("res://Resources/Textures/"+flowerPotName+str(index)+".png")
		changeTexture(newTexture)
	elif isPressed:
		isPressed = false
