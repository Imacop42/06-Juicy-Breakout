extends AudioStreamPlayer2D



func _ready():
	pass


func _on_Ball_body_entered(body):
	#self.play()
	pass
	


func _on_Ball_ready():
	self.play()
