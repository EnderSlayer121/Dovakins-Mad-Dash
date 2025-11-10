extends CharacterBody2D

var speed = 150
var jump_velocity = -380
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var normal = load("res://assets/dovakinbase-removebg-preview.png")
var mask = load("res://assets/dovakinmasked-removebg-preview.png")
var sworded = load("res://assets/dovakinsword-removebg-preview.png")
var is_dying = false
var masked = false
var is_firing = false
var can_fire = false
var fire_direction = 1

@onready var fire_timer = $FireTimer

func _ready():
	add_to_group("Player")

func die():
	if is_dying:
		return
	is_dying = true
	GameState.life_lost()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	if GameState.current_state == GameState.PlayerState.SWORDED and Input.is_action_just_pressed("fire"):
		fire_bullet()
	var direction_left = Input.is_action_pressed("left")
	var direction_right = Input.is_action_pressed("right")
	if direction_left:
		velocity.x = -speed 
		$Sprite2D.flip_h = true
	elif direction_right:
		velocity.x = speed
		$Sprite2D.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
	move_and_slide()

func _on_hit_box_area_entered(_area: Area2D) -> void:
	match GameState.current_state:
		GameState.PlayerState.BASE:
			die()
		GameState.PlayerState.MASKED:
			GameState.current_state = GameState.PlayerState.BASE
		GameState.PlayerState.SWORDED:
			GameState.current_state = GameState.PlayerState.MASKED

func become_masked():
	GameState.current_state = GameState.PlayerState.MASKED
	$Sprite2D.texture = mask

func become_base():
	GameState.current_state = GameState.PlayerState.BASE
	$Sprite2D.texture = normal

func become_sworded():
	GameState.current_state = GameState.PlayerState.SWORDED
	$Sprite2D.texture = sworded

func fire_bullet():
	is_firing = true
	var bullet = load("res://Player/bullet.tscn").instantiate()
	bullet.global_position = Vector2(self.global_position.x + 30, self.global_position.y - 15)
	
	bullet.set("velocity", Vector2(500 * fire_direction, 0))
	get_parent().add_child(bullet)
	fire_timer.start(0.5)

func _on_fire_timer_timeout() -> void:
	is_firing = false
