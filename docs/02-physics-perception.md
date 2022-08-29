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


\begin{figure}
\includegraphics[width=1\linewidth]{images/Perceived_Human_Hearing.svg} \caption{(ref:elc)}(\#fig:elc)
\end{figure}

Why do we need to understand the physics of sound *and* perception of sound? 
Although ultimately we hear the sounds we're going to make, the process of making the sounds is based in physics.
So we need to know how both the physics and perception of sound work, at least a bit.

## Waves

Have you ever noticed a dust particle floating in the air, just randomly wandering around?
That random movement is known as Brownian motion, and it was shown by Einstein to be evidence for the existence of atoms - that you can see with your own eyes!
The movement is caused by air molecules^[In what follows, we will ignore that air is a mixture of gases because it is irrelevant to the present discussion.] bombarding the dust particle from random directions, as shown in Figure \@ref(fig:sim-brownian).

(ref:sim-brownian) [Simulation](https://physics.bu.edu/~duffy/HTML5/brownian_motion.html) of Brownian motion. Press `Pause` to stop the simulation. © Andrew Duffy/[CC-BY-NC-SA-4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/).

\begin{figure}
\href{https://physics.bu.edu/~duffy/HTML5/brownian_motion.html}{\includegraphics[width=1\linewidth]{02-physics-perception_files/figure-latex/sim-brownian-1} }\caption{(ref:sim-brownian)}(\#fig:sim-brownian)
\end{figure}

Air molecules are always whizzing around like this.
However, in much of the discussion below, we'll largely ignore this fact and focus instead on the properties of waves passing through air.

Amazingly, it is also possible to see sound waves moving through the air, using a technique called [Schlieren photography](https://en.wikipedia.org/wiki/Schlieren_photography).
Schlieren photography captures differences in air pressure, and sound is just a difference in air pressure that travels as a wave.

(ref:firecracker-wave) [Animation](http://media.npr.org/assets/img/2014/01/21/cracker.gif) of a firecracker exploding, captured by Schlieren photography. Note the dark pressure wave that radiates outward. Image © Mike Hargather. Linked with [permission from NPR](https://www.npr.org/about-npr/179876898/terms-of-use#LinksNPRServices).

\begin{figure}
\includegraphics[width=1\linewidth]{http://media.npr.org/assets/img/2014/01/21/cracker} \caption{(ref:firecracker-wave)}(\#fig:firecracker-wave)
\end{figure}

<!-- Note: alternative way using YouTube; revert to this if Tumblr fails -->
<!-- (ref:firecracker-wave) [Youtube video](https://www.youtube.com/embed/px3oVGXr4mo?start=125&end=128) of firecracker exploding, captured by Schlieren photography. Note the dark pressure wave that radiates outward. Image [© NPR](https://www.youtube.com/nationalpublicradio). -->

<!-- ```{r firecracker-wave, fig.cap="(ref:firecracker-wave)", echo = F} -->
<!-- embed_youtube("px3oVGXr4mo",125,128) -->
<!-- ``` -->

The animation in Figure \@ref(fig:firecracker-wave) shows a primary wave of sound corresponding to the explosion of the firecracker in slow motion, and we can see that wave radiate outwards from the explosion.

(ref:slow-drum) [Youtube video](https://www.youtube.com/watch?v=tM8WyhB6zYo) of a slow motion drum hit. Watch how the drum head continues to move inward and outward after the hit. Image [© Boulder Drum Studio](https://www.youtube.com/channel/UCRZIyRiTD427A9dw3CBM4Fg).

![(\#fig:slow-drum)(ref:slow-drum)](downloadFigs4latex/slow-drum.jpg) 

Consider the slow motion drum hit in Figure \@ref(fig:slow-drum).
After the stick hits the drum head, the head first moves inward and then outward, before repeating the inward/outward cycle.
When the drum head moves inward, it creates more room for the surrounding air molecules, so the density of the air next to the drum head decreases (i.e. it becomes less dense, because there is more space for the same amount of air molecules).
The decrease in density is called rarefaction.
When the drum head moves outward, it creates less room for the surrounding air molecules, so the density of the air next to the drum head increases (i.e. it becomes more dense, because there is less space for the same amount of air molecules).
The increase in density is called compression.

Sound is a difference in air pressure that travels as a wave through compression and rarefaction.
We could see this with the firecracker example because the explosion rapidly heated and expanded the air, creating a pressure wave on the boundary between the surrounding air and the hot air.
However, as we've seen with the drum and discuss in more detail later in this chapter, musical instruments are designed to create more than a single wave.
The Schlieren photography animation in Figure \@ref(fig:schlieren-wave) is more typical of a musical instrument.

(ref:schlieren-wave) [Animation](http://media.npr.org/assets/img/2014/01/21/speaker1.gif) of a continuous tone from a speaker in slow motion, captured by Schlieren photography. Note the dark pressure wave that radiates outward. Image © Mike Hargather. Linked with [permission from NPR](https://www.npr.org/about-npr/179876898/terms-of-use#LinksNPRServices).

\begin{figure}
\includegraphics[width=1\linewidth]{http://media.npr.org/assets/img/2014/01/21/speaker1} \caption{(ref:schlieren-wave)}(\#fig:schlieren-wave)
\end{figure}

The rings in Figure \@ref(fig:schlieren-wave) represent compression (dark) and rarefaction (light) stages of the wave.
It is important to understand that air molecules aren't moving from the speaker to the left side of the image.
Instead, the wave is moving through the air.

Figure \@ref(fig:sim-wave).

(ref:sim-wave) [Simulation](https://phet.colorado.edu/sims/html/waves-intro/latest/waves-intro_en.html) of sound waves. Simulation by [PhET Interactive Simulations](https://phet.colorado.edu/), University of Colorado Boulder, licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/).

<!-- The block parameters here are very sensitive; slight changes will cause undefined references in pdf (screenshot will appear but not be wrapped in figure) -->
\begin{figure}
\href{https://phet.colorado.edu/sims/html/waves-intro/latest/waves-intro_en.html}{\includegraphics[width=1\linewidth]{02-physics-perception_files/figure-latex/sim-wave-1} }\caption{(ref:sim-wave)}(\#fig:sim-wave)
\end{figure}

## Frequency and pitch

hz

## Amplitude and loudness

db

## Waveshape and timbre

## Phase and ... phase?



You might think that we only need to understand how humans perceive sound and not the physics of it...
