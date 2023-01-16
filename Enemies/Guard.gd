extends KinematicBody2D

export(int) var ACCELERATION = 500
export(int) var MAX_SPEED = 50

var motion = Vector2.ZERO

onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer
onready var vision = $Vision
onready var timer = $Timer

func _physics_process(delta):
	if vision.is_colliding():
		var position = vision.get_collider().global_position
		timer.paused = true
		chase_player(position,delta)
	elif timer.paused == true: # and player not in vision
		animationPlayer.play("Idle")
		timer.paused = false

func chase_player(player_position, delta):
	animationPlayer.play("Walk")
	var direction = (player_position - global_position).normalized()
	motion = direction * ACCELERATION  * delta * 10
	motion.y = 0
	motion = motion.limit_length(MAX_SPEED)
	motion = move_and_slide(motion)

func _on_Timer_timeout():
	scale.x *= -1


func _on_Hitbox_body_entered(body):
	Utils.emit_signal("player_hit")
	#queue_free()
