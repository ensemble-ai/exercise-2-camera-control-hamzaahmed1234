class_name PlerpCamera
extends CameraControllerBase

@export var follow_speed: float = 5.0  # The speed at which the camera follows the player when the player is moving
@export var catchup_speed: float = 10.0  # When the player has stopped, what speed shoud the camera move to match the vesse's position.
@export var leash_distance: float = 10.0  # The maxiumum allowed distance between the vessel and the center of the camera.

var canvas: CanvasLayer
var h_line: ColorRect
var v_line: ColorRect

func _ready() -> void:
	super._ready()
	
	canvas = CanvasLayer.new()
	add_child(canvas)

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
	v_line.position = Vector2(center.x - 0.1, center.y - 25)
	canvas.add_child(v_line)

func _process(delta: float) -> void:
	# Always update the visibility of the canvas based on the 'current' state of the camera
	h_line.visible = current
	v_line.visible = current
	
	if not current:
		return
		
	var movement_speed = follow_speed if target.velocity.length() > 0 else catchup_speed

	# Calculate target offset
	var offset = target.position - position
	offset.y = 0

	# Adjust movement
	if offset.length() > leash_distance:
		position += offset.normalized() * (offset.length() - leash_distance)
	else:
		position += offset * (movement_speed * delta)

	# Update height
	position.y = target.position.y + dist_above_target
	
	# Call draw_logic to handle all drawing-related updates
	draw_logic()
	
func draw_logic() -> void:
	
	# Update crosshair positions based on the viewport size
	var viewport_width = get_viewport().size.x / 2
	var viewport_height = get_viewport().size.y / 2

	
