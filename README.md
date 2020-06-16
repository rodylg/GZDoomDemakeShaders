# GZDoomDemakeShaders
GLSL shaders for GZDoom 3.5.0+ that simulate various vintage systems.

## Project's Scope
Doom has been ported to countless devices, most of which have enough processing ability to run the game natively. But that wasn't always the case, and many older computers and video game consoles by 1993 simply were just not powerful enough to run this almighty game. While this situation hasn't changed at all for those aging systems, it's now possible to use modern source code ports and hardware to simulate what the game might have looked like on systems with less than the minimum requirements (80386DX@33MHz CPU, 4MB DRAM, 20MB HDD & VGA Graphics). There is certainly some charm and interest around the retro-computing look; low resolutions and constrained color palettes are an aesthetic that keeps on giving nostalgic thrills. This mod is for those who want some chunky pixely goodness.

## Roadmap of Features
- [x] **Palette Reduction w/ Ordered Dither:** Part of the [MariFX](https://github.com/OrdinaryMagician/marifx_m) Shaders for GZDoom, modified to accept more than 64 palettes and optimized to reduce it's video memory footprint.
- [ ] **Multiple retro-systems palettes and color modes:** Videogame home consoles and portable systems, Vintage graphic systems, Monochrome, Grayscale and various RGB levels/bit-depths.
- [ ] **Resolution scaler w/ Non-squared Pixel Aspect Ratios**
- [ ] **"Low-Detail" mode (double-width pixels)**
- [ ] **Customisable Scanlines**
- [ ] **CRT and LCD simulation**
- [ ] **NTSC TV-output Color grading**

## Version History
**0.0.1 (2020-06-16)**
* Implemented the modified MariFX's Palette Reduction w/ Dither GLSL shader.
* Added Greyscale and monochrome palettes to test this prototype.
* Implemented the options menu.

## Acknowledgements
* [Adam Mathes](https://trenchant.org/daily/2013/8/19/): Identity CLUT primer.
* [Ahefner](https://ahefner.livejournal.com/11670.html): NES color palette and color emphasis bits info.
* [Alex Charlton](http://alex-charlton.com/posts/Dithering_on_the_GPU/): Dithering on the GPU primer.
* [Alison Watson](https://github.com/marrub--/zdoom-doc): ZScript documentation.
* [Jeremy Selan](https://developer.nvidia.com/gpugems/gpugems2/part-iii-high-quality-rendering/chapter-24-using-lookup-tables-accelerate-color): GLSL LUT optimized shaders.
* [khronos.org](https://www.khronos.org/opengl/wiki/GLSL_Optimizations#Get_MAD): GLSL Optimizations and general documentation.
* [Marisa Kirisame](https://github.com/OrdinaryMagician/marifx_m): Palette Reduction w/ Dither GLSL shader.
* [Sigvatr](https://www.doomworld.com/forum/topic/55710-ega-doom-version-20/): EGA Doom.
* [Zdoom.org](https://zdoom.org/wiki/Main_Page): (G)ZDoom wiki.
