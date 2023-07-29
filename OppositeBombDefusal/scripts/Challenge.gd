extends Node

var instruction : Label

signal completed
signal failed

# Called when the node enters the scene tree for the first time.
func setup(buttonArea : ReferenceRect, instructionLabel : Label):
	instruction = instructionLabel
	
func clear():
	pass

func _on_button_pressed():
	pass

func is_completed():
	return false
