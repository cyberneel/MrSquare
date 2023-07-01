extends CharacterBody2D

@export var move_speed : float = 300.0
@export var rotation_speed : float = 20.0
@export var dash_speed_multiplier : float = 4.0
@export var dash_time : float = 0.5
@export var dash_cooldown : float = 0.75
@export var player_bounds_min : Vector2 = Vector2(17, 16)
@export var player_bounds_max : Vector2 = Vector2(1263, 704)
@export var player_starting_health : float = 100.0

@onready var DashTimer : Timer = $DashTimer
@onready var DashCooldownTimer : Timer = $DashCooldownTimer
@onready var GunHolder : Node2D = $GunHolder
@onready var PlayerBody : Polygon2D = $PlayerBody

var dashing : bool = false
var point_toward : Vector2 = Vector2.ZERO
@export var health : float = 0.0

var input_vector : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	health = player_starting_health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	input_vector = Vector2(
		Input.get_action_strength("MoveRight") - Input.get_action_strength("MoveLeft"),
		Input.get_action_strength("MoveDown") - Input.get_action_strength("MoveUp"),
	)
	
	PlayerBody.material.set_shader_parameter("radial_slider", health / player_starting_health)
	
func _physics_process(delta):	
	handle_dash()
	
	handle_movement(input_vector, delta)	
	
func handle_dash():
	if(Input.is_action_just_pressed("MoveDash") && DashTimer.is_stopped() && DashCooldownTimer.is_stopped()):
		dashing = true
		DashTimer.wait_time = dash_time
		DashTimer.start()

func _on_dash_timer_timeout():
	dashing = false
	DashCooldownTimer.wait_time = dash_cooldown
	DashCooldownTimer.start()
	
func _take_damage(damage : float):
	health -= damage
	
func handle_movement(input_vector, delta):
	if(input_vector != Vector2.ZERO):
		point_toward = input_vector
		
	rotation = lerp_angle(rotation, point_toward.angle(), delta * rotation_speed)
	var move_dir = Vector2(cos(rotation), sin(rotation))
	var move_strength = (1.0 if input_vector.length_squared() > 0 else 0.0)
	if(dashing):
		move_strength = 1
	
	velocity = move_speed * move_dir * (dash_speed_multiplier if dashing else 1.0) * move_strength
	if(dashing):
		PlayerBody.scale.y = move_toward(PlayerBody.scale.y, 0.5, delta * 4)
	else:
		PlayerBody.scale.y = move_toward(PlayerBody.scale.y, 1, delta * 4)
		
	move_and_slide()
	
	if(position.x < player_bounds_min.x):
		position.x = player_bounds_min.x
	if(position.y < player_bounds_min.y):
		position.y = player_bounds_min.y
	if(position.x > player_bounds_max.x):
		position.x = player_bounds_max.x
	if(position.y > player_bounds_max.y):
		position.y = player_bounds_max.y
