/*
   Low Detail Shader from Rachael
   
   Modified on 2020-07-11 by Rusco Istar
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
	vec2 coord;
	vec2 targtres = vec2(targetwt/(1+lowdetail),targetht);
	if ( lowdetail == 0 )
		coord = vec2((floor(TexCoord.x*targtres.x)+0.5)/targtres.x,(floor(TexCoord.y*targtres.y)+0.5)/targtres.y);
	else
		coord = vec2((floor(TexCoord.x*targtres.x)+0.25)/targtres.x,(floor(TexCoord.y*targtres.y)+0.5)/targtres.y);
	FragColor = texture(InputTexture,coord);
}