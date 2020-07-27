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
		precision highp float;
	#else
		precision mediump float;
	#endif
	#define COMPAT_PRECISION mediump
#else
	#define COMPAT_PRECISION
#endif

void main()
{
	vec3 color = COMPAT_TEXTURE(InputTexture,TexCoord).rgb;
	float grid;

	float lines;

	lines = sin(TexCoord.y * 2 * 3.14159265358979323846264 * targetht - 1.0 );
	lines *= amp;
	lines *= lineswhite - linesblack;
	lines += linesblack;
	color *= lines;

	FragColor = vec4(color.rgb, 1.0);
}