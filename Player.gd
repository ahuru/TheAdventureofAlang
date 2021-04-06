extends KinematicBody2D

var kecepatan = Vector2()
const maju = 200
const gravitasi = 10
const jump_power = -600
const lantai = Vector2(0,-1)
const Fireball = preload("res://Fireball.tscn")
var score = 0
var di_tanah = false 
var is_attacking = false
var is_dead = false
var hp = 1

func _ready():
	set_physics_process(true)
	set_process(true)

func _process(_delta):
	var labelnode = get_parent().get_node("Score/UI/Base/ScoreLabel")
	labelnode.text = str(score)
	if get_slide_count() > 0:
		for i in range(get_slide_count()):
			if "Robot" in get_slide_collision(i).collider.name:
				takedamage()
			elif "Serangga" in get_slide_collision(i).collider.name:
				takedamage()
	if score >= 200:
		var selesai = get_parent().get_node("Score/UI/Base/Max_score")
		selesai.text = "Solve the riddle to exit!"
	#if Input.is_action_just_pressed("ui_right") and is_on_floor() and is_attacking == false:
		#var kanan = $"Audio Effect/walk_r"
		#kanan.play()
	if Input.is_action_just_pressed("ui_up"):
			var musicnode = $"Audio Effect/Jump"
			musicnode.play()
	elif Input.is_action_just_pressed("ui_focus_next"):
		var shoot = $"Audio Effect/Shoot"
		shoot.play()
	#elif Input.is_action_just_pressed("ui_left") and is_on_floor():
		#var kiri = $"Audio Effect/walk_l"
		#kiri.play()
	#elif Input.is_action_just_released("ui_right"):
		#var kanan = $"Audio Effect/walk_r"
		#kanan.stop()
	#elif Input.is_action_just_released("ui_left"):
		#var kiri = $"Audio Effect/walk_l"
		#kiri.stop()

func game_over():
	var gameover = get_tree().change_scene("res://Gameover.tscn")
	print(gameover)

func _physics_process(_delta):
	if is_dead == false:
	
		if Input.is_action_pressed("ui_right"):
			if is_attacking == false || is_on_floor() == false:
		       kecepatan.x = maju
		       if is_attacking == false:	
			       $AnimatedSprite.play("run")
			       $AnimatedSprite.flip_h = false
			       if sign($Position2D.position.x) == -1:
			       	 $Position2D.position.x *= -1
		elif Input.is_action_pressed("ui_left"):
			if is_attacking == false || is_on_floor() == false:
		       kecepatan.x = -maju
		       if is_attacking == false:
	                $AnimatedSprite.play("run")
	                $AnimatedSprite.flip_h = true
	                if sign($Position2D.position.x) == 1:
	                  $Position2D.position.x *= -1
		else: 
	    kecepatan.x = 0
	    if di_tanah == true && is_attacking == false :
	     $AnimatedSprite.play("idle")
	
		if Input.is_action_pressed("ui_up"):
			if is_attacking == false:
				if di_tanah == true:
					kecepatan.y = jump_power
					di_tanah = false
		if Input.is_action_just_pressed("ui_focus_next") && is_attacking == false:
	       if is_on_floor():
	          kecepatan.x = 0
	       is_attacking = true 
	       $AnimatedSprite.play("Attack")
	       var fireball = Fireball.instance()
	       if sign($Position2D.position.x) == 1:
	         fireball.set_fireball_direction(1)
	       else:
	         fireball.set_fireball_direction(-1)
	       get_parent().add_child(fireball)
	       fireball.position = $Position2D.global_position
		kecepatan.y += gravitasi
		if is_on_floor():
			if di_tanah == false:
				is_attacking = false
			di_tanah = true 
		else: 
			if is_attacking == false:
			    di_tanah = false
			    if kecepatan.y < 0:
			      $AnimatedSprite.play("jump")
			    else:
			      $AnimatedSprite.play("fall")
		if position.y >= 2650:
			var ulang = get_tree().reload_current_scene()
			print(ulang)
		kecepatan = move_and_slide(kecepatan,lantai)

func takedamage():
	hp -= 1
	if  hp == 0:
		var darah_0 = get_parent().get_node("Score/UI/Base/Health_0")
		darah_0.hide()
		dead()
	
func dead():
	is_dead = true
	kecepatan = Vector2(0,0)
	$AnimatedSprite.play("dead")
	$CollisionShape2D.call_deferred("set_disabled",true)
	$Timer.start()

func _on_AnimatedSprite_animation_finished():
	is_attacking = false

func _on_Duit_0_body_entered(body):
	if body.name == "Player":
		score += 100

func _on_Timer_timeout():
	game_over()

func _on_Snakes_body_entered(body):
	if body.name == "Player":
		takedamage()

func _on_ChangeStage_body_entered(body):
	if body.name == "Player":
		if score >= 200:
			var change_stage = get_tree().change_scene("res://StageTwo.tscn")
			print(change_stage)


func _on_Repeat_Stage_body_entered(body):
	if body.name == "Player":
		var repeat_stage = get_tree().reload_current_scene()
		print(repeat_stage)


func _on_Exit_Stage_body_entered(body):
	if body.name == "Player":
		var finish = get_tree().change_scene("res://Gamewin.tscn")
		print(finish)

