#version 330 compatibility

uniform sampler2D colortex0;
uniform float frameTimeCounter;

in vec2 texcoord;

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 color;

void main() {
	color = texture(colortex0, texcoord);
	float t = frameTimeCounter * 1.0;
}