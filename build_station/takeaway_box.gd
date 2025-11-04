extends Area2D

enum State { EMPTY, WAITING, SERVING }

var state = State.EMPTY

var old_pos = null

@onready var done_button = get_node("/root/Node/UI Layer/DoneButton")

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	var pressed = event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed
	
	if state == State.WAITING:
		if pressed:
			old_pos = position
						
			state = State.SERVING
			
			var tween := create_tween()
			tween.set_parallel()
			tween.tween_property(self, "position", Vector2(1600, 1140), 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
			tween.tween_property(self, "rotation_degrees", 180, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
			tween.play()
			
			done_button.current_kebab = self

	elif state == State.SERVING:
		if pressed:						
			done_button.current_kebab = null
			
			state = State.WAITING
			
			var tween := create_tween()
			tween.set_parallel()
			tween.tween_property(self, "position", old_pos, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
			tween.tween_property(self, "rotation_degrees", 90, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
			tween.play()

func set_wait():
	state = State.WAITING
