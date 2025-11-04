extends Camera2D

@export var bottom_offset: int

func show_top():
	offset.y = 0
	
func show_bottom():
	offset.y = bottom_offset
