extends Node2D

@onready var bomb = $Bomb
@onready var gameOver = $GameOver
@onready var loseSound = $GameOver/LoseSound
@onready var restartButton = $GameOver/RestartButton

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_bomb_gameover():
	loseSound.play(0.2)
	bomb.queue_free()
	gameOver.show()
	restartButton.disabled = false


func _on_restart_button_pressed():
	get_tree().reload_current_scene()
