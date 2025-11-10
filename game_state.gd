extends Node

var num_coins = 0
var lives = 3
signal coin_change(new_coins)
signal life_change(new_lives)
enum PlayerState {BASE, MASKED, SWORDED}
var current_state = PlayerState.BASE

func give_coins(num: int) -> void:
	num_coins += num
	emit_signal("coin_change", num_coins)

func life_lost() -> void:
	lives -= 1
	if num_coins >= 1:
		num_coins = num_coins / 2
	emit_signal("life_change", lives)
	emit_signal("coin_change", num_coins)
	if lives <= 0:
		get_tree().change_scene_to_file("res://level/fail.tscn")
	else:
		get_tree().reload_current_scene()

func spawn_mask(pos):
	var mask_scene = load("res://Player/mask.tscn")
	var mask = mask_scene.instantiate()
	mask.global_position = pos
	get_tree().root.call_deferred("add_child", mask)

func spawn_sword(pos):
	var sword_scene = load("res://Player/sword.tscn")
	var sword = sword_scene.instantiate()
	sword.global_position = pos
	get_tree().root.call_deferred("add_child", sword)
