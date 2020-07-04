# GZDoomDemakeShaders
GLSL shaders for GZDoom 3.5.0+ that simulate various vintage systems.

## Project's Scope
Doom has been ported to countless devices, most of which have enough processing ability to run the game natively. But that wasn't always the case, and many older computers and video game consoles by 1993 simply were just not powerful enough to run this almighty game. While this situation hasn't changed at all for those aging systems, it's now possible to use modern source code ports and hardware to simulate what the game might have looked like on systems with less than the minimum requirements (80386DX@33MHz CPU, 4MB DRAM, 20MB HDD & VGA Graphics). There is certainly some charm and interest around the retro-computing look; low resolutions and constrained color palettes are an aesthetic that keeps on giving nostalgic thrills. This mod is for those who want some chunky pixely goodness.

## Roadmap of Features
- [x] **Refresh Rate Limiter:** Control the max frame rate of the engine.
- [x] **Palette Reduction w/ Ordered Dither:** Part of the [MariFX](https://github.com/OrdinaryMagician/marifx_m) Shaders for GZDoom, modified to accept more than 64 palettes and optimized to reduce it's video memory footprint.
- [ ] **Multiple retro-systems palettes and color modes:** Videogame home consoles and portable systems, Vintage graphic systems, Monochrome, Grayscale and various RGB levels/bit-depths.
- [ ] **Resolution scaler w/ Non-squared Pixel Aspect Ratios**
- [ ] **"Low-Detail" mode (double-width pixels)**
- [ ] **Customisable Scanlines**
- [ ] **CRT and LCD simulation**
- [ ] **NTSC TV-output Color grading**

## Version History
**0.0.7 (2020-07-03)**
* The Super Game Boy update. Added the SGB palettes.
* Compatibility test code for Delta Touch.

**0.0.6 (2020-06-29)**
* The monochromatic update. Added a bunch of monochrome palettes for phosphor CRTs and LCDs.
* Added some CLUTs to test the Game Boy palettes.
* Yet another attempt at fixing Delta Touch.

**0.0.5 (2020-06-27)**
* Added Apple IIgs, EGA, VGA and 9/12/15/16/18 bits palettes.
* Ammended Amiga OCS/ECS and MSX2 CLUTs.
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
* [Ahefner](https://ahefner.livejournal.com/11670.html): NES color palette and color emphasis bits info.
* [Alex Charlton](http://alex-charlton.com/posts/Dithering_on_the_GPU/): "Dithering on the GPU" primer.
* [Alison Watson](https://github.com/marrub--/zdoom-doc): ZScript documentation.
* [Jeremy Selan](https://developer.nvidia.com/gpugems/gpugems2/part-iii-high-quality-rendering/chapter-24-using-lookup-tables-accelerate-color): GLSL LUT optimized shaders.
* [khronos.org](https://www.khronos.org/opengl/wiki/GLSL_Optimizations#Get_MAD): GLSL Optimizations and general documentation.
* [Marisa Kirisame](https://github.com/OrdinaryMagician/marifx_m): Palette Reduction w/ Dither GLSL shader.
* [Sigvatr](https://www.doomworld.com/forum/topic/55710-ega-doom-version-20/): EGA Doom.
* [Super Mario Wiki](https://www.mariowiki.com/Super_Game_Boy#Color_palettes): Super Game Boy color palettes info.
* [VCCE](https://github.com/VCCE/VCC): Tandy CoCo3 palette.
* [Zdoom.org](https://zdoom.org/wiki/Main_Page): (G)ZDoom wiki.