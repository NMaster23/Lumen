#version 330 compatibility

in vec4 mc_Entity;
out float blockid;
out vec2 lmcoord;
out vec2 texcoord;
out vec4 glcolor;
out vec3 normal;
uniform float frameTimeCounter;
uniform vec3 cameraPosition;

void main() {
	blockid = mc_Entity.x;
    vec4 pos = gl_Vertex;
    vec3 worldPos = pos.xyz + cameraPosition;
    if (blockid == 10001) {
        vec3 worldPos = pos.xyz;
	    float windPhase = worldPos.x * 0.25 + worldPos.z * 0.35 + frameTimeCounter * 2.0;
	    float heightFactor = clamp(fract(worldPos.y), 0.0, 1.0);
	    float swayStrength = 0.05 + heightFactor * 0.1;
        vec3 sway = vec3(sin(windPhase) * swayStrength, cos(windPhase * 0.8) * swayStrength * 0.6, 0.0) * heightFactor;
	    pos.xyz += sway;
    }
	if (blockid == 10002) {
        vec3 worldPos = pos.xyz;
	    float windPhase = worldPos.x * 0.25 + worldPos.z * 0.35 + frameTimeCounter * 2.0;
	    float heightFactor = clamp(fract(worldPos.y), 0.0, 1.0);
	    float swayStrength = 0.05 + heightFactor * 0.1;
        vec3 sway = vec3(sin(windPhase) * swayStrength, cos(windPhase * 0.8) * swayStrength * 0.6, 0.0) * heightFactor;
	    pos.xyz += sway;
    }
	gl_Position = gl_ModelViewProjectionMatrix * pos;
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
    lmcoord  = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
    glcolor  = gl_Color;
	normal = normalize(gl_NormalMatrix * gl_Normal);
}