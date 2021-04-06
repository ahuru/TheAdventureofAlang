extends Button

func _ready():
	pass # Replace with function body.



func _on_Berikut_pressed():
	var berikut = get_tree().change_scene("res://StageOne.tscn")
	print(berikut)
