extends Sprite2D

var flowerPotName:String = "flowerpot"
var index:int = 1;
var isPressed:bool = false
func changeTexture(newTExture:Texture):
	texture = newTExture
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and !isPressed:
		if get_rect().has_point(to_local(event.position)):
			isPressed = true
			index = index +1
			if index > 3:
				index = 1
			var newTexture = load("res://Resources/Textures/"+flowerPotName+str(index)+".png")
			changeTexture(newTexture)
	elif isPressed:
		isPressed = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
