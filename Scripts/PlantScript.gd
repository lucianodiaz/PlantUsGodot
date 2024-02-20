extends Node
class_name Plant

const FPS = 60;

signal plant_selected
signal plant_created
signal on_transition
signal on_happy
signal on_end_cicle
signal change_pot_request

var _HAPPINESS = 8.0;

var _ENTERTAINMENT = 8.0;

var _HYDROUS = 8.0;

var _LIFE = 8.0;

var _SUNNY = 8.0

var _DIRTY = 0.0;

var _GROW = 0.0;

var selected = false

var is_transitioning = false
@export var _MAX_GROW = 8.0;

var multiplier = 1.0;

var isDiying = false
var isDead = false
var statesPlant = 0 #max 3

var growth = ["tiny","med","big"]

var currentGrowth:String = growth[statesPlant]

var Name = ""
@export var stateMachine:StateMachine

var currentState : State

var currentPotOwner:Flowerpot = null
@export var _animated_sprite:AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
#	_animated_sprite.play("growth")
func _input(event):
	if Input.is_action_just_released("tap"):
		selected = false
	

func set_pot_owner(pot:Flowerpot)->void:
	if !pot: return
	currentPotOwner = pot

func _on_created_plant():
	emit_signal("plant_created",self)
	currentState = stateMachine.current_state
	$Timers.get_child_count()
	for i in $Timers.get_child_count():
		$Timers.get_child(i).start()

func _selected():
	emit_signal("plant_selected")
#	_animated_sprite.play(currentGrowth+"growth")


func getCurrentGrowth() -> String:
	return currentGrowth.to_lower()

func getStateSizePlant() -> int:
	return statesPlant


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if _SUNNY <= 4 or _HYDROUS <= 4 or _DIRTY > 5:
		isDiying = true
		multiplier = 1
	elif _SUNNY >= 4 and _HYDROUS >= 4 and _DIRTY < 5:
		isDiying = false

#	pass

func addMultiplier():
	if(multiplier < 1.5):
		multiplier += 0.1

func giveSun():
	_SUNNY += 1
	addMultiplier()
	emit_signal("on_end_cicle")
	

func giveWater():
	_HYDROUS += 0.5
	addMultiplier()
	emit_signal("on_happy")
	emit_signal("on_end_cicle")

func giveMusic():
	addMultiplier()
	emit_signal("on_happy")
	emit_signal("on_end_cicle")

func giveLove():
	addMultiplier()
	emit_signal("on_happy")
	emit_signal("on_end_cicle")

func Clear():
	_DIRTY -= 1
	_HAPPINESS +=1
	emit_signal("on_end_cicle")

func downgradeGrowth():
	_GROW -= 1

func passTime():
	if Name == "": return
	if(_GROW < _MAX_GROW and !isDiying and !is_transitioning):
		_GROW = clamp(_GROW + (1*multiplier),0,_MAX_GROW)
		print("GROWTH: ",_GROW)
	elif(isDiying):
#		_LIFE -=1 
		_LIFE = clamp(_LIFE-1,0,8)
		if(_LIFE<= 0 and !isDead):
			isDead = true
			get_parent().emit_signal("plantDead")
			return
	checkIsGrowPlant();
	

func getHappiness():
	return _HAPPINESS
	
	
func getHydrous():
	return _HYDROUS


func getLife():
	return _LIFE


func getEntertainment():
	return _ENTERTAINMENT


func getSunny():
	return _SUNNY


func getDirty():
	return _DIRTY

func getName():
	return Name

func setNamePlant(n:String):
	Name = n

func _on_timer_sun_timeout():
	print("sun lvl: ",clamp(_SUNNY-0.15,0,8))
	#_SUNNY = clamp(_SUNNY-0.15,0,8)
	#_DIRTY = clamp(_DIRTY+1,0,8)
	#_ENTERTAINMENT =clamp(_ENTERTAINMENT+1,0,8)
	emit_signal("on_end_cicle")

func _on_timer_water_timeout():
	print("Water lvl: ",clamp(_HYDROUS-0.2,0,8))
	_HYDROUS = clamp(_HYDROUS-0.2,0,8)
	emit_signal("on_end_cicle")
	#if _HYDROUS < 7:
		#_animated_sprite.play("dry")


func _on_timer_happy_timeout():
	_HAPPINESS = clamp(_HAPPINESS-0.1,0,8)
	emit_signal("on_end_cicle")

func checkIsGrowPlant():
	if(_GROW >= _MAX_GROW):
		if clamp((statesPlant+1),0,growth.size()) < currentPotOwner.maxAllowedPlantSize:
			statesPlant = clamp((statesPlant+1),0,growth.size())
			currentGrowth = growth[statesPlant]
			_GROW = 0
			change_visual_plant()
			is_transitioning = true
			emit_signal("on_transition",self)
		else:
			#I need a bigger pot to growth
			if statesPlant != SizesEnum.Sizes.BIG:
				is_transitioning = true
				print("I need a bigger pot to growth")
				emit_signal("change_pot_request")

func change_visual_plant():
		_animated_sprite.visible = false
		_animated_sprite.stop()
		var animation_path = getCurrentGrowth()+"_animations"
		_animated_sprite = get_node(animation_path);
		_animated_sprite.visible = true

func _on_input_area_input_event(viewport, event, shape_idx):
	@warning_ignore("unused_parameter")
	if is_instance_valid(self):
		if Input.is_action_just_pressed("tap") && !selected:
			_selected()
