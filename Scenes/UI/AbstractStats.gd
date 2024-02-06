extends Control
class_name Stats

@onready var stat:AnimatedSprite2D = $stat

func playLevel(level:int):
	stat.play(str(clamp(level,0,8)))
