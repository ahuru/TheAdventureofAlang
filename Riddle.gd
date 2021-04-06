extends Area2D

var can_interact = false

func _ready():
	pass # Replace with function body.


func _on_Riddle_body_entered(body):
	if body.name == "Player":
		$Kata.show()
		can_interact = true

func _on_Riddle_body_exited(body):
	if body.name == "Player":
		$Kata.hide()

func _input(_event):
	if Input.is_action_just_pressed("ui_right") and can_interact == true:
		$Kata.text = "I am one of four cardinals, but i do track the sun. When Sunrise come i will follow"