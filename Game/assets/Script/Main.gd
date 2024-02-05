extends Node2D

var time = 0;
var endTimer = Save.gameData.time;

func _process(delta):
	time += delta;
	var mins = fmod(time, 60 * 60) / 60;
	if mins >= endTimer:
		return get_tree().change_scene("res://assets/Menu/Victory.tscn");
