extends CanvasModulate
class_name Lights

@export var gradient:GradientTexture1D
var time:float = 0.0

func _process(delta):
	#time += delta
	#var value = (sin(time-PI/2)+1.0)/2
	#self.color = gradient.gradient.sample(value)
	pass

func _setDark():
	self.color = gradient.gradient.sample(0.2)
	
func _setLight():
	self.color = gradient.gradient.sample(1)
