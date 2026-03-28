#version 330 compatibility

uniform sampler2D lightmap;
uniform sampler2D gtexture;

uniform float alphaTestRef = 0.1;

in vec2 lmcoord;
in vec2 texcoord;
in vec4 glcolor;

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 color;

vec4 water_rgba = vec4(0.1803921569, 0.5450980392, 0.6039215686, 1.0);
void main() {
	color = texture(gtexture, texcoord) * glcolor;
	color *= texture(lightmap, lmcoord);
	color.rgb = water_rgba.rgb;
	if (color.a < alphaTestRef) {
		discard;
	}
}