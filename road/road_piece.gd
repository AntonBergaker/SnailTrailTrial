extends Sprite2D
class_name RoadPiece

@export var railing_r: StaticBody2D
@export var railing_l: StaticBody2D

func connect_road(road: RoadPiece):
	connect_railing(railing_r, road.railing_r)
	connect_railing(railing_l, road.railing_l)
	
func connect_railing(railing_source: StaticBody2D, railing_target: StaticBody2D):
	var diff = railing_target.global_position - railing_source.global_position
	var dist = diff.length()

	railing_source.global_scale = Vector2(1, dist/990)
	railing_source.global_rotation = diff.angle() - TAU/4
