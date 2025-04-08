extends Control
class_name PlayerUI


signal check_cards

@export var player_health_label : Label
@export var stopwatch_label : Label
@export var enemy_count_label : Label
@export var level_label : Label 

var player_health
var time = 0.0
var stopped = false
var enemies

func _process(delta: float) -> void:
	update_stopwatch_label()
	player_health = $"..".health
	
	level_label.text = GlobalVariables.level_name
	player_health_label.text = "Health: %s" % player_health
	enemy_count_label.text = "Enemies left: %s" % GlobalVariables.enemies.size()
	
	if GlobalVariables.enemies.size() == 0:
		stopped = true
		GlobalVariables.time_to_complete_text = stopwatch_label.text
		
		if time / 60 < 1:
			if !GlobalVariables.in_a_hurry_unlocked:
				GlobalVariables.in_a_hurry_unlocked = true
				
		await get_tree().create_timer(3).timeout
		
		check_cards.emit()
		if GlobalVariables.cards_in_inventory >= 5:
			if !GlobalVariables.hoarder_unlocked:
				GlobalVariables.hoarder_unlocked = true
				
		if player_health <= 10:
			if !GlobalVariables.survivor_unlocked:
				GlobalVariables.survivor_unlocked = true
				
		if GlobalVariables.enemies_killed >= 50:
			if !GlobalVariables.destroyer_unlocked:
				GlobalVariables.destroyer_unlocked = true
		
		if GlobalVariables.level_name == GlobalVariables.FINAL_LEVEL_NAME:
			get_tree().change_scene_to_file("res://Scenes/Screens/final_level_completed.tscn")
			if !GlobalVariables.completionist_unlocked:
				GlobalVariables.completionist_unlocked = true
		else:
			get_tree().change_scene_to_file("res://Scenes/Screens/level_completed.tscn")
	
	if stopped:
		return
	time += delta


func reset():
	time = 0.0
	

func update_stopwatch_label():
	var msec = fmod(time, 1) * 1000
	var sec = fmod(time, 60)
	var minute = time / 60
	
	var format_string = "%02d : %02d : %02d"
	var actual_string = format_string % [minute, sec, msec]
	
	stopwatch_label.text = actual_string
