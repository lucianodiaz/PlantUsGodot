extends Node
class_name Plant

const FPS = 60;

signal plant_created
signal on_transition

var _HAPPINESS = 10;

var _ENTERTAINMENT = 10;

var _HYDROUS = 10;

var _LIFE = 10;

var _SUNNY = 10;

var _DIRTY = 0;

var _GROW = 0;

var _MAX_GROW = 10;

var multiplier = 1;

var isDiying = false

var statesPlant = 0 #max 3

var growth = ["tiny","med","big"]

var currentGrowth:String = growth[statesPlant]

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
	_GROW = _MAX_GROW +1
	checkIsGrowPlant()
	

func giveWater():
	_HYDROUS += 1
	addMultiplier()

func giveMusic():
	addMultiplier()

func giveLove():
	addMultiplier()

func Clear():
	_DIRTY -= 1
	_HAPPINESS +=1

func downgradeGrowth():
	_GROW -= 1

func passTime():
	_HAPPINESS = clamp(_HAPPINESS-1,0,10)
	_HYDROUS = clamp(_HYDROUS-1,0,10)
#	if _HYDROUS < 7:
#		_animated_sprite.play("dry")
	_SUNNY = clamp(_SUNNY-1,0,10)
	_DIRTY = clamp(_DIRTY+1,0,10)
	_ENTERTAINMENT =clamp(_ENTERTAINMENT+1,0,10)

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


func _on_timer_timeout():
	if(_GROW < _MAX_GROW and !isDiying):
		_GROW += (1*multiplier)
		print("GROWTH: ",_GROW)
	elif(isDiying):
#		_LIFE -=1 
		_LIFE = clamp(_LIFE-1,0,10)
		if(_LIFE<= 0):
			get_parent().emit_signal("plantDead")
			
	checkIsGrowPlant();

func checkIsGrowPlant():
	if(_GROW > _MAX_GROW):
		statesPlant = 1
		currentGrowth = growth[statesPlant]
		_GROW = 0
		_animated_sprite.visible = false
		_animated_sprite.stop()
		var animation_path = getCurrentGrowth()+"_animations"
		_animated_sprite = get_node(animation_path);
		_animated_sprite.visible = true
		emit_signal("on_transition")

