extends TextureButton

@export var current_drink = null:
	set(value):
		current_drink = value
		check_ready()
		
	get:
		return current_drink

@export var current_kebab = null:
	set(value):
		current_kebab = value
		check_ready()
		
	get:
		return current_kebab


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(on_click)
	print(get_path())

func on_click():
	if current_drink == null or current_kebab == null:
		return
		
	print("check logic here")

func check_ready():
	print(current_drink, current_kebab)
	disabled = current_drink == null or current_kebab == null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
