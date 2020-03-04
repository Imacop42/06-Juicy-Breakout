extends RigidBody2D

onready var Game = get_node("/root/Game")
onready var Starting = get_node("/root/Game/Starting")

var _rotation = 0
var _rotation_speed = 0.05
var _color = 0.0
var _color_decay = 1
var _normal_color
var trauma_color = Color(0,.39,.39,1)

func _ready():
	contact_monitor = true
	set_max_contacts_reported(4)
	_normal_color = $ColorRect.color
	
func _process(delta):
	if _color > 0:
		_decay_color(delta)
		_apply_color()
	if _color == 0 and $ColorRect.color != _normal_color:
		$ColorRect.color = _normal_color
		

func _physics_process(delta):
	# Check for collisions
	var bodies = get_colliding_bodies()
	for body in bodies:
		if body.is_in_group("Tiles"):
			Game.change_score(body.points)
			add_color(1.0)
			body.queue_free()
			emit_signal("ready")
			
			
func add_color(amount):
	_color += amount
func _apply_color():
	var a = min(1,_color)
	$ColorRect.color = _normal_color.linear_interpolate(trauma_color,a)
func _decay_color(delta):
	var change = _color_decay + delta
	_color = max(_color - change,0)
	
	if position.y > get_viewport().size.y:
		Game.change_lives(-1)
		Starting.startCountdown(3)
		queue_free()
