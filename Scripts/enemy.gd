extends CharacterBody3D
class_name Enemy


const MAX_HEALTH = 50
var health = MAX_HEALTH


func enemy_hit(damage):
	health -= damage
	if health <= 0:
		queue_free()


func burning(damage):
	for n in 3:
		await get_tree().create_timer(1).timeout
		health -= damage
		print("ON FIRE!!! %s" % health)
		if health <= 0:
			queue_free()
