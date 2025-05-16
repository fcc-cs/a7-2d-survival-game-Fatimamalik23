extends Control

signal quest_menu_closed

var quest1_active= false
var quest1_completed = false
var stick = 0
func _process(delta):
	if quest1_active:
		if stick ==1:
			print("quest1 completed")
			quest1_active = false
			quest1_completed= true
	#if quest2_active:

func quest1_chat():
	$quest1_ui.visible= true
	
func _on_yes_button_1_pressed():
	$quest1_ui.visible= false
	quest1_active = true
	stick = 0
	emit_signal("quest_menu_closed")


func _on_no_button_1_pressed():
	$quest1_ui.visible= false
	quest1_active = false
	emit_signal("quest_menu_closed")
