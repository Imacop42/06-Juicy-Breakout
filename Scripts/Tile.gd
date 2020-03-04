extends StaticBody2D

var points = 10
onready var _target = position
onready var t = $Timer
func _ready():
	position.y = 750
	var time = rand_range(0,3.5)
	t.set_wait_time(time)
	t.start()
	yield(t,"timeout")
	$Tween.interpolate_property(self, "position", position, _target, 3.0,Tween.TRANS_SINE, Tween.EASE_OUT)
	$Tween.start()
