extends Control


# Called when the node enters the scene tree for the first time

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/fst.tscn")


func _on_option_button_pressed() -> void:
	pass # Replace with function body.
	

func _on_quit_button_pressed() -> void:
	get_tree().quit()
