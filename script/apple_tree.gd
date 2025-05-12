extends Node2D

var state = "noapples"
var player_in_area = false

func _ready():
	if state== "noapples":
		$growth_timer.start()

func _process(delta):
	if state =="noapples":
		$AnimatedSprite2D.play("noapples")
	if state =="apples":
		$AnimatedSprite2D.play("apples")
		if player_in_area:
			if Input.is_action_just_pressed("e"):
				state ="noapples"	
				$growth_timer.start()
		


func _on_pickapple_area_body_entered(body):
	if body.has_method("player"):
		player_in_area=true


func _on_pickapple_area_body_exited(body):
	if body.has_method("player"):
		player_in_area= false
		


func _on_growth_timer_timeout() -> void:
	if state =="noapples":
		state ="apples"
