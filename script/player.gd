
extends CharacterBody2D

var speed = 100
var player_state

@export var inv: Inv

var bow_equiped = false
var bow_cooldown = true
var arrow = preload("res://scenes/arrow.tscn")
var mouse_loc_from_player = null

func _physics_process(delta):
	mouse_loc_from_player = get_global_mouse_position() - self.position
	print(mouse_loc_from_player)
	
	var direction = Input.get_vector("left", "right", "up", "down")
	if direction == Vector2.ZERO:
		player_state = "idle"
	else:
		player_state = "walking"
		
	velocity = speed * direction
	move_and_slide()
	
	# Toggle bow equipped when 'e' is pressed
	if Input.is_action_just_pressed("e"):
		bow_equiped = !bow_equiped  # toggle bow status
	
	var mouse_pos = get_global_mouse_position()
	$Marker2D.look_at(mouse_pos)

	if Input.is_action_just_pressed("left_mouse") and bow_equiped and bow_cooldown:
		bow_cooldown = false
		var arrow_instance = arrow.instantiate()
		arrow_instance.rotation = $Marker2D.rotation
		arrow_instance.global_position = $Marker2D.global_position
		add_child(arrow_instance)
		
		await get_tree().create_timer(0.4).timeout
		bow_cooldown = true
	
	play_anim(direction)

func play_anim(dir):
	if not bow_equiped:
		if player_state == "idle":
			$AnimatedSprite2D.play("idle")
		elif player_state == "walking":
			if dir.y == -1:
				$AnimatedSprite2D.play("n-walk")
			elif dir.x == 1:
				$AnimatedSprite2D.play("e-walk")
			elif dir.y == 1:
				$AnimatedSprite2D.play("s-walk")
			elif dir.x == -1:
				$AnimatedSprite2D.play("w-walk")
			elif dir.x > 0.5 and dir.y < -0.5:
				$AnimatedSprite2D.play("ne-walk")
			elif dir.x > 0.5 and dir.y > 0.5:
				$AnimatedSprite2D.play("se-walk")
			elif dir.x < -0.5 and dir.y > 0.5:
				$AnimatedSprite2D.play("sw-walk")
			elif dir.x < -0.5 and dir.y < -0.5:
				$AnimatedSprite2D.play("nw-walk")
	else:
		var x = mouse_loc_from_player.x
		var y = mouse_loc_from_player.y
		# Use angle-based directions to avoid overlapping conditions
		if abs(x) <= 25 and y < 0:
			$AnimatedSprite2D.play("n-attack")
		elif x > 0 and abs(y) <= 25:
			$AnimatedSprite2D.play("e-attack")
		elif abs(x) <= 25 and y > 0:
			$AnimatedSprite2D.play("s-attack")
		elif x < 0 and abs(y) <= 25:
			$AnimatedSprite2D.play("w-attack")
		elif x >= 25 and y <= -25:
			$AnimatedSprite2D.play("ne-attack")
		elif x >= 0.5 and y >= 25:
			$AnimatedSprite2D.play("se-attack")
		elif x <= -0.5 and y >= 25:
			$AnimatedSprite2D.play("sw-attack")
		elif x <= -25 and y <= -25:
			$AnimatedSprite2D.play("nw-attack")

func player():
	pass

func collect(item):
	inv.insert(item)


	
		
