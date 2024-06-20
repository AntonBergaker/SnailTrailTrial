extends Node
class_name RaceController

@export var player: Player
@export var road_builder: RoadBuilder
@export var hud: Hud

var distance_left: float
var time: float

enum Mode {
	Playing,
	Win
}

enum Tutorial {
	ShowControls,
	ShowBoost,
	End,
	WonGame,
}

var mode := Mode.Playing
var tutorial_step := Tutorial.ShowControls
var tutorial_timer := 0.0

func _process(delta):
	if Input.is_key_pressed(KEY_R):
		get_tree().reload_current_scene()

	if mode == Mode.Playing:
		if tutorial_step != Tutorial.ShowControls:
			time += delta
		distance_left = 25 - road_builder.distance_traveled / 17500.0

		if distance_left < 0:
			hud.show_win()
			player.disable_controls()
			mode = Mode.Win
			tutorial_step = Tutorial.WonGame
			tutorial_timer = 0

	tutorial_timer += delta

	if tutorial_step == Tutorial.ShowControls:
		if tutorial_timer > 2:
			hud.controls_visible(true)
		if road_builder.distance_traveled > 20 || player.num_of_boosts > 0:
			hud.controls_visible(false)
			tutorial_timer = 0
			tutorial_step = Tutorial.ShowBoost
	if tutorial_step == Tutorial.ShowBoost:
		if tutorial_timer > 2:
			hud.boost_visible(true)
		if player.num_of_boosts > 1:
			hud.boost_visible(false)
			tutorial_step = Tutorial.End
	if tutorial_step == Tutorial.WonGame:
		if tutorial_timer > 3:
			hud.show_restart()