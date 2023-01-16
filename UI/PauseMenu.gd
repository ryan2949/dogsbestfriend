extends ColorRect

var paused = false setget set_paused

func set_paused(value):
	paused = value
	get_tree().paused = paused
	visible = paused

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		self.paused = !paused

func _on_ResumeButton_pressed():
	self.paused = false

func _on_SlowButton_pressed():
	Utils.difficulty_weather_speed = Utils.SLOW_WEATHER_SPEED

func _on_MildButton_pressed():
	Utils.difficulty_weather_speed = Utils.MILD_WEATHER_SPEED

func _on_FastButton_pressed():
	Utils.difficulty_weather_speed = Utils.FAST_WEATHER_SPEED
