#version 300 es

uniform vec2 resolution;
uniform vec2 offset;
uniform float scale;
uniform float point_size;
uniform float max_mass;
uniform float max_speed;
uniform float particle_scale;

in vec2 position;
in vec2 velocity;
in float mass;

out vec3 color;

void main() {
    vec2 translated_pos = ((position * scale + offset) / resolution * 2.0 - 1.0);
    gl_Position = vec4(translated_pos * vec2(1, -1.0), 0, 1);

    gl_PointSize = point_size;
    //gl_PointSize += (mass/max_mass)*10.0;
    float coef = pow((mass/max_mass),0.5);
    gl_PointSize += coef *10.0;
    
    gl_PointSize *= particle_scale;

    vec2 translated_velocity = 0.5 + velocity / max_speed * 0.5;
    float translated_mass = 0.25+coef*0.75;    
    if(mass>0.0) {    
    	color = vec3(translated_velocity.x, translated_mass, translated_velocity.y);
    } else {
    	color = vec3(0.0, 0.0, 0.0);
    }
}