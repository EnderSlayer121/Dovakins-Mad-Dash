extends CharacterBody2D
var enemyspeed = -50
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var facing_right = false

func _ready():
	add_to_group("enemies")

#enemy movement
func _physics_process(delta: float) -> void:
	if not is_on_floor(): #Check if on solid ground
		velocity.y += gravity * delta
	if !$RayCast2D.is_colliding() and is_on_floor():
		flip()
	if $RayCast2D2.is_colliding():
		flip()
	velocity.x = enemyspeed
	move_and_slide()

func flip():
	facing_right = !facing_right
	scale.x = abs(scale.x) * -1
	if facing_right:
		enemyspeed = abs(enemyspeed)
	else:
		enemyspeed = abs(enemyspeed) * -1



func _on_hit_box_area_entered(_area: Area2D) -> void:
	GameState.give_coins(1)
	queue_free()


func _on_attack_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body._on_hit_box_area_entered()
