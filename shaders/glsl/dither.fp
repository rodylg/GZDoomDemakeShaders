/*
   RetroFX ordered dithering from MariENB
   (C)2012-2019 Marisa Kirisame
   
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
	//#define d(x) x/64.0 //Precalculate instead for speedup
		//Original preprocess ordered dithering index matrix
	/* float dither8[64] = float[]
	(
		d( 0),d(48),d(12),d(60),d( 3),d(51),d(15),d(63),
		d(32),d(16),d(44),d(28),d(35),d(19),d(47),d(31),
		d( 8),d(56),d( 4),d(52),d(11),d(59),d( 7),d(55),
		d(40),d(24),d(36),d(20),d(43),d(27),d(39),d(23),
		d( 2),d(50),d(14),d(62),d( 1),d(49),d(13),d(61),
		d(34),d(18),d(46),d(30),d(33),d(17),d(45),d(29),
		d(10),d(58),d( 6),d(54),d( 9),d(57),d( 5),d(53),
		d(42),d(26),d(38),d(22),d(41),d(25),d(37),d(21)
	); */
		//Replacing the preprocessed ordered dithering index matrix with a 4x4 precalculated one
	COMPAT_PRECISION float dither4[16] = float[]
	(
		0.0000, 0.5000, 0.1250, 0.6250,
		0.7500, 0.2500, 0.8750, 0.3750,
		0.1875, 0.6875, 0.0625, 0.5625,
		0.9375, 0.4375, 0.8125, 0.3125
	);
	//#undef d //Deprecated by precalculating
	float paldith = paldither * 0.00390625;
	vec2 coord = TexCoord;
	vec2 targtres = vec2(targetwt,targetht);
	vec2 sfact = vec2(textureSize(InputTexture,0));
	if ( pixmode != 0 )
	{
		coord = vec2((floor(TexCoord.x*targtres.x)+0.5)/targtres.x,(floor(TexCoord.y*targtres.y)+0.5)/targtres.y);
		sfact.xy = targtres.xy;
	}
	vec4 res = texture(InputTexture,coord);
	if ( res.r <= 0.0 ) res.r -= paldith;
	if ( res.g <= 0.0 ) res.g -= paldith;
	if ( res.b <= 0.0 ) res.b -= paldith;
	if ( res.r >= 1.0 ) res.r += paldith;
	if ( res.g >= 1.0 ) res.g += paldith;
	if ( res.b >= 1.0 ) res.b += paldith;
	res.rgb += paldith*dither4[int(coord.x*sfact.x)%4+int(coord.y*sfact.y)%4*4]-0.5*paldith; //Modified from res.rgb += paldith*dither8[int(coord.x*sfact.x)%8+int(coord.y*sfact.y)%8*8]-0.5*paldith;
	FragColor = res;
}