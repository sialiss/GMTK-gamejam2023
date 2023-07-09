extends CanvasLayer

signal go_to_menu

func _on_back_pressed():
	emit_signal("go_to_menu")
