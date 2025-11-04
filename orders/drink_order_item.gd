extends CenterContainer


func _ready() -> void:
	await get_tree().process_frame
	var glass: Area2D = get_child(0)
