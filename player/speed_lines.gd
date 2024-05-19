extends Node2D

@export var speed_line_scene: PackedScene
@export var player: Player
@export var camera: Camera2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var intensity = clamp(player.intensity*0.05, 0, 1.5)

	for i in range(randf()*0.3 + intensity*3):
		var line := speed_line_scene.instantiate() as SpeedLine
		
		var dir = randf() * TAU
		var pos = Vector2.from_angle(dir)
		line.position = pos * randf_range(400, 600) * (2-intensity)
		line.rotation = dir + TAU/2

		line.self_modulate = Color(Color.WHITE, intensity/2)
		line.timer = 0.1
		line.speed = pos*100*intensity
		line.scale = Vector2(2, randf_range(0.5, 1.5))

		add_child(line)

func _physics_process(_delta):
	if !player:
		return
	scale = Vector2.ONE / camera.zoom