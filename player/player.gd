extends RigidBody2D
class_name Player

@export var normie_speed: float
@export var speed: float
@export var rotate_speed: float
@export var particles: CPUParticles2D
@export var engine_sound: AudioStreamPlayer
@export var engine_start_sound: AudioStreamPlayer

var intensity: float

var boost_timer := 0.0

var num_of_boosts := 0

var bonus_intensity = 0.0

var engine_volume = 0.0

var is_held := false

var controls_enabled := true

func _physics_process(delta):
	var space_pressed := controls_enabled && Input.is_key_pressed(KEY_SPACE)

	var primed := num_of_boosts >= 3

	if space_pressed && is_held == false:
		if !primed:
			num_of_boosts += 1
			bonus_intensity = 1.5 + num_of_boosts*0.5
		engine_sound.play()
		engine_start_sound.play()
	is_held = space_pressed
	

	if primed && space_pressed:
		apply_central_force(delta * speed * Vector2.UP.rotated(rotation))
		boost_timer = 1
	else:
		boost_timer = clamp(boost_timer - 0.05, 0, 1)
	
	if ((!primed && space_pressed) || Input.is_key_pressed(KEY_W)) && controls_enabled && boost_timer == 0:
		apply_central_force(delta * normie_speed * Vector2.UP.rotated(rotation))

	if Input.is_key_pressed(KEY_S) && controls_enabled && boost_timer == 0:
		apply_central_force(delta * normie_speed * -Vector2.UP.rotated(rotation))

	if Input.is_key_pressed(KEY_A) && controls_enabled:
		apply_torque(-rotate_speed * delta)

	if Input.is_key_pressed(KEY_D) && controls_enabled:
		apply_torque(rotate_speed * delta)
	
	if boost_timer < 1:
		linear_velocity *= lerp(0.95, 1.0, boost_timer)
		angular_velocity *= lerp(0.9, 1.0, boost_timer)


	intensity = linear_velocity.length() / 150
	if space_pressed:
		intensity += clamp(bonus_intensity*5, 0, 10)

	bonus_intensity -= delta
	if bonus_intensity < 0:
		bonus_intensity = 0
	
	engine_sound.pitch_scale = max(0.01, intensity/3)

	engine_volume -= delta/3
	engine_volume = clamp(max(engine_volume, intensity/4), 0.0, 1.0)

	engine_sound.volume_db = engine_volume*80.0 - 80
	particles.emitting = intensity >= 2

	# Hack, right now controls enabled is only used when winning
	if controls_enabled == false:
		intensity = 10

func disable_controls():
	controls_enabled = false