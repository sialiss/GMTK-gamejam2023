extends Control


func restart():
	get_tree().change_scene_to_packed(load("res://Scenes/Sea/Sea.tscn"))	


func menu():
	get_tree().change_scene_to_packed(load("res://Scenes/Menu/Menu.tscn"))
