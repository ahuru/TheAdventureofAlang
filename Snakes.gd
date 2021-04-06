extends Area2D


func _ready():
	$AnimatedSprite.play("idle")


func _on_Snakes_body_entered(body):
	if body.name == "Player":
		$AnimatedSprite.play("attack")
