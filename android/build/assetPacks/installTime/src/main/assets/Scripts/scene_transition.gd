extends CanvasLayer
@onready var global:playerInfoScript = get_node("/root/PlayerInfoScript")
@export var animPlayer:AnimationPlayer

func _ready():
	pass


func change_scene(target:int)->void:
	animPlayer.play("transition")
	await animPlayer.animation_finished
	global._changeLevel(target)
	animPlayer.play_backwards("transition")
