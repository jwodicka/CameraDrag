extends Control

var zoom_increment = Vector2(0.001, 0.001)
var base_zoom = Vector2(0.1, 0.1)
var speed = 1000

var base_camera_position = Vector2(3000, 2000)

@onready
var camera = $SubViewportContainer/SubViewport/Camera2D

# Called when the node enters the scene tree for the first time.
func _ready():
	camera.position = base_camera_position
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Using this to keep labels of state up-to-date.
	# It's horribly inefficient, but this is a repro case for an error, not my game.
	var zoom = camera.get_zoom()
	$BoxContainer/ZoomLabel.set_text("Zoom: %.3v" % [zoom])
	var pos = camera.position
	$BoxContainer/PosLabel.set_text("Camera Pos: %.1v" % [pos])
	
	if Input.is_action_pressed("pan_left"):
		camera.position += Vector2.LEFT * speed * delta
	if Input.is_action_pressed("pan_right"):
		camera.position += Vector2.RIGHT * speed * delta
	if Input.is_action_pressed("pan_up"):
		camera.position += Vector2.UP * speed * delta
	if Input.is_action_pressed("pan_down"):
		camera.position += Vector2.DOWN * speed * delta

func _on_popup_menu_id_pressed(id):
	match id:
		0:	# Default Zoom
			camera.set_zoom(base_zoom)
		1:	# No Zoom
			camera.set_zoom(Vector2.ONE)
		2:	# Recenter Camera
			camera.position = base_camera_position

func _on_gui_input(event):
	if event.is_action_pressed("zoom_in"):
		var zoom = camera.get_zoom()
		camera.set_zoom(zoom + zoom_increment)
	if event.is_action_pressed("zoom_out"):
		var zoom = camera.get_zoom()
		camera.set_zoom(zoom - zoom_increment)
		
