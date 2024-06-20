shader_type canvas_item;
render_mode unshaded;

uniform vec3 global_light_normal = vec3(0.52, -0.78, 0.343);
uniform vec3 global_light_color : source_color = vec3(1.0, 1.0, 1.0);
uniform float global_light_strength = 1;



varying vec2 world_position;
varying mat4 matrix;

void vertex() {
	world_position = (MODEL_MATRIX * vec4(VERTEX, 0.0, 1.0)).xy;
	matrix = MODEL_MATRIX;
}

void fragment() {
	vec2 world_space = world_position.xy;
	vec3 normal = normalize((matrix * vec4(vec3(NORMAL.rg, 0.5), 0.0)).rgb);
	
	vec3 strength = vec3(0.0);
	{
		float dot_result = clamp(dot(normal, global_light_normal), 0.0, 1.0);
		strength += max(0.0, dot_result) * global_light_strength * global_light_color;
	}
	
	COLOR.rgb *= strength.r > 0.1 ? 1.0 : 0.7;
	COLOR.rgb *= strength.r > 0.34 ? 1.3 : 1.0;
}

