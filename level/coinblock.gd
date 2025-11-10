extends StaticBody2D


func _on_area_2d_area_entered(_area: Area2D) -> void:
	$Area2D/CollisionShape2D.call_deferred("set", "disabled", true)
	$CollisionShape2D.call_deferred("set", "disabled", true)
	$Sprite2D.visible = false
	GameState.give_coins(1)
	$Label.text = "+1"
	$Timer.start()


func _on_timer_timeout() -> void:
	$Label.text = ""
	queue_free()
