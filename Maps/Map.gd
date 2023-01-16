extends Node2D

const WORLD = preload("res://World/World.gd")

export(bool) var pause_timer = false

onready var defaultPlayerPosition = $DefaultPlayerPosition
onready var audio = $Audio

func _ready():
	var parent = get_parent()
	if parent is WORLD:
		parent.currentMap = self


func _on_Audio_finished():
	audio.play(0.0)
