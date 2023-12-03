extends State
class_name Growth

@export var animation:AnimatedSprite2D
@export var plant:Plant

func _enter():
	animation.animation_finished.connect(on_finished_animation)
	animation.play(plant.getCurrentGrowth()+"_"+"growth")
	

func _exit():
	pass

func on_finished_animation():
	Transitioned.emit(self,"statemachine/"+"idle")
