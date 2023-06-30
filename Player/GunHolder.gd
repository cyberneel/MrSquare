extends Node2D

@export var muzzle_distance : float = 16.0

@onready var bullet_scene = load("res://Objects/bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	global_rotation = (get_global_mouse_position() - global_position).angle()
	
	if(Input.is_action_just_pressed("Shoot")):
		print("shoot")
		var bullet = bullet_scene.instantiate()
		get_node("/root/World").add_child(bullet)
		bullet.set_global_position(global_position + (Vector2(cos(global_rotation), sin(global_rotation)) * muzzle_distance))
		bullet.set_global_rotation(global_rotation)
		
