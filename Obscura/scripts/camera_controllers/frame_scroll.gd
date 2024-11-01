class_name AutoScrollCamera
extends CameraControllerBase

@export var top_left: Vector2  # Top Left corner of the frame border box
@export var bottom_right: Vector2  # Bottom right corner of the frame border box
@export var autoscroll_speed: Vector3 = Vector3(3, 0, 5)  # Autoscroll speed on the x and z axes


func _ready() -> void:
	super._ready()

func _process(delta: float) -> void:
	if !current:
		return  

	# Perform autoscrolling on x and z axes
	global_position.x += autoscroll_speed.x * delta
	global_position.z += autoscroll_speed.z * delta

	# push target from the boundaries to keep in frame
	push_target()

func push_target() -> void:
	var tpos = target.global_transform.origin
	var frame_left = global_position.x + top_left.x
	var frame_right = global_position.x + bottom_right.x
	var frame_top = global_position.z + top_left.y
	var frame_bottom = global_position.z + bottom_right.y

	# Check and adjust target position based on frame boundaries
	if tpos.x <= frame_left - 27:
		target.global_transform.origin.x = tpos.x + 1
	if tpos.x >= frame_right + 27:
		target.global_transform.origin.x = tpos.x - 1
	if tpos.z <= frame_top - 15:
		target.global_transform.origin.z = tpos.z + 1
	if tpos.z >= frame_bottom + 15:
		target.global_transform.origin.z = tpos.z - 1
