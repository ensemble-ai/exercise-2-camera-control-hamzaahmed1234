class_name PositionLockCamera
extends CameraControllerBase

var canvas: CanvasLayer
var h_line: ColorRect
var v_line: ColorRect

func _ready() -> void:
	super._ready()

	# setup crosshair
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
	# Update visibility of canvas 
	h_line.visible = current
	v_line.visible = current
	
	if not current:
		return

	draw_logic()

func draw_logic() -> void:
	# Update crosshair positions 
	var viewport_width = get_viewport().size.x / 2
	var viewport_height = get_viewport().size.y / 2

	# Ensure camera follows the target 
	if target and current:
		global_position = target.global_position + Vector3(0, dist_above_target, 0)
