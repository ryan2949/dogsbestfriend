extends Area2D

export(Resource) var connection = null
export(String, FILE, "*.tscn") var new_map_path = ""

var active = true

func _on_Door_body_entered(Player):
	if active:
		Player.emit_signal("hit_door", self)
		active = false
