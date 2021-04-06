extends Control


func _ready():
	pass # Replace with function body.

func _input(_event):
	if Input.is_action_just_pressed("ui_select"):
		get_tree().paused = not get_tree().paused
		visible = not visible
	

func _on_kembali_pressed():
	get_tree().paused = not get_tree().paused
	visible = not visible
