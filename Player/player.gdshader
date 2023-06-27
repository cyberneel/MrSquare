shader_type canvas_item;

uniform vec4 main_color : source_color;
uniform vec4 damaged_color : source_color;
uniform float radial_slider : hint_range(0.0, 1.0);

float remap(float value, float low1, float high1, float low2, float high2)
{
	return low2 + (value - low1) * (high2 - low2) / (high1 - low1);
}

void fragment() {
	// Place fragment code here.
	float radial = atan(UV.x, UV.y);
	radial = remap(radial, -PI, PI, 0.0, 1.0);
	vec4 value;
	if(radial < radial_slider)
	{
		value = main_color;
	}
	else
	{
		value = damaged_color;
	}
	COLOR = value;
}
