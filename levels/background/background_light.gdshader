shader_type canvas_item;

uniform vec4 light_color : source_color = vec4(1.0, 0.9, 0.7, 1.0); // Warm light color (e.g., yellow-orange)
uniform vec2 light_position = vec2(0.5, 0.5); // Center of the light (0.0-1.0 UV coordinates)
uniform float light_radius = 0.5; // How large the light is
uniform float light_falloff = 2.0; // How quickly the light fades

void fragment() {
    // Calculate distance from the light source
    vec2 dist_vec = UV - light_position;
    float dist = length(dist_vec);

    // Calculate light intensity based on distance and falloff
    float intensity = max(0.0, 1.0 - pow(dist / light_radius, light_falloff));

    // Multiply light color by intensity
    COLOR = vec4(light_color.rgb * intensity, light_color.a);
}