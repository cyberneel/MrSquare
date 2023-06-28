extends Area2D

@export var damage_strength : float = 20
@export var damage_rate : float = 2.0;

@onready var DamageRateTimer : Timer = $DamageRateTimer

var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(player != null && DamageRateTimer.is_stopped()):
		player.set("health", player.get("health") - 20)
		DamageRateTimer.wait_time = damage_rate
		DamageRateTimer.start()

func _on_body_entered(body):
	player = body
	

func _on_body_exited(body):
	if(body == player):
		player = null
