extends StaticBody2D


func _on_area_2d_area_entered(_area: Area2D) -> void:
	$CollisionShape2D.call_deferred("set", "disabled", true)
	$Area2D/CollisionShape2D.call_deferred("set", "disabled", true)
	$Sprite2D.visible = false

func spawn():
	GameState.spawn_sword(self.global_position * Vector2(0, -20))
