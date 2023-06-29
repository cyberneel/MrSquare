extends Area2D

@export var bullet_speed : float = 800.0
@export var alive_time : float = 1.5
@export var damage : float = 10.0

@onready var AliveTimer : Timer = $AliveTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	AliveTimer.wait_time = alive_time
	AliveTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += Vector2(cos(rotation), sin(rotation)) * bullet_speed * delta
	
	if(AliveTimer.is_stopped()):
		queue_free()


func _on_area_entered(area):
	if(area.has_method("_take_damage")):
		area._take_damage(damage)
