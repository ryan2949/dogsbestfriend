extends KinematicBody2D

const JumpEffect = preload("res://Effects/JumpEffect.tscn")

export(int) var ACCELERATION = 512
export(int) var MAX_SPEED = 75
export(float) var FRICTION = 0.25
export(float) var FRICTION_DROP = 0.5
export(int) var GRAVITY = 200
export(int) var JUMP_STRENGTH = 128

var motion = Vector2.ZERO
var just_jumped = false
var snap_onto = Vector2.ZERO

onready var coyoteJumpTimer = $CoyoteJumpTimer
onready var wallBounceTimer = $WallBounceTimer
onready var animationPlayer = $AnimationPlayer
onready var sprite = $Sprite

# warning-ignore:unused_signal
signal hit_door(door)

func _ready():
# warning-ignore:return_value_discarded
	Utils.connect("temperature_drop", self, "_on_temperature_drop")
	Utils.connect("temperature_reset", self, "_on_temperature_reset")
	Utils.Player = self

func _exit_tree():
	Utils.Player = null

# main
func _physics_process(delta):
	just_jumped = false
	
	var input_vector = get_input_vector()
	apply_horizontal_motion(input_vector, delta)
	apply_friction(input_vector)
	apply_gravity(delta)
	update_snap_onto()
	jump_check()
	update_animations(input_vector)
	move()

#******************************
# if pressing nothing: 0 - 0 = 0 | if pressing both: 1 - 1 = 0
# if pressing right:   1 - 0 = 1 | if pressing left: 0 - 1 = -1
#******************************
func get_input_vector():
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	return input_vector

func apply_horizontal_motion(input_vector, delta):
	if input_vector.x != 0: 
		motion.x += input_vector.x * ACCELERATION * delta
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)

func apply_friction(input_vector):
	if input_vector.x == 0 and is_on_floor():
		motion.x = lerp(motion.x, 0, FRICTION)

func _on_temperature_drop():
	FRICTION *= FRICTION_DROP

func _on_temperature_reset():
	FRICTION = 0.25

#******************************
# y axis is reversed in engine, increasing it moves downwards
#******************************
func apply_gravity(delta):
	if not is_on_floor():
		motion.y += GRAVITY * delta
		motion.y = min(motion.y, JUMP_STRENGTH)

func update_snap_onto():
	if is_on_floor():
		snap_onto = Vector2.DOWN

func jump_check():
	if is_on_floor() or coyoteJumpTimer.time_left > 0:
		if Input.is_action_just_pressed("ui_up"):
			jump()
			just_jumped = true
	# hold jump to jump higher
	else:
		if Input.is_action_just_released("ui_up") and motion.y < -JUMP_STRENGTH/2:
			motion.y = -JUMP_STRENGTH/2
		if is_on_wall() and not is_on_floor() and wallBounceTimer.time_left == 0:
			wallBounceTimer.start()
			motion.y -= MAX_SPEED
			motion.x *= MAX_SPEED/2
			motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)

func jump():
	Utils.instance_scene_on_main(JumpEffect, global_position)
	motion.y -= JUMP_STRENGTH
	# unsnaps player from ground
	snap_onto = Vector2.ZERO

func update_animations(input_vector):
	var facing_direction = sign(motion.x)
	if facing_direction != 0:
		sprite.scale.x = facing_direction
	if input_vector.x != 0:
		animationPlayer.play("Run")
		animationPlayer.playback_speed = input_vector.x * sprite.scale.x
	else:
		animationPlayer.playback_speed = 0.6
		animationPlayer.play("Idle")
	
	# must come last, as it overrides above checks
	if not is_on_floor():
		animationPlayer.play("Jump")

func move():
	# stores data of frame before moving and updating to next physics frame
	var was_in_air = not is_on_floor()
	var was_on_floor = is_on_floor()
	var last_motion = motion
	var last_position = position
	
	motion = move_and_slide_with_snap(motion, snap_onto *4, Vector2.UP, true, 4, deg2rad(46))
	
	# defines landing
	if was_in_air and is_on_floor():
		motion.x = last_motion.x
	# defines if just left the ground
	if was_on_floor and not is_on_floor() and not just_jumped:
		motion.y = 0
		position.y = last_position.y
		coyoteJumpTimer.start()


func _on_VisibilityNotifier2D_screen_exited():
	Utils.emit_signal("player_hit")
