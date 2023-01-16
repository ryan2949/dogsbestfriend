extends Area2D

const HitEffect = preload("res://Effects/HitEffect.tscn")
const BoomSound = preload("res://Music/BoomSound.tscn")

export(String) var part = ""

func _on_PartObject_body_entered(_body):
	Utils.instance_scene_on_main(BoomSound,global_position)
	match part:
		"Head":
			Utils.has_head = true
			Utils.emit_signal("update_parts_collected")
		"LeftArm":
			Utils.has_left_arm = true
			Utils.emit_signal("update_parts_collected")
		"RightArm":
			Utils.has_right_arm = true
			Utils.emit_signal("update_parts_collected")
		"Body":
			Utils.has_body = true
			Utils.emit_signal("update_parts_collected")
		"LeftLeg":
			Utils.has_left_leg = true
			Utils.emit_signal("update_parts_collected")
		"RightLeg":
			Utils.has_right_leg = true
			Utils.emit_signal("update_parts_collected")
	Utils.instance_scene_on_main(HitEffect,global_position)
	queue_free()
