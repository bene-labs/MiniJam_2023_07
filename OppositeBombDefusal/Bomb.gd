extends Control

const Challenge = preload("res://scripts/Challenge.gd")

var instruction : Label
var buttonArea : ReferenceRect
var scoreText : Label
var timer

var currentChallenge : Challenge

@export var challenges : Array[PackedScene]

@export var time_limit : float
@export var time_limit_scale : float

var score = 0

signal gameover

# Called when the node enters the scene tree for the first time.
func _ready():
	instruction = get_node("Instruction")
	buttonArea = get_node("ButtonArea")
	scoreText = $"../Score"
	timer = get_node("Timer")
	scoreText.text = str(score)
	randomize()
	setup()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if Input.is_key_pressed(KEY_R):
	#	_on_challenge_failed()
	pass
	
func reset():
	time_limit *= time_limit_scale
	currentChallenge.clear()

func setup():
	currentChallenge = challenges[randi() % challenges.size()].instantiate()
	currentChallenge.setup(buttonArea, instruction)
	currentChallenge.connect("completed", _on_challenge_completed)
	currentChallenge.connect("failed", _on_challenge_failed)
	timer.start(time_limit)
	
func _on_timer_timeout():
	if currentChallenge.is_completed():
		_on_challenge_completed()
	else:
		_on_challenge_failed()
		
func _on_challenge_failed():
	emit_signal("gameover")

func _on_challenge_completed():
	score += 1
	scoreText.text = str(score)
	reset()
	setup()
