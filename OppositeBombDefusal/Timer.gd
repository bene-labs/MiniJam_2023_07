extends TextureProgressBar

var timer : Timer

signal timeout

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = get_node("Timer")
	max_value = timer.wait_time
	value = max_value
	
func start(time : float):
	timer.stop()
	max_value = timer.wait_time
	value = max_value
	timer.wait_time = time
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	value = timer.time_left


func _on_timer_timeout():
	emit_signal("timeout")
