extends Area2D

@export var damage_strength : float = 20
@export var damage_rate : float = 2.0
@export var enemy_starting_health : float = 50
@export var health : float = 0

@onready var DamageRateTimer : Timer = $DamageRateTimer
@onready var sprite : Sprite2D = $Sprite2D

var player = null
var entered_body = null

# Called when the node enters the scene tree for the first time.
func _ready():
	health = enemy_starting_health
	player = get_node("/root/World/Player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(entered_body == player && DamageRateTimer.is_stopped()):
		player.set("health", player.get("health") - 20)
		DamageRateTimer.wait_time = damage_rate
		DamageRateTimer.start()
		
	sprite.material.set_shader_parameter("radial_slider", health / enemy_starting_health)
	if(health <= 0):
		queue_free()
	
func _take_damage(damage : float):
	health -= damage

func _on_body_entered(body):
	entered_body = body
	
func _on_body_exited(body):
	if(body == entered_body):
		entered_body = null
