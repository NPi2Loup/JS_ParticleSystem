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
    //float coef = abs(mass/max_mass);
    //gl_PointSize += 5.0*coef;  
    gl_PointSize *= sqrt(abs(mass));
    gl_PointSize *= particle_scale;

    vec2 translated_velocity = 0.5 + velocity / max_speed * 0.5;
    float absolute_velocity = sqrt(velocity.y*velocity.y + velocity.x*velocity.x)/max_speed;
    float coef = abs(mass/max_mass);
    float translated_mass = 0.5+coef*0.5;    
    if(mass>0.0) {    
    	color = vec3(absolute_velocity*0.5, 0.5+absolute_velocity*0.5, absolute_velocity*0.5);
    } else if(mass<0.0) {    
    	color = vec3(0.5+absolute_velocity*0.5, absolute_velocity*0.5, absolute_velocity*0.5);
    } else {
    	color = vec3(0.0, 0.0, 0.0);
    }
}
