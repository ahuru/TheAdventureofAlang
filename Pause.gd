extends Control


func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().paused = not get_tree().paused
		visible = not visible

func _on_Button_pressed():
	get_tree().paused = not get_tree().paused
	visible = not visible


func _on_Button3_button_down():
	get_tree().quit()


func _on_Button2_button_down():
	get_tree().paused = not get_tree().paused
	var menuutama = get_tree().change_scene("res://Menu.tscn")
	print(menuutama)
