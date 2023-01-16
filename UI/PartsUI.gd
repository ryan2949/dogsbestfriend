extends Control

onready var body = $PartsFrame/Body
onready var leftArm = $PartsFrame/LeftArm
onready var rightArm = $PartsFrame/RightArm
onready var head = $PartsFrame/Head
onready var leftLeg = $PartsFrame/LeftLeg
onready var rightLeg = $PartsFrame/RightLeg

func _ready():
	Utils.connect("update_parts_collected", self, "_on_Utils_Update_Parts")

func _on_Utils_Update_Parts():	
	if Utils.has_body:
		body.visible = true
	
	if Utils.has_left_arm:
		leftArm.visible = true
	
	if Utils.has_right_arm:
		rightArm.visible = true
	
	if Utils.has_head:
		head.visible = true
	
	if Utils.has_left_leg:
		leftLeg.visible = true
	
	if Utils.has_right_leg:
		rightLeg.visible = true

#var has_head = false
#var has_left_arm = false
#var has_right_arm = false
#var has_body = false
#var has_left_leg = false
#var has_right_leg = false
