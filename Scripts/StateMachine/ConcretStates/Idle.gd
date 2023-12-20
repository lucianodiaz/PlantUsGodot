extends State
class_name Idle

@export var plant:Plant

var indexIdle = 1
var count = 4

func _enter():
	plant._animated_sprite.animation_finished.connect(on_finish_animation)
	plant._animated_sprite.play(str(plant.getCurrentGrowth()+"_"+"idle"+str(indexIdle)))
	plant.on_transition.connect(_onTransition)

func _onTransition():
	Transitioned.emit(self,"statemachine/"+"transition")

func on_finish_animation():
	var animationName
	if(count <= 0):
		indexIdle = 2
		count = 4
	count -= 1
	animationName = str(plant.getCurrentGrowth()+"_"+"idle"+str(indexIdle))
	plant._animated_sprite.play(animationName)
#	animation.play(animationName)
	print(animationName)
	if indexIdle == 2:
		indexIdle=1
