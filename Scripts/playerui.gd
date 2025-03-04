extends Control
class_name PlayerUI


@export var player_health_label : Label
@export var stopwatch_label : Label

var player_health
var time = 0.0
var stopped = false


func _ready() -> void:
	player_health = $"..".MAX_HEALTH
	player_health_label.text = "Health: %s" % player_health
	

func _process(delta: float) -> void:
	update_stopwatch_label()
	
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
