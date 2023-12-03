extends Node
class_name Plant

const FPS = 60;

signal plant_created

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

var growth = ["tiny","medium","big"]

var currentGrowth:String = growth[0]

@onready var _animated_sprite = $AnimatedSprite2D

var indexIdle = 1
var count = 4
# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("plant_created",self)
#	_animated_sprite.play("growth")

func _selected():
	pass
#	_animated_sprite.play(currentGrowth+"growth")


func getCurrentGrowth() -> String:
	return currentGrowth.to_lower()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _SUNNY <= 4 or _HYDROUS <= 4 or _DIRTY > 5:
		isDiying = true
		multiplier = 1
	elif _SUNNY >= 4 and _HYDROUS >= 4 and _DIRTY < 5:
		isDiying = false

	if(_LIFE<= 0):
		get_parent().emit_signal("plantDead")
#	pass

func addMultiplier():
	if(multiplier < 1.5):
		multiplier += 0.1

func giveSun():
	_SUNNY += 1
	_animated_sprite.play(getCurrentGrowth()+"_"+"happy")
	addMultiplier()

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
#		print("GROWTH: ",_GROW)
	elif(isDiying):
#		_LIFE -=1 
		_LIFE = clamp(_LIFE-1,0,10)
#		print("Life: ",_LIFE)


