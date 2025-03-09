extends Node3D
class_name Level1

const LEVEL_NAME = "Level 1"

@onready var hit_rect = $PlayerHitUi/ColorRect


func _on_player_player_hit() -> void:
	hit_rect.visible = true
	await get_tree().create_timer(0.2).timeout
	hit_rect.visible = false
