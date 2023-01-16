extends Node2D

var player = null

onready var currentMap = $House
onready var camera = $Camera

func _ready():
	VisualServer.set_default_clear_color(Color(0.290196, 0.141176, 0.501961))
	Utils.Player.connect("hit_door", self, "_on_Player_hit_door")
	Utils.connect("player_hit", self, "_on_Player_Hit_Enemy")
	player = Utils.Player
	update_camera_limits()
	check_timer()

func change_map(door):
	var offset = currentMap.position
	var music_position = currentMap.audio.get_playback_position()
	var music = currentMap.audio.get_stream()
	currentMap.queue_free()
	var NewLevel = load(door.new_map_path) # uppercase for packed scene
	var newLevel = NewLevel.instance() # camel case for instanced scene
	add_child(newLevel)
	var newDoor = get_door_with_connection(door, door.connection)
	var exit_position = newDoor.position - offset
	newLevel.position = door.position - exit_position
	currentMap.show_behind_parent = true
	update_camera_limits()
	check_timer()
	if currentMap.audio.get_stream() == null or currentMap.audio.get_stream() == music:
		currentMap.audio.set_stream(music)
		currentMap.audio.play(music_position)

func get_door_with_connection(enteredDoor, connection):
	var doors = get_tree().get_nodes_in_group("Door")
	for door in doors:
		if door.connection == connection and door != enteredDoor:
			return door
	# else
	return null

func _on_Player_hit_door(door):
	call_deferred("change_map", door)

func _on_Player_Hit_Enemy():
	#call_deferred("change_scene", currentMap)
	player.global_position = currentMap.defaultPlayerPosition.global_position

# creates limits for camera based on room size
func update_camera_limits():
	# in inherited scene setup, they are in this order
	var top_left = currentMap.get_child(0).global_position
	var bottom_right = currentMap.get_child(1).global_position
	camera.limit_top = top_left.y
	camera.limit_left = top_left.x
	camera.limit_bottom = bottom_right.y
	camera.limit_right = bottom_right.x

func check_timer():
	Utils.emit_signal("pause_timer", currentMap.pause_timer)
