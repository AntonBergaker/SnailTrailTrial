extends RigidBody2D
class_name Log

@export var particle_scene: PackedScene


func _on_body_entered(body:Node):
	if body is Player:
		call_deferred("bruh", body.linear_velocity)

func bruh(speed: Vector2):
	var dir = speed.angle()
	for i in range(30):
		var particle := particle_scene.instantiate() as RigidBody2D
		get_parent().add_child(particle)

		if randf() > 0.5:
			particle.modulate = Color(0x5A2100AA)
		particle.global_position = global_transform * Vector2(randf_range(-100, 100), randf_range(-30, 30))
		particle.scale = Vector2(randf_range(0.3, 1), randf_range(0.3, 1))
		particle.apply_central_impulse(
			Vector2.from_angle(dir + randf_range(-1, 1))*speed.length() + 
			Vector2(randf_range(-1, 1), randf_range(-1, 1))*50
		)
		particle.angular_velocity = randf() * TAU
	queue_free()