extends Node


var _seeds = {
};

var _pots = {
"pot1":"res://Resources/Textures/flowerpot1.png",
"pot2":"res://Resources/Textures/flowerpot2.png",
"pot3":"res://Resources/Textures/flowerpot3.png"
}

var main = load("res://Scenes/main.tscn")
var intro = load("res://Scenes/Intro.tscn")
var potSelector = load("res://Scenes/Game/pot_selector.tscn")


var items = [
	{ "Name": "Green","scn": "res://Scenes/Game/Pots/med/pot_green.tscn", "img":"res://Resources/Textures/flowerpot1.png", "maxSize":SizesEnum.Sizes.MEDIUM},
	{"Name": "Pink","scn": "res://Scenes/Game/Pots/med/pot_pink.tscn", "img":"res://Resources/Textures/flowerpot2.png", "maxSize":SizesEnum.Sizes.MEDIUM},
	{"Name": "Lightblue","scn": "res://Scenes/Game/Pots/med/pot_lightblue.tscn", "img":"res://Resources/Textures/flowerpot3.png", "maxSize":SizesEnum.Sizes.MEDIUM},
	{"Name": "Big Blue","scn": "res://Scenes/Game/Pots/big/bigPot1.tscn", "img":"res://Resources/Textures/icons/icon-pot2.png", "maxSize":SizesEnum.Sizes.BIG},
	{"Name": "Premiun Pot","scn": "res://Scenes/Game/Pots/big/bigPot2.tscn", "img":"res://Resources/Textures/icons/icon-pot3.png", "maxSize":SizesEnum.Sizes.BIG},
	]
enum Levels {
	INTRO=0,
	POTSEL,
	MAIN}

var allLevels:Array[PackedScene];

var current_level

var indexPot = 0

var firstTime = true

var cantSeeds= 1
# Called when the node enters the scene tree for the first time.

signal update_seed

func addLevelsManually():
	allLevels.push_back(intro) #0
	allLevels.push_back(potSelector) #1
	allLevels.push_back(main) #2

func _ready():
	addLevelsManually()
	current_level = allLevels[0].instantiate()
	add_child(current_level)

func _changeLevel(index):
	remove_child(current_level)
	current_level = allLevels[index].instantiate()
	add_child(current_level)

func addSeed(ammount):
	cantSeeds += ammount
	emit_signal("update_seed")
	
func useSeed():
	cantSeeds -= 1
	emit_signal("update_seed")
func _addSeeds(ammount,type_seed:seeds_type.seedType):
	for _seed in _seeds:
		if(_seed == type_seed):
			_seeds[_seed] += ammount
			print("ammount:",_seeds[_seed])
			return
	_seeds[type_seed] = ammount
	print(_seeds)
		

func _getSeedsAmmount():
	return _seeds.values()

func getCurrentPot():
	if(indexPot >= _pots.size()): indexPot = 0
	if(indexPot < 0): indexPot = _pots.size()-1
	
	print(_pots[str("pot"+str(indexPot+1))])
	return _pots[str("pot"+str(indexPot+1))]

func _nextPot():
	indexPot += 1
	if(indexPot >= _pots.size()): indexPot = 0
#	indexPot = clamp(indexPot+1,0,_pots.size()-1)
	pass

func _prevPot():
	indexPot -= 1
	if(indexPot < 0): indexPot = _pots.size()-1
#	indexPot = clamp(indexPot-1,0,_pots.size()-1)
	pass
