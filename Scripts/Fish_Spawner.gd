extends Node2D


func _on_timer_timeout():
	var fish = preload("res://Scenes/fish_1.tscn")
	var fishs = fish.instantiate()
	add_child(fishs)
