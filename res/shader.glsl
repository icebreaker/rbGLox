[vertex]
uniform float time;
	
void main()
{
	gl_FrontColor = gl_Color;
	gl_TexCoord[0] = gl_MultiTexCoord0;
	gl_Position = ftransform();
}
[end]

[fragment]
uniform float time;
uniform float offset;
uniform vec2 discardOffset;
uniform sampler2D tex0;
uniform sampler2D tex1;
uniform sampler2D tex2;
uniform sampler2D tex3;
	
void main()
{
	vec2 st = gl_TexCoord[0].st;

	if(st.t < discardOffset[0] || st.s < discardOffset[1]) 
		discard;

	gl_FragColor = texture2D(tex0, st * offset);
}
[end]

[uniforms]
discardOffset: [0.1, 0.1]
offset: 0.3
[end]
