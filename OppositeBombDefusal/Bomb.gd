extends Control

var instruction : Label
var buttonArea : ReferenceRect
var scoreText : Label
var timer

var currentButton

@export var buttons : Array[PackedScene]
@export var time_limit : float
@export var time_limit_scale : float

var shouldPress : bool
var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	instruction = get_node("Instruction")
	buttonArea = get_node("ButtonArea")
	scoreText = get_node("Score")
	timer = get_node("Timer")
	scoreText.text = str(score)
	randomize()
	setup()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func reset():
	currentButton.queue_free()
	time_limit *= time_limit_scale

func setup():
	currentButton = buttons[0].instantiate()
	buttonArea.add_child(currentButton)
	currentButton.connect("pressed", _on_button_pressed)
	shouldPress = true if randi() % 2 == 1 else false
	instruction.text = "Don't press the button!" if shouldPress else "Press the button!"
	timer.start(time_limit)
	
func _on_button_pressed():
	if shouldPress:
		score += 1
		scoreText.text = str(score)
		reset()
		setup()
	else:
		get_tree().reload_current_scene()


func _on_timer_timeout():
	if not shouldPress:
		score += 1
		scoreText.text = str(score)
		reset()
		setup()
	else:
		get_tree().reload_current_scene()
