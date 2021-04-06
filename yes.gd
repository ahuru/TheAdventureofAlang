extends Button


func _ready():
	pass 

func _on_yes_pressed():
	var ulang = get_tree().change_scene("res://StageOne.tscn")
	print(ulang)
