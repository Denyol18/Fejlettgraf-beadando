extends Area3D


func _on_body_entered(body) -> void:
	if body is Player:
		queue_free()
