extends Area2D

var velocity = Vector2(500, 0)

func _physics_process(delta: float) -> void:
	self.position += velocity * delta




func _on_hit_box_area_entered(area: Area2D) -> void:
	queue_free()
