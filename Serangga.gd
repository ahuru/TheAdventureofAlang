extends KinematicBody2D

const gravitasi = 10
const lantai = Vector2(0,-1)
var velocity = Vector2()
var is_dead = false
var direction = 1
export(int) var kecepatan = 100
export(int) var hp = 1
func _ready():
	pass # Replace with function body.

func _physics_process(_delta):

	if is_dead == false:
		velocity.x = kecepatan * direction
		if direction == 1:
			$AnimatedSprite.flip_h = false
		else:
			$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("fly")
		velocity = move_and_slide(velocity,lantai)
		if is_on_wall():
			direction = direction * -1
		if get_slide_count() > 0 :
			for i in range(get_slide_count()):
				if "Player" in get_slide_collision(i).collider.name:
					get_slide_collision(i).collider.takedamage()
func dead():
	hp -= 1
	if hp <= 0:
		is_dead = true
		velocity = Vector2(0,0)
		var mati = $mati
		mati.play()
		$AnimatedSprite.play("dead")
		$CollisionShape2D.call_deferred("set_disabled", true)
		$Timer.start()
	

func _on_Timer_timeout():
	queue_free()
