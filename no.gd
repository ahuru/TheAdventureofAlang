extends Button


func _ready():
	pass 

func _on_no_button_down():
	var menu = get_tree().change_scene("res://Menu.tscn")
	print(menu)
