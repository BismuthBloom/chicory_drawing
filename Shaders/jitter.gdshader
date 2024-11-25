shader_type canvas_item;
render_mode world_vertex_coords;

// Global Variables
uniform float offset : hint_range(0, 2, .1) = 0.75;
uniform float time_inf : hint_range(0, 50) = 4.5;
uniform float y_div : hint_range(0, 10, 0.1) = 1.7;


void vertex() {
	// Called for every vertex the material is visible on.
	// Distort via noise here
	// Wobble
	//*
	VERTEX.y += sin(VERTEX.y * y_div + round(TIME * time_inf)) * offset;
	VERTEX.x += sin(VERTEX.x * y_div + round(TIME * time_inf)) * offset;
	//*/
}


void fragment() {
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
