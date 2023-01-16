extends KinematicBody2D

export(int) var ACCELERATION = 100
export(int) var MAX_SPEED = 50

var motion = Vector2.ZERO

onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer

func _ready():
	set_physics_process(false)

func _physics_process(delta):
	var player = Utils.Player
	if player != null:
		chase_player(player, delta)

func chase_player(player, delta):
	var direction = (player.global_position - global_position).normalized()
	motion += direction * ACCELERATION  * delta
	motion = motion.limit_length(MAX_SPEED)
	sprite.flip_h = global_position > player.global_position
	motion = move_and_slide(motion)

func _on_Detection_body_entered(body):
	set_physics_process(true)
	animationPlayer.play("Search")

func _on_Hitbox_body_entered(body):
	Utils.emit_signal("player_hit")
	set_physics_process(false)
	animationPlayer.play("Idle")
	#queue_free()
