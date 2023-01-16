extends TextureProgress

onready var meter = self
onready var timer = $Timer
onready var label = $TemperatureLabel

func _ready():
	Utils.connect("pause_timer", self, "_on_Utils_Pause_Timer")
	#timer.set_wait_time(Utils.difficulty_weather_speed)

func _on_Utils_Pause_Timer(value):
	timer.paused = value
	if value:
		Utils.temperature = 60
		Utils.emit_signal("temperature_reset")
		meter.value = 0
		label.text = str(60)
	if !value and timer.time_left == 0:
		timer.start(Utils.difficulty_weather_speed)

func _on_Timer_timeout():
	meter.value += 1 # the progress of the progress bar
	var current_temp_progress = meter.value
	Utils.temperature = current_temp_progress
	# for aligned text formatting 
	if current_temp_progress < 51:
		label.text = str(60 - current_temp_progress)
	else:
		label.text = "0" + str(60 - current_temp_progress)
	
	if current_temp_progress != 60:
		timer.start(Utils.difficulty_weather_speed)
