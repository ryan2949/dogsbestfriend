extends Camera2D

var shake = 0

onready var timer = $Timer

func _ready():
	set_process(false)
# warning-ignore:return_value_discarded
	Utils.connect("shake_screen", self, "_on_Utils_shake_screen")

func _process(_delta):
	offset_h = rand_range(-shake, shake)
	offset_v = rand_range(-shake, shake)

func shake_screen(amount, duration):
	shake = amount
	timer.wait_time = duration
	timer.start()

func _on_Utils_shake_screen(amount, duration):
	set_process(true)
	shake_screen(amount, duration)

func _on_Timer_timeout():
	set_process(false)
	shake = 0
