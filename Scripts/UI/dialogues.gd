extends CanvasLayer
class_name DialogueMessage

var animationPlayer:AnimationPlayer
var richText:RichTextLabel
@export var codeText:String = "[center][font_size=32][color=black]"
func _ready():
	animationPlayer = get_node("animationPlayer")
	assert(animationPlayer,"animation player doesn't exist")
	richText = get_node("control/text")


func _showDialog(text:String=""):
	if text != "":
		richText.text = str(codeText+text)
	animationPlayer.play("in")
	await(animationPlayer.animation_finished)
	animationPlayer.play_backwards("in")


