extends Control

var zoom_increment = Vector2(0.001, 0.001)
var base_zoom = Vector2(0.1, 0.1)
var speed = 1000
var rotate_speed = 0.2

var base_camera_position = Vector2(3000, 2000)

@onready
var camera = $Camera2D
@onready
var draggable = $Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	camera.position = base_camera_position
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Using this to keep labels of state up-to-date.
	# It's horribly inefficient, but this is a repro case for an error, not my game.
	var zoom = camera.get_zoom()
	$CanvasLayer/BoxContainer/ZoomLabel.set_text("Zoom: %.3v" % [zoom])
	var pos = camera.position
	$CanvasLayer/BoxContainer/PosLabel.set_text("Camera Pos: %.1v" % [pos])
	var dpos = draggable.position
	$CanvasLayer/BoxContainer/DraggablePosLabel.set_text("Draggable Pos: %.1v" % [dpos])
	var mpos = get_global_mouse_position()
	$CanvasLayer/BoxContainer/MousePosLabel.set_text("Mouse Pos: %.1v" % [mpos])
	
	if Input.is_action_pressed("pan_left"):
		camera.position += Vector2.LEFT * speed * delta
	if Input.is_action_pressed("pan_right"):
		camera.position += Vector2.RIGHT * speed * delta
	if Input.is_action_pressed("pan_up"):
		camera.position += Vector2.UP * speed * delta
	if Input.is_action_pressed("pan_down"):
		camera.position += Vector2.DOWN * speed * delta
	if Input.is_action_pressed("rotate_clockwise"):
		print("clockwise")
		camera.rotation -= rotate_speed * delta
	if Input.is_action_pressed("rotate_counterclockwise"):
		print("counterclockwise")
		camera.rotation += rotate_speed * delta

func _on_popup_menu_id_pressed(id):
	match id:
		0:	# Default Zoom
			camera.set_zoom(base_zoom)
		1:	# No Zoom
			camera.set_zoom(Vector2.ONE)
		2:	# Recenter Camera
			camera.position = base_camera_position
		3:	# Recenter Draggable
			draggable.position = base_camera_position

func _unhandled_input(event):
	if event.is_action_pressed("zoom_in"):
		var zoom = camera.get_zoom()
		camera.set_zoom(zoom + zoom_increment)
	if event.is_action_pressed("zoom_out"):
		var zoom = camera.get_zoom()
		camera.set_zoom(zoom - zoom_increment)
		
