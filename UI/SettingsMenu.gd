extends Control


func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene("res://UI/StartMenu.tscn")
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://UI/StartMenu.tscn")


func _on_SlowButton_pressed():
	Utils.difficulty_weather_speed = Utils.SLOW_WEATHER_SPEED


func _on_MildButton_pressed():
	Utils.difficulty_weather_speed = Utils.MILD_WEATHER_SPEED


func _on_FastButton_pressed():
	Utils.difficulty_weather_speed = Utils.FAST_WEATHER_SPEED


func _on_Button_pressed():
	get_tree().change_scene("res://UI/StartMenu.tscn")
