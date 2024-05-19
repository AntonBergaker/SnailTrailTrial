extends Node2D

@export var road_base: PackedScene

@export var log_scene: PackedScene

@export var player: Player

var last : Vector2
var index := 0

var road_segments: Array[RoadPiece]

var noise: FastNoiseLite

func _ready():
	last = position
	noise = FastNoiseLite.new()
	road_segments = []

	for i in range(1, 10):
		generate()

func _process(_delta):
	var last_road := road_segments[-1]
	if is_instance_valid(last_road) && last_road.position.distance_to(player.position) < 5000:
		generate()
		var first_road = road_segments.pop_front()
		first_road.queue_free()


func generate():
	var noise_power := noise.get_noise_1d(index*5)
	var target = last + Vector2(noise_power, -1).normalized() * 950;

	var mid = (last + target) / 2
	var base_object := road_base.instantiate() as RoadPiece;
	var expect_rot := mid.angle_to_point(target) + TAU/4

	base_object.position = mid
	base_object.rotation = expect_rot
	add_child(base_object);

	for i in range(5):
		if randf() < 0.1:
			var log_obj := log_scene.instantiate() as Node2D
			var x_pos := randf_range(-1, -2) if randf() < 0.5 else randf_range(1, 2)
			log_obj.position = Vector2(x_pos*650, randf_range(-500, 500))
			base_object.add_child(log_obj)
			log_obj.global_rotation = randf_range(-.1, .1)

	if road_segments.size() > 0:
		var pre := road_segments[-1]
		base_object.connect_road(pre)

	road_segments.push_back(base_object)
	index += 1
	last = target