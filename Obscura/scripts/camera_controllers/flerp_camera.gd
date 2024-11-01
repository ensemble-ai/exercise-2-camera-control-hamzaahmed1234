class_name FlerpCamera
extends CameraControllerBase

@export var lead_speed: float = 60.0  # The speed at which the camera moves toward the direction of the input. 
@export var catchup_delay_duration: float = 1.0 # The time delay between when the target stops moving and when the camera starts to catch up to the target. 
@export var catchup_speed: float = 5.0  # When the player has stopped, what speed shoud the camera move to match the vesse's position.
@export var leash_distance: float = 10.0  # The maxiumum allowed distance between the vessel and the center of the camera.

var canvas: CanvasLayer
var h_line: ColorRect
var v_line: ColorRect
var timer: float = 0.0
var last_movement: Vector2 = Vector2.ZERO

func _ready() -> void:
	canvas = CanvasLayer.new()
	add_child(canvas)
	_draw_crosshair()
	canvas.hide()  

func _draw_crosshair() -> void:
	var viewport_cross = get_viewport().get_visible_rect()
	var center = Vector2(
		viewport_cross.size.x / 2,
		viewport_cross.size.y / 2
	)

	# Initialize horizontal crosshair
	h_line = ColorRect.new()
	h_line.color = Color.WHITE
	h_line.size = Vector2(50, 1)
	h_line.position = Vector2(center.x - 25, center.y - 0.5)
	canvas.add_child(h_line)

	# Initialize vertical crosshair
	v_line = ColorRect.new()
	v_line.color = Color.WHITE
	v_line.size = Vector2(1, 50)
	v_line.position = Vector2(center.x - 0.5, center.y - 25)
	canvas.add_child(v_line)

func _process(delta: float) -> void:
	if not target:
		return

	if current:
		canvas.show()
	else:
		canvas.hide()

	var movement = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()

	if movement.length() > 0:
		last_movement = movement
		timer = 0
		var offset = Vector3(movement.x, 0, movement.y) * leash_distance
		var tpos = target.global_position + offset
		var direction = tpos - global_position
		direction.y = 0
		global_position += direction.normalized() * min(direction.length(), lead_speed * delta)
	else:
		timer += delta
		if timer >= catchup_delay_duration:
			var direction = target.global_position - global_position
			direction.y = 0
			global_position += direction.normalized() * min(direction.length(), catchup_speed * delta)

	# Ensure the target does not go outside of the frame
	var direction_of_target = target.global_position - global_position
	if direction_of_target.length() > leash_distance:
		global_position += direction_of_target.normalized() * (direction_of_target.length() - leash_distance)

	# Update  position
	global_position.y = target.global_position.y + dist_above_target

func draw_logic() -> void:
	if draw_camera_logic:
		h_line.visible = true
		v_line.visible = true
	else:
		h_line.visible = false
		v_line.visible = false
