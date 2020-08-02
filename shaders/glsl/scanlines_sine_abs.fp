/*
	Scanlines Sine Absolute Value
	An ultra light scanline shader
	by RiskyJumps
	license: public domain
	
	Ported from scanlines-sine-abs.glsl
	from RetroArch
	by Rusco Istar
*/

	// Global compatibility defines
#if __VERSION__ >= 130
	#define COMPAT_VARYING in
	#define COMPAT_TEXTURE texture
#else
	#define COMPAT_VARYING varying
	#define FragColor gl_FragColor
	#define COMPAT_TEXTURE texture2D
#endif
 
#ifdef GL_ES
	#ifdef GL_FRAGMENT_PRECISION_HIGH
		#define PI 3.14159265358979323846264
		precision highp float;
	#else
		#define PI 3.1415927
		precision mediump float;
	#endif
	#define COMPAT_PRECISION mediump
#else
	#define COMPAT_PRECISION
	#define PI 3.14159265358979323846264
#endif

void main()
{
	vec3 color = COMPAT_TEXTURE(InputTexture,TexCoord).rgb;

	float omega = 2.0 * PI * TexCoord.y;
	float angle = (float(targetht) * omega) - (1.0 * PI * phase);
	float lines = clamp(amp * sin(angle), 0.0, 1.0);

	lines *= lineswhite - linesblack;
	lines += linesblack;
	color *= lines;

	FragColor = vec4(color.rgb, 1.0);
}