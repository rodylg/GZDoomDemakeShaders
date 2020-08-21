# GZDoomDemakeShaders
GLSL shaders for GZDoom 3.5.0+ that simulate various vintage systems.

## Project's Scope
Doom has been ported to countless devices, most of which have enough processing ability to run the game natively. But that wasn't always the case, and many older computers and video game consoles by 1993 simply were just not powerful enough to run this almighty game. While this situation hasn't changed at all for those ageing systems, it's now possible to use modern source code ports and hardware to simulate what the game might have looked like on systems with less than the minimum requirements (80386DX@33MHz CPU, 4MB DRAM, 20MB HDD & VGA Graphics). There is certainly some charm and interest around the retro-computing look; low resolutions and constrained colour palettes are an aesthetic that keeps on giving nostalgic thrills. This mod is for those who want some chunky pixely goodness.

## Roadmap of Features
- [x] **Refresh Rate Limiter:** Control the max frame rate of the engine.
- [x] **Palette Reduction w/ Ordered Dither:** Part of the [MariFX](https://github.com/OrdinaryMagician/marifx_m) Shaders for GZDoom, modified to accept more than 64 palettes and optimized to reduce its video memory footprint.
- [x] **Multiple retro-systems palettes and colour modes:** Videogame home consoles and portable systems, Vintage graphic systems, Monochrome, Grayscale and various RGB levels/bit-depths.
- [x] **Resolution scaler w/ Non-squared Pixel Aspect Ratios**
- [x] **"Low-Detail" mode (double-width pixels)**
- [x] **Customizable Scanlines and LCD Grid**
- [ ] **CRT and LCD simulation**
- [ ] **NTSC TV-output Color grading**

## Version History
**0.4.0-beta (2020-08-21)**
* LCD Grid shader implemented.
* New control to modify the power of the scanlines amplitude. Linear gives the most round shape while higher degrees give them a more squared shape.
* Amended all the CLUT files to crush blacks and improve visibility.
* Organized the menu for less clutter. Scanlines and LCD Grid controls are now in their own submenus.
* New emergency button to turn off all the menu obstructing shaders. It's especially useful as render resolution increases.

**0.3.1-beta (2020-08-02)**
* Fixed compatibility of the scanlines shader for Delta Touch.
* Added an extra control for fine-tuning the scanlines between odd and even fields.
* Changed the Bayer Matrix in the dithering shader for a more retro-pleasing looking result.
* The scale for measuring dithering strength has been re-normalized to describe "levels of dithering" instead.
* Added a secret testing map with a grayscale gradient textured wall for the purpose of calibrating the strength of the dithering shader. Type "map DITHTEST" in the console to get to it.
* The default values of dithering and scanlines were adjusted.

**0.3.0-beta (2020-07-27)**
* Scanlines shader implemented.
* Bug in dithering shader behaviour corrected.
* Amended Sega Genesis' CLUT to crush blacks and improve visibility.

**0.2.2-beta (2020-07-14)**
* Ordered dither now works as originally intended with "Low Detail" mode.
* Added an extra mode to apply full-screen pixel dithering.
* Minor spelling issues corrected.

**0.2.1-beta (2020-07-13)**
* Pixelizer shader finalized.
* Updated the menu items.
* Bugfixes for Delta Touch.

**0.2.0-alpha (2020-07-11)**
* The Pixelizer update. Its shader is WIP.
* Implemented a modified Rachael's "low detail" shader.
* Moved the dithering shader to its own pass on the pipeline.
* Added a CLUT atlas method. It can be faster on certain video cards but increases memory usage.
* Added Sega Jaguar's CRY palette and Nintendo's Virtual Boy palette.

**0.1.0-pre (2020-07-10)**
* The Game Boy Color update. Added the GBC palettes.
* Changed the namespace for the CLUT files to avoid collisions with other PWAD's textures.
* Bugfixes for Delta Touch.

**0.0.7 (2020-07-03)**
* The Super Game Boy update. Added the SGB palettes.
* Compatibility test code for Delta Touch.

**0.0.6 (2020-06-29)**
* The monochromatic update. Added a bunch of monochrome palettes for phosphor CRTs and LCDs.
* Added some CLUTs to test the Game Boy palettes.
* Yet another attempt at fixing Delta Touch.

**0.0.5 (2020-06-27)**
* Added Apple IIgs, EGA, VGA and 9/12/15/16/18 bits palettes.
* Amended Amiga OCS/ECS and MSX2 CLUTs.
* Attempted fix for Delta Touch.

**0.0.4 (2020-06-26)**
* Added CGA, RISC, Windows, Macintosh, UNIX, Web-safe, Generic 4-bit RGBI, 3-level RGB, and 8-bit palettes.
* Attempted fix for Delta Touch.

**0.0.3 (2020-06-25)**
* Added Commodore Systems, CoCo3, ZX Spectrum, Mattel Aquarius, SAM Coupé, MSX|MSX2, Thomson TO7/70|TO5 and Amstrad CPC palettes.
* Collapsed Atari 2600 SECAM|Teletext 1|BBC Micro|Sinclair QL|Thomson TO7 into the R1G1B1 palette.
* New Refresh Rate Limit menu featuring Frame Rate Control.

**0.0.2 (2020-06-19)**
* Added NES, Sega Master System, Apple II, Atari Series and WS-Teletext palettes.
* Optimizations to the Palette shader. (Precalculated dithering index matrix, new CLUT format)
* Changed the default value for dithering.

**0.0.1 (2020-06-16)**
* Implemented the modified MariFX's Palette Reduction w/ Dither GLSL shader.
* Added Greyscale and monochrome palettes to test this prototype.
* Implemented the options menu.

## Acknowledgements
* [Adam Mathes](https://trenchant.org/daily/2013/8/19/): Identity CLUTs primer.
* [Ahefner](https://ahefner.livejournal.com/11670.html): NES colour palette and colour emphasis bits info.
* [Alex Charlton](http://alex-charlton.com/posts/Dithering_on_the_GPU/): "Dithering on the GPU" primer.
* [Alison Watson](https://github.com/marrub--/zdoom-doc): ZScript documentation.
* [Jeremy Selan](https://developer.nvidia.com/gpugems/gpugems2/part-iii-high-quality-rendering/chapter-24-using-lookup-tables-accelerate-color): GLSL LUT optimized shaders.
* [khronos.org](https://www.khronos.org/opengl/wiki/GLSL_Optimizations#Get_MAD): GLSL Optimizations and general documentation.
* [Marisa Kirisame](https://github.com/OrdinaryMagician/marifx_m): Palette Reduction w/ Dither GLSL shader.
* [Pixel Eater](https://forum.zdoom.org/memberlist.php?mode=viewprofile&u=20921): Atari Jaguar Color Space GLSL shader (from Vanilla Essence).
* [Rachael](https://forum.zdoom.org/memberlist.php?mode=viewprofile&u=429): Low detail shader.
* [RiskyJumps](https://github.com/libretro/glsl-shaders/blob/master/scanlines/shaders/scanlines-sine-abs.glsl): Scanlines shader from libretro.
* [Sigvatr](https://www.doomworld.com/forum/topic/55710-ega-doom-version-20/): EGA Doom.
* [Super Mario Wiki](https://www.mariowiki.com/Super_Game_Boy#Color_palettes): Super Game Boy colour palettes info.
* [VCCE](https://github.com/VCCE/VCC): Tandy CoCo3 palette.
* [Zdoom.org](https://zdoom.org/wiki/Main_Page): (G)ZDoom wiki.