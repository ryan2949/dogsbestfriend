extends Node2D

func _ready():
	set_physics_process(false)

func _physics_process(delta):
	if Input.is_action_just_released("ui_accept") or Input.is_action_just_released("ui_cancel"):
		get_tree().change_scene("res://UI/StartMenu.tscn")

func return_to_menu():
	set_physics_process(true)
