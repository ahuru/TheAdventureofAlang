extends Button


func _ready():
	pass # Replace with function body.

func _on_play_pressed():
	var main = get_tree().change_scene("res://Story.tscn")
	print(main)
	
