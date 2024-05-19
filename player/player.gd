extends RigidBody2D
class_name Player

@export var normie_speed: float
@export var speed: float
@export var rotate_speed: float

var intensity: float

var boost_timer := 0.0

func _physics_process(delta):
	if Input.is_key_pressed(KEY_SPACE):
		apply_central_force(delta * speed * Vector2.UP.rotated(rotation))
		boost_timer = 1
	else:
		boost_timer = clamp(boost_timer - 0.05, 0, 1)
	
	if Input.is_key_pressed(KEY_W) && boost_timer == 0:
		apply_central_force(delta * normie_speed * Vector2.UP.rotated(rotation))

	if Input.is_key_pressed(KEY_S) && boost_timer == 0:
		apply_central_force(delta * normie_speed * -Vector2.UP.rotated(rotation))

	if Input.is_key_pressed(KEY_A):
		apply_torque(-rotate_speed * delta * (1+boost_timer*2))

	if Input.is_key_pressed(KEY_D):
		apply_torque(rotate_speed * delta * (1+boost_timer*2))
	
	if boost_timer < 1:
		linear_velocity *= lerp(0.95, 1.0, boost_timer)
		angular_velocity *= lerp(0.9, 1.0, boost_timer)

	intensity = linear_velocity.length() / 150