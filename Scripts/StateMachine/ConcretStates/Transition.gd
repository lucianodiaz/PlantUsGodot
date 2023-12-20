extends State
class_name Transition

@export var plant:Plant

func _enter():
	plant._animated_sprite.animation_finished.connect(on_finished_animation)
	plant._animated_sprite.play("transition")

func _exit():
	pass

func on_finished_animation():
	Transitioned.emit(self,"statemachine/"+"growth")
