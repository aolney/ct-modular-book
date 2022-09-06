# Harmonic Sounds

In Section \@ref(waveshape-and-timbre) we reviewed the four common waveshapes and corresponding instruments with similar timbre.
However, we did not explain *why* the waveshapes have their own distinctive timbre.
The short answer is that the different waveshapes have different harmonics.
Understanding the relationship between waveshape and harmonics will be extremely useful to you as you design your own sounds.
In order to explain the harmonics behind the different waveshape timbres, we need to understand what harmonics are and how they are created.

## Phase reflections and standing waves

When we discussed wave phase and interference in Section \@ref(phase-and-interference), we mentioned the importance of phase and reflection in musical instruments.
Before going any further, ask yourself what makes something a musical instrument?
Is a stick hitting a sheet of paper a musical instrument?
What about a stick hitting an empty glass?

A common property of musical instruments is that they make tones rather than noise.^[Inharmonic sounds involving noise will be discussed in the next chapter.]
Tones are created by waves reflecting in the instrument to create standing waves and get rid of noise.
Standing waves are fairly similar and straightforward in [strings and pipes](http://www.phys.unsw.edu.au/jw/basics.html) compared to the [complexities in drums and cymbals](http://www.ness.music.ed.ac.uk/archives/systems/3d-embeddings), but since the principle is the same everywhere, we'll limit our discussion to strings, where the waves are easily visible.

Standing waves are created when two waves moving in opposite directions interfere with each other to create a new wave that appears to remain in place (i.e. it "stands" rather than moves).
In a string, the two waves are created by an initial wave that reflects back from the ends of the string, which creates an out of phase wave.
Figure \@ref(fig:sim-reflect) shows a simulation of a reflected wave.
Select the checkbox for `Pulse` and move `Damping` to `None`, then press the green button to initiate a pulse.
As you can see, when the pulse reaches a fixed end, it reflects both in direction and in phase, i.e. if it is above the line going right, it will flip below the line and go left when it hits a fixed end.
<!-- Once the wave has traversed the string a few times, move `Damping` higher and watch the wave die out. -->
<!-- Damping is an important property that removes energy from the system. -->
<!-- In an instrument, damping is what removes noise a bit faster than standing waves, allowing us to hear a tone. -->

(ref:sim-reflect) [Simulation](https://phet.colorado.edu/sims/html/wave-on-a-string/latest/wave-on-a-string_en.html) of waves on a string. Simulation by [PhET Interactive Simulations](https://phet.colorado.edu/), University of Colorado Boulder, licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/).

<!-- The block parameters here are very sensitive; slight changes will cause undefined references in pdf (screenshot will appear but not be wrapped in figure) -->
<div class="figure">
<a href="https://phet.colorado.edu/sims/html/wave-on-a-string/latest/wave-on-a-string_en.html" target="_blank"><img src="03-harmonic-sounds_files/figure-epub3/sim-reflect-1.png" alt="(ref:sim-reflect)" width="100%" /></a>
<p class="caption">(\#fig:sim-reflect)(ref:sim-reflect)</p>
</div>

You can use the same simulation to make a standing wave.
Set `Amplitude` to .20, `Frequency` to .17, `Damping` to `None`, `Tension` to `Low`, and select `Oscillate`.
These settings will send a wave from the left to interfere with the reflected wave coming back from the right.
You will very quickly see a standing wave with three nodes, indicated by the green beads.
Two of the nodes are at either end of the string, and the third node is exactly in the middle.
This standing wave is the 2nd harmonic.
You can make the first harmonic (commonly called the fundamental frequency) by reducing `Frequency` to half, $.17 / 2 = .085 \approx .09$ and hitting restart.
Observe that the only nodes are the two ends of the string.
Finally, you can create additional harmonics by multiplying the frequency of the fundamental by integers greater than 1.
Try $.085 * 3 = .255 \approx .26$, $.085 * 4 = 34$, $.085 * 5 = .425 \approx .43$, etc.
Note the green beads don't always mark nodes, which by definition don't move; instead the green beads sometimes mark antinodes, or places of greatest motion.

For the odd harmonics, the simulation requires us to do some rounding that results in an imperfect standing wave.
Eventually these imperfect standing waves will cancel out because they are not true standing waves.
True standing waves on our string model have frequencies that are perfectly aligned with the length of our string.
When this happens, the two waves that create the standing wave constructively interfere with each other, i.e. they are self-reinforcing.
We can see this in the simulation when we don't round the frequencies because the amplitude of the waves keeps increasing over time as we add more energy into the system through the oscillator on the left hand side.
Any wave whose frequency does not create a standing wave will eventually cancel itself out.

Standing waves explain why harmonics are integer multiples of the fundamental frequency.
In the simulation for the first harmonic, the oscillator started its second pulse at the moment the first reflected pulse returned to the oscillator, so the first pulse had to travel twice the length of the string.
For the second harmonic, the oscillator started its second pulse at the moment the first pulse reached the fixed end, or the full length of the string.
In each case, the speed of the wave must evenly divide the length of the string (giving an integer) in order for the out of phase passing waves to align and create a standing wave.
The integer relationship of harmonics is very important to how we perceive musical instruments and may even be the reason for our perception of fundamental musical relationships like octaves and [fifths](https://en.wikipedia.org/wiki/Perfect_fifth).
For example, recall from Section \@ref(frequency-and-pitch) than one octave above a pitch is double the frequency of that pitch.
Since the second harmonic is double the frequency of the fundamental, the second harmonic is one octave above the fundamental frequency.
Similarly, the third harmonic is one fifth above the second harmonic.^[One might speculate that we created instruments in order to consistently create pitches based on the fundamental, but the instruments instilled in us a music theory as a side effect of their harmonics.]

Before moving on, it's important to note that the oscillator simulation in Figure \@ref(fig:sim-reflect) does not accurately represent what happens in a plucked string because the simulation doesn't fix both sides of the string.
Instead, the simulation uses an oscillator on one side to generate sine waves.
We can, however, observe a very similar behavior to the simulation when a string is plucked, as shown the slow motion video in Figure \@ref(fig:tap-string).
In the video, the tap on the string (a reverse of a pluck) creates two pulses that move in opposite directions, reflect off their respective ends of the string and switch phase, and then constructively interfere in the center to create an apparent standing wave.

(ref:tap-string) [Youtube video](https://www.youtube.com/watch?v=9O3VEXzuOKI) of a slow motion tap on a long string. Watch how the tap creates two pulses that reflect off their respective ends of the string, switching phase, and then constructively interfere to create an apparent standing wave. Image [© Kemp Strings](https://www.youtube.com/c/KempStrings).

<div class="figure">
<img src="downloadFigs4latex/tap-string.jpg" alt="(ref:tap-string)"  />
<p class="caption">(\#fig:tap-string)(ref:tap-string)</p>
</div>

Although Figure \@ref(fig:tap-string) looks straightforward and might lead us to believe that the differences between the simulation and plucking a string are superficial, the true story is more complicated.
A real string pluck does not create a single standing wave but rather a [stack of standing waves happening all at once](https://physics.stackexchange.com/a/412746).
This is because, unlike the simulation in \@ref(fig:sim-reflect), the wave created by plucking a string is not a sine wave but has an initial shape [more like a triangle](https://physics.stackexchange.com/questions/111780/why-do-harmonics-occur-when-you-pluck-a-string).
In addition, a string pluck is highly likely [not to occur in the middle of the string](https://physics.stackexchange.com/questions/411175/fourier-series-analysis/411177#411177).
These differences mean that when a string is plucked, waves of all different frequencies are created and begin racing back and forth on the string.
Those that correspond to harmonic frequencies are sustained longer and create a tone.
The remaining frequencies are known as [transients](https://en.wikipedia.org/wiki/Transient_(acoustics)) and quickly cancel out.^[Transients are commonly modeled using noise in electronic music in order to make a simulated sound more realistic.]

<!-- ## Frequency spectrum, resonators, and formants -->

## Resonators, formants, and frequency spectrum

In a real string instrument, the vibrations of the strings are transmitted to the rest of the instrument, which includes a [resonator](https://en.wikipedia.org/wiki/Helmholtz_resonance) that is typically shaped like a box with an opening.
The resonator vibrates at the same frequencies as the string (primarily the harmonic frequencies as discussed) but pushes against a larger volume of air than the string, which has a small surface area by comparison. 
Therefore the resonator creates a larger change in air pressure for a higher amplitude (and louder) sound wave.
The resonator does not amplify the string frequencies perfectly, however.
Some frequencies are better amplified than others, and this means that the resonator affects the timbre of the instrument.
This is why two guitars with different resonators will sound different even if they have identical strings.
The effect a resonator has on a frequency's amplitude is called [Q](https://en.wikipedia.org/wiki/Q_factor), and the relative strengths of frequencies emitted by a resonator are called formants.^[You will often see the word "formants" applied to human speech, where the resonator is the vocal tract, but it also applies to instruments with resonators.]

Although we've focused on standing waves in strings and their final production of sound through a resonator, you can probably imagine how differences in the construction and operation of other instruments might lead to the differences in the four waveshapes presented in Section \@ref(waveshape-and-timbre): each instrument might have different harmonics that are further amplified or attenuated by the resonator.
Wouldn't it be nice if we could somehow see all the harmonics involved, and how they align with the waveshape?
It turns out we can decompose any complex waveshape into components using a technique called [Fourier analysis](https://en.wikipedia.org/wiki/Fourier_analysis).
Each component extracted by Fourier analysis is a sine wave called a partial, and we can reconstruct the complex wave by adding the sine waves together (potentially an infinite number of them).
When the waveshape is from a harmonic instrument, the partials are harmonics, so we can use Fourier analysis to see all the harmonics in a waveshape.

Figure \@ref(fig:fourier-waves) shows how Fourier analysis can use sine waves to approximate more complext waves...

(ref:fourier-waves) [Simulation](https://phet.colorado.edu/sims/html/fourier-making-waves/latest/fourier-making-waves_en.html?screens=1) showing how Fourier analysis can approximate a complex wave using sine waves. Simulation by [PhET Interactive Simulations](https://phet.colorado.edu/), University of Colorado Boulder, licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/).

<!-- The block parameters here are very sensitive; slight changes will cause undefined references in pdf (screenshot will appear but not be wrapped in figure) -->
<div class="figure">
<a href="https://phet.colorado.edu/sims/html/fourier-making-waves/latest/fourier-making-waves_en.html?screens=1" target="_blank"><img src="03-harmonic-sounds_files/figure-epub3/fourier-waves-1.png" alt="(ref:fourier-waves)" width="100%" /></a>
<p class="caption">(\#fig:fourier-waves)(ref:fourier-waves)</p>
</div>


Fourier series, see phet simulation
Frequency spectra of the 4 waves


Tonal sounds	
	Common waves, harmonics, spectrum
	Fourier series
	Envelopes
	Music concepts: semitones, scales, notes, timbre, polyphony
Rhythmic sounds	
	Noise: white/pink/brown
	Envelopes
	Music concepts: beats, timbre, polyrhythm
	
	

