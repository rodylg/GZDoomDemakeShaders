/*
	simpletex_lcd - a simple, textured LCD shader intended for non-backlit systems

	Makes use of the 'line weighting' equation from zfast_lcd_standard
	[original zfast_lcd_standard code copyright (C) 2017 Greg Hogan (SoltanGris42)]

	Other code by jdgleaver

	Ported from simpletex_lcd-4k.glsl
	from RetroArch to GZDoom
	by Rusco Istar

	- Usage notes:

	Background texture size is hard-coded (I can't find a way to get this
	automatically...). User must ensure that 'BG_TEXTURE_SIZE' define is
	set appropriately. All source image patterns downloaded from 
	www.subtlepatterns.com

	- Adjustable parameters:

	> GRID_INTENSITY: Sets overall visibility of grid effect
				- 1.0: Grid is shown
				- 0.0: Grid is invisible (same colour as pixels)
	> GRID_WIDTH: Sets effective with of grid lines
				- 1.0: Normal full width
				- 0.0: Minimum width
				(Note - this does not mean zero width! Instead, this
				is the minimum 'sane' width, below which the grid
				becomes pointless...)
	> GRID_BIAS: Dynamically adjusts the grid intensity based on pixel luminosity
				- 0.0: Grid intensity is uniform
				- 1.0: Grid intensity scales linearly with pixel luminosity
				> i.e. the darker the pixel, the less the grid effect
				is apparent - black pixels exhibit no grid effect at all
	> DARKEN_GRID: Darkens grid (duh...)
				- 0.0: Grid is white
				- 1.0: Grid is black
	> DARKEN_COLOUR: Simply darkens pixel colours (effectively lowers gamma level of pixels)
				- 0.0: Colours are normal
				- 2.0: Colours are too dark...

	This program is free software; you can redistribute it and/or modify it
	under the terms of the GNU General Public License as published by the Free
	Software Foundation; either version 2 of the License, or (at your option)
	any later version.
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

// ### Magic Numbers...

// Grid pattern
// > Line weighting equation:
//   y = a * (x^4 - b * x^6)
const COMPAT_PRECISION float LINE_WEIGHT_A = 48.0;
const COMPAT_PRECISION float LINE_WEIGHT_B = 8.0 / 3.0;

// RGB -> Luminosity conversion
// > Photometric/digital ITU BT.709
#define LUMA_R 0.2126
#define LUMA_G 0.7152
#define LUMA_B 0.0722
// > Digital ITU BT.601
//#define LUMA_R 0.299
//#define LUMA_G 0.587
//#define LUMA_B 0.114

/* COMPATIBILITY
   - GLSL compilers
*/

// Background texture size
#define BG_TEXTURE_SIZE 4096.0
const COMPAT_PRECISION float INV_BG_TEXTURE_SIZE = 1.0 / BG_TEXTURE_SIZE;

void main()
{
	// Process varying "vertex" variables
	COMPAT_PRECISION vec2 TEX0 = TexCoord * 1.0001;
	COMPAT_PRECISION vec2 OutputSize = vec2(textureSize(InputTexture,0));
	COMPAT_PRECISION vec2 InputSize = vec2(float(targetwt),float(targetht));
	COMPAT_PRECISION vec2 InvInputSize = 1.0 / InputSize;

	// Get current texture coordinate
	COMPAT_PRECISION vec2 imgPixelCoord = TEX0 * InputSize;	//Modified from COMPAT_PRECISION vec2 imgPixelCoord = TEX0.xy * TextureSize.xy;
	COMPAT_PRECISION vec2 imgCenterCoord = floor(imgPixelCoord) + vec2(0.5, 0.5);	//Modified from COMPAT_PRECISION vec2 imgCenterCoord = floor(imgPixelCoord.xy) + vec2(0.5, 0.5);

	// Get colour of current pixel
	COMPAT_PRECISION vec3 colour = vec3(COMPAT_TEXTURE(InputTexture, InvInputSize * imgCenterCoord));	//Modified from COMPAT_PRECISION vec3 colour = COMPAT_TEXTURE(InputTexture, InvTextureSize.xy * imgCenterCoord.xy).rgb;

	// Darken colours (if required...)
	colour = pow(colour, vec3(1.0 + DARKEN_COLOUR));	//Modified from colour.rgb = pow(colour.rgb, vec3(1.0 + DARKEN_COLOUR));

	// Generate grid pattern...
	COMPAT_PRECISION vec2 distFromCenter = abs(imgCenterCoord - imgPixelCoord);	//Modified from COMPAT_PRECISION vec2 distFromCenter = abs(imgCenterCoord.xy - imgPixelCoord.xy);
	COMPAT_PRECISION float xSquared = max(distFromCenter.x, distFromCenter.y);
	xSquared = xSquared * xSquared;
	COMPAT_PRECISION float xQuarted = xSquared * xSquared;

	// > Line weighting equation:
	//   y = 48 * (x^4 - (8/3) * x^6)
	COMPAT_PRECISION float lineWeight = LINE_WEIGHT_A * (xQuarted - (LINE_WEIGHT_B * xQuarted * xSquared));

	// > Apply grid adjustments (phase 1)
	//	- GRID_WIDTH:
	//		1.0: Use raw lineWeight value
	//		0.0: Use lineWeight ^ 2 (makes lines thinner - realistically, this is
	//								the thinnest we can go before the grid effect
	//								becomes pointless, particularly with 'high resolution'
	//								systems like the GBA)
	//	- GRID_INTENSITY:
	//		1.0: Grid lines are white
	//		0.0: Grid lines are invisible
	lineWeight = lineWeight * (lineWeight + ((1.0 - lineWeight) * GRID_WIDTH)) * GRID_INTENSITY;

	// > Apply grid adjustments (phase 2)
	//	- GRID_BIAS:
	//		0.0: Use 'unbiased' lineWeight value calculated above
	//		1.0: Scale lineWeight by current pixel luminosity
	//			> i.e. the darker the pixel, the lower the intensity of the grid
	COMPAT_PRECISION float luma = (LUMA_R * colour.r) + (LUMA_G * colour.g) + (LUMA_B * colour.b);
	lineWeight = lineWeight * (luma + ((1.0 - luma) * (1.0 - GRID_BIAS)));

	// Apply grid pattern
	// (lineWeight == 1 -> set colour to value specified by DARKEN_GRID)
	colour = mix(colour, vec3(1.0 - DARKEN_GRID, 1.0 - DARKEN_GRID, 1.0 - DARKEN_GRID), lineWeight);	//Modified from colour.rgb = mix(colour.rgb, vec3(1.0 - DARKEN_GRID), lineWeight);

	// Get background sample point
	COMPAT_PRECISION vec2 bgPixelCoord = TEX0 * OutputSize;	//Modified from COMPAT_PRECISION vec2 bgPixelCoord = TEX0.xy * (OutputSize.xy * InvInputSize.xy) * TextureSize.xy;
	bgPixelCoord = floor(bgPixelCoord) + vec2(0.5, 0.5);	//Modified from bgPixelCoord = floor(bgPixelCoord.xy) + vec2(0.5, 0.5);

	// Sample background texture and 'colourise' according to current pixel colour
	// (NB: the 'colourisation' here is lame, but the proper method is slow...)
	COMPAT_PRECISION vec3 bgTexture = vec3(COMPAT_TEXTURE(BACKGROUND, bgPixelCoord.xy * INV_BG_TEXTURE_SIZE)) * colour;	//Modified from COMPAT_PRECISION vec3 bgTexture = COMPAT_TEXTURE(BACKGROUND, bgPixelCoord.xy * INV_BG_TEXTURE_SIZE).rgb * colour.rgb;

	// Blend current pixel with background according to luminosity
	// (lighter colour == more transparent, more visible background)
	// Note: Have to calculate luminosity a second time... tiresome, but
	// it's not a particulary expensive operation...
	luma = (LUMA_R * colour.r) + (LUMA_G * colour.g) + (LUMA_B * colour.b);
	colour = mix(colour, bgTexture, luma);	//Modified from colour.rgb = mix(colour.rgb, bgTexture.rgb, luma);

	FragColor = vec4(colour, 1.0);	//Modified from gl_FragColor = vec4(colour.rgb, 1.0);
}