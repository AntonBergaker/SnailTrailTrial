extends Camera2D

@export var player: Player

var shake: Vector2
var noise: FastNoiseLite
var timer := 0.0
var speed_zoom := 0.0

func _ready():
	noise = FastNoiseLite.new()


func _process(delta):
	var player_intensity = player.intensity
	timer += delta*player_intensity*12
	shake = Vector2(noise.get_noise_1d(timer), noise.get_noise_1d(timer+500))
	speed_zoom = lerp(speed_zoom, player_intensity*0.02, 0.01)

	zoom = Vector2.ONE * (1 + noise.get_noise_1d(timer-500)*0.005*player_intensity) * (1-speed_zoom)
	update()

func _physics_process(_delta):
	update()


func update():
	global_position = player.global_position + Vector2(0, -300 * (1+speed_zoom*2)) + shake * player.intensity*5
