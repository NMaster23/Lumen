 #version 330 compatibility

uniform sampler2D colortex0;
uniform sampler2D colortex1;
uniform sampler2D colortex2;

const vec3 blocklightColor = vec3(1.0, 0.72, 0.45);
const vec3 skylightColor = vec3(0.0, 0.4706, 0.8431);
const vec3 sunlightColor = vec3(0.1);
const vec3 ambientColor = vec3(0.01);

in vec2 texcoord;

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 color;

void main() {
    vec2 lightmap = texture(colortex1, texcoord).xy;
    vec3 encodedNormal = texture(colortex2, texcoord).rgb;
    vec3 normal = normalize((encodedNormal - 0.5) * 2.0);

   color = texture(colortex0, texcoord);

   vec3 blocklight = lightmap.x * blocklightColor;
   vec3 skylight = lightmap.y * skylightColor;
   vec3 ambient = ambientColor;
   vec3 sunlight = sunlightColor; // we'll fix this in a minute!
   color.rgb *= blocklight + skylight + ambient + sunlight;
}