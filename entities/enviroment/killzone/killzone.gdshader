shader_type canvas_item;

// Uniforms are variables you can edit in the Godot Inspector.
// They let you customize the shader without changing the code.
uniform vec4 laser_color : source_color = vec4(1.0, 0.0, 0.0, 1.0); // The color of the lasers (default: red)
uniform float laser_speed = 0.9; // How fast the lasers move up and down
uniform float laser_density = 100.0; // How close together the lasers are
uniform float laser_width = 0.0005; // How thick each laser line is

void fragment() {
	// Create a sine wave based on time and a speed uniform.
	// This makes the lasers "pulse" or move over time.
	float time_val = sin(TIME * laser_speed);

	// Use the horizontal UV coordinate (UV.x) to create vertical lines.
	// We add a time_val to make the lines shift.
	float line_pattern = sin(UV.x * laser_density + time_val * 10.0);
	
	// Use smoothstep to create a sharp, well-defined line.
	// We use the laser_width uniform to control the thickness.
	float alpha = smoothstep(0.9, 0.9 + laser_width, line_pattern);
	
	// Set the final color of the pixel.
	// The alpha channel (transparency) is determined by the line pattern.
	vec4 final_color = vec4(laser_color.rgb, alpha);
	COLOR = final_color;
}
