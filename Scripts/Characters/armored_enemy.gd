extends Enemy
class_name ArmoredEnemy


const MAX_ARMOR = 50
var armor = MAX_ARMOR


func enemy_hit(damage, is_metal):
	if armor > 0 && !is_metal:
		if damage < armor:
			armor -= damage
			print("enemy armor: %s, hp: %s" % [armor, health])
			if !sees_player:
				sees_player = true
		else:
			var helper = armor
			armor = 0
			print("armor broken")
			if damage-helper < health:
				health -= damage-helper
				print("enemy armor: %s, hp: %s" % [armor, health])
				if !sees_player:
					sees_player = true
			else:
				health = 0
				queue_free()
				print("enemy dead")
			
	elif is_metal:
		if damage < health:
			health -= damage
			print("enemy armor: %s, hp: %s" % [armor, health])
			if !sees_player:
				sees_player = true
		else:
			health = 0
			queue_free()
			print("enemy dead")
		
	else:
		if damage < health:
			health -= damage
			print("enemy hp: %s" % health)
			if !sees_player:
				sees_player = true
		else:
			health = 0
			queue_free()
			print("enemy dead")
