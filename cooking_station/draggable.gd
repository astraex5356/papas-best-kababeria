extends Area2D

class_name Draggable

@export var item_type: String = ""
var dragging: bool = false
var drag_offset: Vector2 = Vector2.ZERO
var start_position: Vector2 = Vector2.ZERO

@export var on_spawn_drag: bool

var first_use = true

var meat_types = ["pork", "chicken", "beef", "lamb", "lamb_uncooked", "beef_uncooked", "chicken_uncooked", "pork_uncooked"]

func _ready() -> void:
	await get_tree().process_frame
	start_position = global_position
	if on_spawn_drag:
		dragging = true
		global_position = get_global_mouse_position()
		
func _process(_delta: float) -> void:
	if dragging:
		global_position = get_global_mouse_position() - drag_offset
	
func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			dragging = true
			drag_offset = get_local_mouse_position()
			start_position = global_position
		else:
			if dragging:
				_try_drop()
			dragging = false


func _try_drop() -> void:
	var zones: Array = get_tree().get_nodes_in_group("drop_zones")
	var dropped: bool = false

	for zone in zones:
		if zone is Area2D:
			var shape: CollisionShape2D = zone.get_node_or_null("CollisionShape2D")
			if shape and shape.shape:
				# Get the zone's bounding box in global space
				var zone_rect: Rect2 = shape.shape.get_rect()  # explicit type
				var transformed_rect: Rect2 = Rect2(shape.global_position - zone_rect.size * 0.5, zone_rect.size)
				if item_type in zone.accepts:
					if transformed_rect.has_point(global_position):
						global_position = zone.global_position
						if zone.has_signal("item_dropped"):
							zone.emit_signal("item_dropped", self)
						dropped = true
						first_use = false
						break

	if not dropped:
		if item_type in meat_types:
			queue_free()
		global_position = start_position
