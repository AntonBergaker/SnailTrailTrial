extends CanvasLayer
class_name Hud

@export var race_controller: RaceController
@export var distance_label: Label
@export var time_label: Label
@export var win_label: Label
@export var restart_label: Label

@export var controls_label: Label
@export var boost_label: Label

func _process(_delta):
	var time = race_controller.time

	var distance_left = race_controller.distance_left
	distance_label.text = "%.01f km to go" % distance_left

	time_label.text = format_time(time)

func format_time(time: float) -> String:
	var seconds = time
	var minutes := floorf(seconds / 60)
	seconds -= minutes * 60
	return "%d:%04.01f" % [minutes, seconds]

func show_win():
	win_label.visible = true
	win_label.text = "You Win!\n" + format_time(race_controller.time)
	time_label.visible = false
	distance_label.visible = false

func show_restart():
	restart_label.visible = true

func controls_visible(new_visible: bool):
	controls_label.visible = new_visible

func boost_visible(new_visible: bool):
	boost_label.visible = new_visible