extends CanvasLayer

onready var animationPlayer = $AnimationPlayer

func _ready():
# warning-ignore:return_value_discarded
	Utils.connect("close_curtains", self, "_on_Utils_Close_Curtains")

func _on_Utils_Close_Curtains():
	animationPlayer.play("CloseCurtains")


# warning-ignore:unused_argument
func _on_AnimationPlayer_animation_finished(CloseCurtains):
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://UI/Credits.tscn")
