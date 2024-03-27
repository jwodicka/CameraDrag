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
			position = get_global_mouse_position() - drag_offset
	else:
		end_drag()
	
func begin_drag():
	is_dragging = true;
	drag_offset = get_global_mouse_position() - position
	
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
	

