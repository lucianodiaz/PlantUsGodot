extends Node2D

@onready var global:playerInfoScript = get_node("/root/PlayerInfoScript")

func _ready():
	$titlepng/animationPlayer.play("enter")
	

func _on_animation_player_animation_finished(anim_name):
	if anim_name == anim_name:
		$titlepng/animationPlayer.play("idle")

func _process(delta):
	@warning_ignore("unused_parameter")
	if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("tap"):
		SceneTransition.change_scene(global.Levels.POTSEL)
