extends State
class_name Idle

@export var plant:Plant

var indexIdle = 1
var count = 4
func _ready():
	plant.on_transition.connect(_onTransition)
	plant.change_pot_request.connect(on_change_pot_request)
	plant.on_happy.connect(_on_happy_plant)
	
func _enter():
	plant._animated_sprite.animation_finished.connect(on_finish_animation)
	plant._animated_sprite.play(str(plant.getCurrentGrowth()+"_"+"idle"+str(indexIdle)))


func _exit():
	if is_instance_valid(plant) and plant._animated_sprite.is_connected("animation_finished",on_finish_animation):
		plant._animated_sprite.animation_finished.disconnect(on_finish_animation)
	#plant.on_transition.disconnect(_onTransition)
	#plant.change_pot_request.disconnect(on_change_pot_request)

func _on_happy_plant():
	Transitioned.emit(self,"statemachine/"+"happy")
	
func on_change_pot_request():
	Transitioned.emit(self,"statemachine/"+"stuck")

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
