extends State
class_name Idle

@export var animation:AnimatedSprite2D
@export var plant:Plant

var indexIdle = 1
var count = 4

func _enter():
	animation.animation_finished.connect(on_finish_animation)
	animation.play(str(plant.getCurrentGrowth()+"_"+"idle"+str(indexIdle)))


func on_finish_animation():
	var animationName
	if(count <= 0):
		indexIdle = 2
		count = 4
	count -= 1
	animationName = str(plant.getCurrentGrowth()+"_"+"idle"+str(indexIdle))
	animation.play(animationName)
#	animation.play(animationName)
	print(animationName)
	if indexIdle == 2:
		indexIdle=1
