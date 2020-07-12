/*
   Vanilla Essence CRYspace from Pixel Eater
   
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
	vec3 C ;
	vec4 A	= texture( InputTexture, TexCoord );
	A.rgb	= clamp( A.rgb, vec3( 0. ), vec3( 1. ));
	
	if( crymode == 2 && A.r == A.g && A.b == A.r ) C = A.rgb * 249. / 255 ;
	else
	{
		float Aval	= max( max( A.r, A.g ), A.b );
		A.rgb		/= Aval ;
		
		ivec3 B		= ivec3( A.rgb * 63 + .5 );
		int index	= (( B.r << 6 ) + B.g << 6 ) + B.b ;
		int tx		= index & 511 ;
		int ty		= index >> 9 ;
		
		C = texelFetch( LUT, ivec2( tx, ty ), 0 ).rgb ;
		float Cval	= max( max( C.r, C.g ), C.b );
		C			= C / Cval * Aval ;
	}
	
	FragColor = vec4( C, A.a );
}