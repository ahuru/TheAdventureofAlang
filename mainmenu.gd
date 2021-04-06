extends Button


func _ready():
	pass 

func _on_mainmenu_pressed():
	var menu = get_tree().change_scene("res://Menu.tscn")
	print(menu)
