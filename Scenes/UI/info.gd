extends Control

@export var water:Stats
@export var love:Stats
@export var sun:Stats
@export var animationPlayer:AnimationPlayer

func onPotDeselected():
	animationPlayer.play_backwards("IN")
	var tween:Tween = get_tree().create_tween()
	# Agregar interpolaciones para cada nodo
	tween.tween_property($stats/love, "position", Vector2(0,0), 0.1).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	tween.tween_property($stats/water, "position", Vector2(0,0), 0.1).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	tween.tween_property($stats/sun, "position", Vector2(0,0), 0.1).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	
	# Iniciar el tween
	tween.play()
	
func onPotSelected(pot:Flowerpot):
	
	var plant:Plant = pot.getPlant()
	setName(plant.getName())
	setLoveLevel(plant.getHappiness())
	setWaterLevel(plant.getHydrous())
	setSunLevel(plant.getSunny())
	
	#animationPlayer.speed_scale = 0
	#animationPlayer.play("IN")
	var tween:Tween = get_tree().create_tween()
	# Agregar interpolaciones para cada nodo
	tween.tween_property($stats/love, "position", Vector2(0,0), 0)
	tween.tween_property($stats/water, "position", Vector2(0,0), 0)
	tween.tween_property($stats/sun, "position", Vector2(0,0), 0)
	
	tween.tween_property($stats/love, "position", Vector2(59,-215), 0.3).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	tween.tween_property($stats/water, "position", Vector2(167,-138), 0.3).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	tween.tween_property($stats/sun, "position", Vector2(206,-11), 0.3).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	
	# Iniciar el tween
	tween.play()

func onPotUpdate(pot:Flowerpot):
	var plant:Plant = pot.getPlant()
	setLoveLevel(plant.getHappiness())
	setWaterLevel(plant.getHydrous())
	setSunLevel(plant.getSunny())

func setName(name:String):
	$miniatura/name.text = "[center]%s[/center]"%name
	

func setWaterLevel(level:int):
	water.playLevel(level)
	

func setLoveLevel(level:int):
	love.playLevel(level)
	

func setSunLevel(level:int):
	sun.playLevel(level)
