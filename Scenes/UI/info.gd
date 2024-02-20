extends CanvasLayer

class_name InfoPlant

@export var water:Stats
@export var love:Stats
@export var sun:Stats
@export var animationPlayer:AnimationPlayer

func onPotDeselected():
	$stats/love.position = Vector2(0,0)
	$stats/water.position = Vector2(0,0)
	$stats/sun.position = Vector2(0,0)
	visible = false
	
func onPotSelected(pot:Flowerpot):
	var plant:Plant = pot.getPlant()
	if !plant:
		return
	setName(plant.getName())
	setLoveLevel(plant.getHappiness())
	setWaterLevel(plant.getHydrous())
	setSunLevel(plant.getSunny())
	
	#animationPlayer.speed_scale = 0
	#animationPlayer.play("IN")
	var tween:Tween = get_tree().create_tween()
	# Agregar interpolaciones para cada nodo
	$stats/love.position = Vector2(0,0)
	$stats/water.position = Vector2(0,0)
	$stats/sun.position = Vector2(0,0)
	
	tween.tween_property($stats/love, "position", Vector2(59,-215), 0.3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property($stats/water, "position", Vector2(167,-138), 0.3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property($stats/sun, "position", Vector2(206,-11), 0.3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
	# Iniciar el tween
	tween.play()
	await (tween.finished)

func onPotUpdate(pot:Flowerpot):
	var plant:Plant = pot.getPlant()
	if !plant:return
	setLoveLevel(plant.getHappiness())
	setWaterLevel(plant.getHydrous())
	setSunLevel(plant.getSunny())

func setName(_name:String):
	$miniatura/name.text = "[center]%s[/center]"%_name
	

func setWaterLevel(level:float):
	water.playLevel(level)
	

func setLoveLevel(level:float):
	love.playLevel(level)
	

func setSunLevel(level:float):
	sun.playLevel(level)
