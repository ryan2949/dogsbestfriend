extends Area2D

func _on_Spike_body_entered(body):
	Utils.emit_signal("player_hit")
