extends Control

onready var audio = $AudioStreamPlayer

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://World/World.tscn")
	if Input.is_action_just_pressed("ui_cancel"):
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://UI/SettingsMenu.tscn")

func _on_StartButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://World/World.tscn")


func _on_SettingsButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://UI/SettingsMenu.tscn")


func _on_AudioStreamPlayer_finished():
	audio.play(0.0)
