extends Area2D

@export var accepts: Array[String] = []
@export var zone_id: String = ""  
signal item_dropped(body)

func _ready() -> void:
	add_to_group("drop_zones")
