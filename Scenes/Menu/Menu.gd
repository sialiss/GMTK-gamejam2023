extends CanvasLayer

var game_scene = preload("res://Scenes/Sea/Sea.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Credits.hide()
	if OS.get_name() == "HTML5":
		$ButtionQuit.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_start_pressed():
	get_tree().change_scene_to_packed(game_scene)

func _on_button_quit_pressed():
	get_tree().quit()

func _on_button_credits_pressed():
	$Credits.show()

func _on_credits_go_to_menu():
	$Credits.hide()
