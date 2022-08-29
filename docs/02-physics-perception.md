# (PART) Sound {-}

# Physics and Perception

From the outset, it's important to understand that the physics of sound and how we perceive it are not the same.
This is a simple fact of biology.
Birds can see ultraviolet, and bats can hear ultrasound; humans can't do either.
Dogs have up to 40 times more olfactory receptors than humans and correspondingly have a much keener sense of smell.
We can only perceive what our bodies are equipped to perceive.

In addition to the limits of our perception, our bodies also *structure* sensations in ways that don't always align with physics.
A good example of this is [equal loudness contours](https://en.wikipedia.org/wiki/Equal-loudness_contour).
As shown in Figure \@ref(fig:elc), sounds can appear equally loud to humans across frequencies even though the actual sound pressure level (a measure of sound energy) is not constant. 
In other words, our hearing becomes more sensitive depending on the frequency of the sound.

(ref:elc) An equal loudness contour showing improved sensitivity to frequencies between 500Hz and 4KHz, which approximately matches the range of human speech frequencies. Image [public domain](https://en.wikipedia.org/wiki/Psychoacoustics#/media/File:Perceived_Human_Hearing.svg).


<div class="figure">
<img src="images/Perceived_Human_Hearing.svg.png" alt="(ref:elc)" width="100%" />
<p class="caption">(\#fig:elc)(ref:elc)</p>
</div>

Why do we need to understand the physics of sound *and* perception of sound? 
Although ultimately we hear the sounds we're going to make, the process of making the sounds is based in physics.
So we need to know how both the physics and perception of sound work, at least a bit.

## Waves

Have you ever noticed a dust particle floating in the air, just randomly wandering around?
That random movement is known as Brownian motion, and it was shown by Einstein to be evidence for the existence of atoms - that you can see with your own eyes!
The movement is caused by air molecules^[In what follows, we will ignore that air is a mixture of gases because it is irrelevant to the present discussion.] bombarding the dust particle from random directions, as shown in Figure \@ref(fig:sim-brownian).

(ref:sim-brownian) [Simulation](https://physics.bu.edu/~duffy/HTML5/brownian_motion.html) of Brownian motion. Press `Pause` to stop the simulation. © Andrew Duffy/[CC-BY-NC-SA-4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/).

<div class="figure">
<a href="https://physics.bu.edu/~duffy/HTML5/brownian_motion.html" target="_blank"><img src="02-physics-perception_files/figure-epub3/sim-brownian-1.png" alt="(ref:sim-brownian)" width="100%" /></a>
<p class="caption">(\#fig:sim-brownian)(ref:sim-brownian)</p>
</div>

Air molecules are always whizzing around like this.
However, in much of the discussion below, we'll largely ignore this fact and focus instead on the properties of waves passing through air.

Amazingly, it is also possible to see sound waves moving through the air, using a technique called [Schlieren photography](https://en.wikipedia.org/wiki/Schlieren_photography).
Schlieren photography captures differences in air pressure, and sound is just a difference in air pressure that travels as a wave.

(ref:firecracker-wave) [Animation](http://media.npr.org/assets/img/2014/01/21/cracker.gif) of a firecracker exploding in slow motion, captured by Schlieren photography. Note the dark pressure wave that radiates outward. Image © Mike Hargather. Linked with [permission from NPR](https://www.npr.org/about-npr/179876898/terms-of-use#LinksNPRServices).

<div class="figure">
<img src="downloadFigs4latex/firecracker-wave.jpg" alt="(ref:firecracker-wave)" width="100%" />
<p class="caption">(\#fig:firecracker-wave)(ref:firecracker-wave)</p>
</div>

<!-- Note: alternative way using YouTube; revert to this if Tumblr fails -->
<!-- (ref:firecracker-wave) [Youtube video](https://www.youtube.com/embed/px3oVGXr4mo?start=125&end=128) of firecracker exploding, captured by Schlieren photography. Note the dark pressure wave that radiates outward. Image [© NPR](https://www.youtube.com/nationalpublicradio). -->

<!-- ```{r firecracker-wave, fig.cap="(ref:firecracker-wave)", echo = F} -->
<!-- embed_youtube("px3oVGXr4mo",125,128) -->
<!-- ``` -->

The animation in Figure \@ref(fig:firecracker-wave) shows a primary wave of sound corresponding to the explosion of the firecracker in slow motion, and we can see that wave radiate outwards from the explosion.

(ref:slow-drum) [Youtube video](https://www.youtube.com/watch?v=tM8WyhB6zYo) of a slow motion drum hit. Watch how the drum head continues to move inward and outward after the hit. Image [© Boulder Drum Studio](https://www.youtube.com/channel/UCRZIyRiTD427A9dw3CBM4Fg).

<div class="figure">
<img src="downloadFigs4latex/slow-drum.jpg" alt="(ref:slow-drum)"  />
<p class="caption">(\#fig:slow-drum)(ref:slow-drum)</p>
</div>

Consider the slow motion drum hit in Figure \@ref(fig:slow-drum).
After the stick hits the drum head, the head first moves inward and then outward, before repeating the inward/outward cycle.
When the drum head moves inward, it creates more room for the surrounding air molecules, so the density of the air next to the drum head decreases (i.e. it becomes less dense, because there is more space for the same amount of air molecules).
The decrease in density is called rarefaction.
When the drum head moves outward, it creates less room for the surrounding air molecules, so the density of the air next to the drum head increases (i.e. it becomes more dense, because there is less space for the same amount of air molecules).
The increase in density is called compression.

You can see an analogous simulation of to the drum hit in Figure \@ref(fig:sim-gas).
If you add say 50 particles, grab the handle on the left, and move it to the right, the volume of the chamber decreases, and the pressure in the chamber goes up (compression).
Likewise, if you move the handle to the left, the volume of the chamber increases, and the pressure goes down (rarefaction).
In the drum example, when the stick hits the head and causes it to move inward, the volume of air above the head will rush in to fill that space (rarefaction), and when the head moves outward, the volume of air above the head will shrink (compression).

(ref:sim-gas) [Simulation](https://phet.colorado.edu/sims/html/gas-properties/latest/gas-properties_en.html?screens=2) of gas in a chamber. Simulation by [PhET Interactive Simulations](https://phet.colorado.edu/), University of Colorado Boulder, licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/).

<!-- The block parameters here are very sensitive; slight changes will cause undefined references in pdf (screenshot will appear but not be wrapped in figure) -->
<div class="figure">
<a href="https://phet.colorado.edu/sims/html/gas-properties/latest/gas-properties_en.html?screens=2" target="_blank"><img src="02-physics-perception_files/figure-epub3/sim-gas-1.png" alt="(ref:sim-gas)" width="100%" /></a>
<p class="caption">(\#fig:sim-gas)(ref:sim-gas)</p>
</div>

Sound is a difference in air pressure that travels as a wave through compression and rarefaction.
We could see this with the firecracker example because the explosion rapidly heated and expanded the air, creating a pressure wave on the boundary between the surrounding air and the hot air.
However, as we've seen with the drum and will discuss in more detail later in this chapter, musical instruments are designed to create more than a single wave.
The Schlieren photography animation in Figure \@ref(fig:schlieren-wave) is more typical of a musical instrument.

(ref:schlieren-wave) [Animation](http://media.npr.org/assets/img/2014/01/21/speaker1.gif) of a continuous tone from a speaker in slow motion, captured by Schlieren photography. Note the dark pressure wave that radiates outward. Image © Mike Hargather. Linked with [permission from NPR](https://www.npr.org/about-npr/179876898/terms-of-use#LinksNPRServices).

<div class="figure">
<img src="downloadFigs4latex/schlieren-wave.jpg" alt="(ref:schlieren-wave)" width="100%" />
<p class="caption">(\#fig:schlieren-wave)(ref:schlieren-wave)</p>
</div>

The rings in Figure \@ref(fig:schlieren-wave) represent compression (dark) and rarefaction (light) stages of the wave.
It is important to understand that air molecules aren't moving from the speaker to the left side of the image.
Instead, the wave is moving the entire distance, and the air molecules are only moving a little bit as a result of the wave.^[The air molecules are moving randomly in general, so the simulation shows only the movement attributable to the effect of the wave.]

To see how this works, take a look at the simulation in Figure \@ref(fig:sim-wave).
Hit the green button to start the sound waves and then select the `Particles` radio button.
The red dots are markers to help you see how much the air is moving as a result of the wave.
As you can see, every red dot is staying in their neighborhood and only moving as a result of compression and rarefaction cycles.
If you select the `Both` radio button, you can see the outlines of waves on top of the air molecules.
Note how each red dot is moving back and forth between a white band and a dark band.
If you further select the `Graph` checkbox, you will see that the white bands in this simulation correpond to increases in pressure and the black bands correspond to decreases in pressure.
This type of graph is commonly used to describe waves, so make sure you feel comfortable with it before moving on.

(ref:sim-wave) [Simulation](https://phet.colorado.edu/sims/html/waves-intro/latest/waves-intro_en.html?screens=2) of sound waves. Simulation by [PhET Interactive Simulations](https://phet.colorado.edu/), University of Colorado Boulder, licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/).

<!-- The block parameters here are very sensitive; slight changes will cause undefined references in pdf (screenshot will appear but not be wrapped in figure) -->
<div class="figure">
<a href="https://phet.colorado.edu/sims/html/waves-intro/latest/waves-intro_en.html?screens=2" target="_blank"><img src="02-physics-perception_files/figure-epub3/sim-wave-1.png" alt="(ref:sim-wave)" width="100%" /></a>
<p class="caption">(\#fig:sim-wave)(ref:sim-wave)</p>
</div>

## Frequency and pitch

hz

## Amplitude and loudness

db

## Waveshape and timbre

## Phase and ... phase?



You might think that we only need to understand how humans perceive sound and not the physics of it...
