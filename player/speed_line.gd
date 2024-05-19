extends Sprite2D
class_name SpeedLine

var speed: Vector2
var timer: float


func _process(delta):
	timer -= delta
	if timer < 0:
		queue_free()
	position += speed*delta
