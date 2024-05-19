extends Node

@export var player: Player
@export var audio_streams: Array[AudioStreamPlayer]
var active: int = -1

var volume = 0.0

func _process(_delta):
	if player:
		var intense = clamp(player.intensity/4 - 1.2, 0.0, 1.0)
		volume = lerp(volume, intense, 0.03)
		if volume < 0.01:
			volume = 0.0
		for stream in audio_streams:
			stream.volume_db = volume*80 - 80

	for stream in audio_streams:
		stream.stream_paused = volume <= 0
	
	if volume > 0:
		if active == -1:
			active = 0
			audio_streams[active].play()
		else:
			var current := audio_streams[active]
			
			var playback = current.get_playback_position()

			if playback > 63.5:
				active = (active + 1) % audio_streams.size()
				var next := audio_streams[active]
				next.play()
