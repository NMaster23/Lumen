#version 330 compatibility

uniform sampler2D lightmap;
uniform sampler2D gtexture;

uniform float alphaTestRef = 0.1;

in vec2 lmcoord;
in vec2 texcoord;
in vec4 glcolor;

uniform int worldTime;
float t = float(worldTime);

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 color;

vec4 water_rgba = vec4(0.1803921569, 0.5450980392, 0.6039215686, 1.0);
vec4 water_rgba2 = vec4(0.0, 0.0, 0.5, 0.01);

void main() {
	color = texture(gtexture, texcoord) * glcolor;
	color *= texture(lightmap, lmcoord);
	float daynight = mod(t, 24000.0);
	float fade;
	if (daynight <= 13000.0) {
		fade = smoothstep(0.0, 13000.0, daynight);
	} else {
		fade = 1.0 - smoothstep(13000.0, 24000.0, daynight);
	}
	color.rgb = mix(water_rgba.rgb, water_rgba2.rgb, fade);
	if (color.a < alphaTestRef) {
		discard;
	}
}