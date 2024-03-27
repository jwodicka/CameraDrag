extends Area2D

var is_dragging = false
var drag_offset = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_dragging:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			return # Don't actually move the piece!
			position = get_viewport().get_mouse_position() - drag_offset * get_viewport_transform().affine_inverse()
	else:
		end_drag()
	
func begin_drag():
	is_dragging = true;
	var viewport_position = position * get_viewport_transform()
	drag_offset = get_viewport().get_mouse_position() - viewport_position		
	
func end_drag():
	if is_dragging:
		is_dragging = false
		
func _on_input_event(viewport, event, shape_idx):
	print(viewport, event, shape_idx)
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				begin_drag()
			else:
				end_drag()
	

