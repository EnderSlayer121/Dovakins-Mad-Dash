extends Node2D



func _on_death_box_area_entered(_area: Area2D) -> void:
	$Player.die()


func _on_victory_collision_area_entered(_area: Area2D) -> void:
	if GameState.num_coins <= 10:
		get_tree().change_scene_to_file("res://level/fail.tscn")
	else:
		get_tree().change_scene_to_file("res://level/succeed.tscn")
