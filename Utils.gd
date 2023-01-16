extends Node

const MAX_TEMP = 60
const SLOW_WEATHER_SPEED = 4
const MILD_WEATHER_SPEED = 2
const FAST_WEATHER_SPEED = 1

var Player = null

var has_head = false
var has_left_arm = false
var has_right_arm = false
var has_body = false
var has_left_leg = false
var has_right_leg = false

onready var temperature : int = MAX_TEMP setget change_temperature
onready var difficulty_weather_speed = MILD_WEATHER_SPEED

# warning-ignore:unused_signal
signal shake_screen(amount, duration)
signal temperature_drop
signal temperature_reset
signal player_hit
signal update_parts_collected
signal pause_timer(value)
signal close_curtains

func change_temperature(value):
	temperature = clamp(value, 0, MAX_TEMP)
	
	if temperature%15 == 0: # every time temperature changes by 15 degrees
		emit_signal("temperature_drop")

func instance_scene_on_main(scene, position):
	var main = get_tree().current_scene
	var instance = scene.instance()
	
	main.add_child(instance)
	instance.global_position = position
	return instance
