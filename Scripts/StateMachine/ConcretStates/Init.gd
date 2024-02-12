extends State
class_name Init

@export var plant:Plant


func _ready():
	plant._animated_sprite.animation_finished.connect(on_finished_animation)
	plant._animated_sprite.play(plant.getCurrentGrowth()+"_"+"sprout")

func on_finished_animation():
	#Transitioned.emit(self,"statemachine/"+"idle")
	plant._animated_sprite.animation_finished.disconnect(on_finished_animation)
	plant._animated_sprite.play(plant.getCurrentGrowth()+"_"+"sprout_idle")
	plant._animated_sprite.animation_finished.connect(on_finished_animation_idle)
	
func on_finished_animation_idle():
	plant._animated_sprite.animation_finished.disconnect(on_finished_animation_idle)
	Transitioned.emit(self,"statemachine/"+"idle")
	plant._on_created_plant()
	
func _enter():
	pass

func _update(delta):
	@warning_ignore("unused_parameter")
	pass

func _exit():
	pass
