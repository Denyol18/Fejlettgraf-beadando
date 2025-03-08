extends CharacterBody3D
class_name Enemy


const MAX_HEALTH = 50
const SPEED_ORIGINAL = 5.0

var health = MAX_HEALTH
var speed = SPEED_ORIGINAL

var on_fire = false
var slowed = false
var frozen = false


func enemy_hit(damage):
	print("Enemy hit with %s damage" % damage)
	health -= damage
	death_check()


func burning(damage):
	for n in 3:
		await get_tree().create_timer(1).timeout
		health -= damage
		print("ON FIRE!!!")
		death_check()
	on_fire = false


func slowdown(slow_value):
	print("Enemy speed: %s" % speed)
	if slow_value > speed:
		speed = 1
	else:
		speed -= slow_value
	print("Enemy speed: %s" % speed)
	await get_tree().create_timer(2).timeout
	speed = SPEED_ORIGINAL
	slowed = false
	print("Enemy speed: %s" % speed)


func freeze():
	print("Enemy speed: %s" % speed)
	speed = 0.0
	print("Enemy speed: %s" % speed)
	await get_tree().create_timer(2).timeout
	speed = SPEED_ORIGINAL
	frozen = false
	print("Enemy speed: %s" % speed)


func death_check():
	if health <= 0:
		queue_free()
		print("enemy dead")
	else:
		print("enemy health: %s" % health)
