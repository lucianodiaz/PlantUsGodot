extends Node
class_name Plant

const FPS = 60;

signal plant_created
signal on_transition
signal on_end_cicle
var _HAPPINESS = 8;

var _ENTERTAINMENT = 8;

var _HYDROUS = 8;

var _LIFE = 8;

var _SUNNY = 8;

var _DIRTY = 0;

var _GROW = 0;

var _MAX_GROW = 8;

var multiplier = 1;

var isDiying = false

var statesPlant = 0 #max 3

var growth = ["tiny","med","big"]

var currentGrowth:String = growth[statesPlant]

var Name = "Planti"
@export var stateMachine:StateMachine

var currentState : State

@export var _animated_sprite:AnimatedSprite2D

var indexIdle = 1
var count = 4
# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("plant_created",self)
	currentState = stateMachine.current_state
#	_animated_sprite.play("growth")

func _selected():
	pass
#	_animated_sprite.play(currentGrowth+"growth")


func getCurrentGrowth() -> String:
	return currentGrowth.to_lower()


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
	_animated_sprite.play(getCurrentGrowth()+"_"+"happy")
	addMultiplier()
	emit_signal("on_end_cicle")
	#_GROW = _MAX_GROW +1
	#checkIsGrowPlant()
	

func giveWater():
	_HYDROUS += 1
	addMultiplier()
	emit_signal("on_end_cicle")

func giveMusic():
	addMultiplier()
	emit_signal("on_end_cicle")

func giveLove():
	addMultiplier()
	emit_signal("on_end_cicle")

func Clear():
	_DIRTY -= 1
	_HAPPINESS +=1
	emit_signal("on_end_cicle")

func downgradeGrowth():
	_GROW -= 1

func passTime():
	_HAPPINESS = clamp(_HAPPINESS-1,0,8)
	_HYDROUS = clamp(_HYDROUS-1,0,8)
#	if _HYDROUS < 7:
#		_animated_sprite.play("dry")
	_SUNNY = clamp(_SUNNY-1,0,8)
	_DIRTY = clamp(_DIRTY+1,0,8)
	_ENTERTAINMENT =clamp(_ENTERTAINMENT+1,0,8)
	emit_signal("on_end_cicle")

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
func _on_timer_timeout():
	if(_GROW < _MAX_GROW and !isDiying):
		_GROW = clamp(_GROW + (1*multiplier),0,_MAX_GROW)
		print("GROWTH: ",_GROW)
	elif(isDiying):
#		_LIFE -=1 
		_LIFE = clamp(_LIFE-1,0,8)
		if(_LIFE<= 0):
			get_parent().emit_signal("plantDead")
			
	checkIsGrowPlant();

func checkIsGrowPlant():
	if(_GROW >= _MAX_GROW):
		statesPlant = clamp((statesPlant+1),0,growth.size())
		currentGrowth = growth[statesPlant]
		_GROW = 0
		_animated_sprite.visible = false
		_animated_sprite.stop()
		var animation_path = getCurrentGrowth()+"_animations"
		_animated_sprite = get_node(animation_path);
		_animated_sprite.visible = true
		emit_signal("on_transition")

