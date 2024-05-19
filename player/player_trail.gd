extends Node2D

@export var player: Player
@export var other_camera: Camera2D

@export var texture: Texture2D
@export var viewport: SubViewport

@export var camera: Camera2D

var sprites: Array[Sprite2D]
var index = 0
var last_pos: Vector2

func _ready():
	last_pos = player.global_position
	for i in range(150):
		var sprite = Sprite2D.new()
		sprite.texture = texture
		viewport.add_child(sprite)
		sprite.global_position = Vector2(1000, 10000)
		sprite.visibility_layer = 1 << 2
		sprites.push_back(sprite)

func _process(_delta):
	var target = player.global_position
	var dist = last_pos.distance_to(target)
	var times = floor(dist/10)
	for i in times:
		var sprite = sprites[index]
		sprite.global_position = lerp(last_pos, target, (i+1)/times)
		sprite.global_rotation = player.global_rotation

		index = (index + 1) % sprites.size()
	if times > 0:
		last_pos = target
	
	update_pos()

func _physics_process(_delta):
	update_pos()

func update_pos():
	scale = Vector2.ONE / other_camera.zoom
	global_position = other_camera.global_position - Vector2(1920, 1080)/2 / other_camera.zoom
	camera.global_position = other_camera.global_position
	camera.global_rotation = other_camera.global_rotation
	camera.zoom = other_camera.zoom