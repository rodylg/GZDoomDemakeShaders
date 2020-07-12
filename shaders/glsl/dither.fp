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
		//Replacing the preprocessed ordered dithering index matrix
	COMPAT_PRECISION float dither8[64] = float[]
	(
		0.000000,0.750000,0.187500,0.937500,0.046875,0.796875,0.234375,0.984375,
		0.500000,0.250000,0.687500,0.437500,0.546875,0.296875,0.734375,0.484375,
		0.125000,0.875000,0.062500,0.812500,0.171875,0.921875,0.109375,0.859375,
		0.625000,0.375000,0.562500,0.312500,0.671875,0.421875,0.609375,0.359375,
		0.031250,0.781250,0.218750,0.968750,0.015625,0.765625,0.203125,0.953125,
		0.531250,0.281250,0.718750,0.468750,0.515625,0.265625,0.703125,0.453125,
		0.156250,0.906250,0.093750,0.843750,0.140625,0.890625,0.078125,0.828125,
		0.656250,0.406250,0.593750,0.343750,0.640625,0.390625,0.578125,0.328125
	);
	//#undef d //Deprecated by precalculating
	vec2 coord = TexCoord;
	vec2 targtres = vec2(targetwt/(1+lowdetail),targetht);
	vec2 sfact = textureSize(InputTexture,0);
	if ( pixmode != 0 )
	{
		if ( lowdetail == 0 )
			coord = vec2((floor(TexCoord.x*targtres.x)+0.5)/targtres.x,(floor(TexCoord.y*targtres.y)+0.5)/targtres.y);
		else
			coord = vec2((floor(TexCoord.x*targtres.x)+0.25)/targtres.x,(floor(TexCoord.y*targtres.y)+0.5)/targtres.y);
		sfact.xy = targtres.xy;
	}
	vec4 res = texture(InputTexture,coord);
	if ( res.r <= 0.0 ) res.r -= paldither;
	if ( res.g <= 0.0 ) res.g -= paldither;
	if ( res.b <= 0.0 ) res.b -= paldither;
	if ( res.r >= 1.0 ) res.r += paldither;
	if ( res.g >= 1.0 ) res.g += paldither;
	if ( res.b >= 1.0 ) res.b += paldither;
	res.rgb += paldither*dither8[int(coord.x*sfact.x)%8+int(coord.y*sfact.y)%8*8]-0.5*paldither;
	FragColor = res;
}