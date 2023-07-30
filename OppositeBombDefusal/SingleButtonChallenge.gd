extends "res://scripts/Challenge.gd"

const BombButton = preload("res://scripts/BombButton.gd")

@export var buttons : Array[PackedScene]
@export var pressPrompts : Array[String] = ["Don't press the Button!"]
@export var dontPressPrompts : Array[String] = ["Press the Button!"]

var activeButton : BombButton

func setup(buttonArea : ReferenceRect, instructionLabel : Label):
	super.setup(buttonArea, instructionLabel)
	
	var shouldPress = true if randi() % 2 == 1 else false
	
	activeButton = buttons[randi() % buttons.size()].instantiate()
	buttonArea.add_child(activeButton)
	activeButton.set_position(Vector2(
		randf_range(0, buttonArea.get_rect().size.x - activeButton.get_rect().size.x),
		randf_range(0,  buttonArea.get_rect().size.y - activeButton.get_rect().size.y)
	 ))
	instructionLabel.text = pressPrompts[randi() % pressPrompts.size()] if shouldPress else dontPressPrompts[randi() % dontPressPrompts.size()]
	activeButton.shouldPress = shouldPress
	activeButton.connect("pressed", _on_button_pressed)

func clear():
	activeButton.queue_free()
	queue_free()

func _on_button_pressed():
	print("Button pressed!")
	super._on_button_pressed()
	if activeButton.shouldPress:
		emit_signal("completed")
	else:
		emit_signal("failed")

func is_completed():
	super.is_completed()
	return not activeButton.shouldPress
