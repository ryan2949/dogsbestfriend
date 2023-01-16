extends "res://Maps/Map.gd"

const AppearEffect = preload("res://Effects/AppearEffect.tscn")
const BoomSound = preload("res://Music/BoomSound.tscn")

var parts_held = 0

onready var rightArmCoords = $RightArmCoords
onready var leftArmCoords = $LeftArmCoords
onready var headCoords = $HeadCoords
onready var bodyCoords = $BodyCoords
onready var leftLegCoords = $LeftLegCoords
onready var rightLegCoords = $RightLegCoords

onready var allPartsFound = $AllPartsFound
onready var robot = $Robot
onready var animationPlayer = $AnimationPlayer
onready var curtainTimer = $CurtainTimer

func _ready():
	parts_held = 0
	if Utils.has_right_arm:
		rightArmCoords.visible = true
		parts_held += 1
	if Utils.has_left_arm:
		leftArmCoords.visible = true
		parts_held += 1
	if Utils.has_head:
		headCoords.visible = true
		parts_held += 1
	if Utils.has_body:
		bodyCoords.visible = true
		parts_held += 1
	if Utils.has_left_leg:
		leftLegCoords.visible = true
		parts_held += 1
	if Utils.has_right_leg:
		rightLegCoords.visible = true
		parts_held += 1
	
	if parts_held == 6:
		allPartsFound.visible = true
		allPartsFound.monitoring = true


func _on_AllPartsFound_body_entered(_body):
	
	Utils.Player.global_position = defaultPlayerPosition.global_position
	Utils.Player.set_physics_process(false)
	
	allPartsFound.queue_free()
	rightLegCoords.visible = false
	leftLegCoords.visible = false
	bodyCoords.visible = false
	headCoords.visible = false
	rightArmCoords.visible = false
	leftArmCoords.visible = false
	Utils.instance_scene_on_main(BoomSound,global_position)
	Utils.instance_scene_on_main(AppearEffect, robot.global_position)
	robot.visible = true
	animationPlayer.play("boot_robot")
	
	curtainTimer.start()

func _on_CurtainTimer_timeout():
	Utils.emit_signal("close_curtains")
