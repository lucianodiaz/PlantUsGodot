extends Control
class_name Stats

@onready var stat:AnimatedSprite2D = $stat

func playLevel(level:float):
	print("lvl: ",ceil(level))
	stat.play(str(clamp(ceil(level),0,8)))
