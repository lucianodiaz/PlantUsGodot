extends State

class_name Stuck

@export var plant:Plant

func _enter():
	plant._animated_sprite.animation_finished.connect(on_finished_animation)
	plant._animated_sprite.play(plant.getCurrentGrowth()+"_"+"stuck")

func _exit():
	plant._animated_sprite.animation_finished.disconnect(on_finished_animation)

func on_finished_animation():
	Transitioned.emit(self,"statemachine/"+"idle")

