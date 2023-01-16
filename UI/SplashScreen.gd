extends Control

var times_timed_out = 0

onready var VBox1 = $CenterContainer/VBox1
onready var VBox2 = $CenterContainer/VBox2

func _on_Timer_timeout():
	times_timed_out += 1
	
	if times_timed_out == 2:
		get_tree().change_scene("res://UI/StartMenu.tscn")
	
	# else
	VBox1.visible = false
	VBox2.visible = true
