# Generators

Generators create audible sound.
Chapter \@ref(basic-modeling-concepts) introduced oscillators, which are the prototypical generator.
This chapter expands upon oscillators and how they can be combined together to produce fuller and more interesting sounds.
Additionally, two new generators are introduced, noise and samplers.
Noise can also be combined with oscillators and other generators to create richer and more realistic sound.
Samplers represent the extreme of realism in generators, at least as far as their digital representation allows.

<!-- https://docs.google.com/document/d/19EkU7Ypa6J5FYPeDNzVzeNc1qc1sGrxfDMu7Nw2PAgU/edit -->

## Chords 

<!-- chords -->
<!-- - chords from clock division; suboctaves from clock divider -->
<!-- - chords from voltage division -->

Section \@ref(phase-reflections-standing-waves-and-harmonics) briefly mentioned the relationship between harmonics and fundamental relationships like octaves and fifths.
To recap, the second harmonic has double the frequency of the first and so is one octave above the first harmonic.
We can express this relationship as 2:1, i.e. an octave is twice the frequency of the the fundamental.
Similarly the third harmonic is a fifth above the second harmonic, so we can express a fifth as 3:2.^[Whole number ratios require [just intonation](https://en.wikipedia.org/wiki/Just_intonation). The twelve tone [equal temperment](https://en.wikipedia.org/wiki/Equal_temperament) used in Western music is a close approximation, e.g. 3:2 is 1.498 in twelve tone equal temperment.]

Now consider what happens if two notes an octave apart or a fifth apart are played at the same time.
Clearly some of their harmonics will be the same.
Thus playing two or more notes this way will add and enhance harmonics beyond that of a single note, creating a richer and fuller sound.
Of course, notes may be played that are not harmonically related, to a different effect.^[The reader may be interested in [consonance/dissonance](https://en.wikipedia.org/wiki/Consonance_and_dissonance) as discussed in music theory.]
When two notes are played simultaneously, it is called an [interval](https://en.wikipedia.org/wiki/Interval_(music)), with three notes, a [trichord](https://en.wikipedia.org/wiki/Trichord), with four notes, a [tetrachord](https://en.wikipedia.org/wiki/Tetrachord), etc.
Many harmonically related notes can be played simultaneously to good effect.
For example, the [THX Deep Note](https://en.wikipedia.org/wiki/Deep_Note) in Figure \@ref(fig:deep-note) resolves to 11 notes, mostly harmonically related by 3, 4, and 7 semitones (minor/major thirds and fifths). 

(ref:deep-note) [Youtube video](https://www.youtube.com/watch?v=sPY3Y2qhyXk) of the THX Deep Note, which resolves to 11 harmonically related notes. Image [© THX Ltd](https://www.youtube.com/c/THXLtd).

<div class="figure">
<img src="downloadFigs4latex/deep-note.jpg" alt="(ref:deep-note)"  />
<p class="caption">(\#fig:deep-note)(ref:deep-note)</p>
</div>

In modular synthesis, there are at least two ways to create chords, which correspond to stages of the process to create a single note.
At the first stage, we have a V/Oct control signal, so we can create chords by making new control signals harmonically related to the original signal.
At the final stage, we have an audio signal, so we can create chords by making new audio signals harmonically related to the original signal.
Let's look at both.

To create harmonically related control voltage signals, we can use a voltage offset module to create new signals offset from the original signal, i.e. the original voltage plus/minus a harmonically-related voltage.
It can take a little math to do this if the offset module is labeled in volts^[Recall 1 V/Oct means a semitone is 1/12 of a volt.], but if the offset module is labeled in semitones, it is [fairly straightforward](https://en.wikipedia.org/wiki/Interval_(music)#Main_intervals), e.g. a fifth is seven semitones.
Additionally we will need multiple oscillators to play a note for each offset voltage.
We could reasonably do this with separate oscillators, but some chord-oriented modules contain multiple oscillators and take separate V/Oct for each.
Try making a trichord using a fifth and an octave using the button in Figure \@ref(fig:voltage-division-chords).

(ref:voltage-division-chords) [Virtual modular](https://cardinal.olney.ai) for making a chord using signal offsets.

<!-- MODAL HTML BLOCK -->


<!-- CAPTION BLOCK -->
<div class="figure">
<img src="images/launch-virtual-modular-button.png" alt="(ref:voltage-division-chords)" width="100%" />
<p class="caption">(\#fig:voltage-division-chords)(ref:voltage-division-chords)</p>
</div>

To create harmonically related audio signals, we can use a clock divider as long as the original signal can be interpreted as clock and the clock divider in question can accept audio rates.
This approach is related to a classic technique for creating a fatter sound, the sub-octave square wave.
A sub-octave square wave is exactly that: a square wave one octave below the fundamental.
Since a clock division of $/2$ cuts the source clock frequency in half, we can easily generate a sub-octave square wave using a clock divider, albeit with the same assumptions.
Perhaps more interestingly, if our clock divider supports both even and odd divisions we can create subharmonic chords, or perhaps more appropriately, an [inverted chord](https://en.wikipedia.org/wiki/Inversion_(music)). 
All that is required is knowing the harmonic ratios mentioned above, e.g. 3:2 means that the divisions $/3$ and $/2$ are a fifth apart.
Try making a trichord using a fifth and an octave using the button in Figure \@ref(fig:clock-division-chords).

(ref:clock-division-chords) [Virtual modular](https://cardinal.olney.ai) for making a chord using clock divisions.

<!-- MODAL HTML BLOCK -->


<!-- CAPTION BLOCK -->
<div class="figure">
<img src="images/launch-virtual-modular-button.png" alt="(ref:clock-division-chords)" width="100%" />
<p class="caption">(\#fig:clock-division-chords)(ref:clock-division-chords)</p>
</div>

## Chorus and Sync

We can also combine different oscillators using the same, or almost the same pitch.
As discussed in Section \@ref(phase-reflections-standing-waves-and-harmonics), two identical waves will constructively interfere with each other and produce a new wave with twice the amplitude.
However, if the waves are slightly out of phase or have slightly different frequencies, a subtle interference pattern will be produced that slowly changes the amplitude and timbre of the sound over time.
This effect is used in pianos, which have more than one string for most notes, as well as 12-string guitars that have six pairs of identical strings.
In fact, this effect is so general is used as an audio processing effect called [chorus](https://en.wikipedia.org/wiki/Chorus_(audio_effect)).

To achieve this effect in modular, one only needs to slightly detune one of the VCOs with respect to the other or change the phase relationship between oscillators.
Typically two independent oscillators will already be out of phase, but in modules that contain multiple oscillators there is sometimes a control to adjust the phase of one oscillator with respect to the others.



sync
- hard/soft

## Low-frequency oscillators

lfo
- vibrato
- tremolo

## Pulse width modulation

pwm
- briefly recap interference?

## Noise

noise
- blue snare/red kick

## Samplers

samplers
- sample rate/bit depth
- 12key/lfo

<!-- 		Oscillators (VCO) /LFO ; morphing between waveshapes/ PWM /sync-->
<!-- noise -->
<!-- 		Samplers -->


<!-- Tremelo/vibrato? -->
<!-- Fundamental Modules and Composition		 -->
<!-- 	Basic concepts	 -->
<!-- 		 Module categories, signals, signal interpretation, 5 patchs from drone to key controller for pitch/gate with amplitude envelope -->
<!-- 	Controllers	 -->
<!-- 		Controllers -->
<!-- 		Trigger/gate, phase, sync -->
<!-- 	Generators	 -->
<!-- 		Oscillators (VCO) /LFO ; morphing between waveshapes/ PWM /sync-->
<!-- noise -->
<!-- 		Samplers -->
<!-- 	Modifiers	 -->
<!-- 		Filters (VCF): poles, slopes, cutoff frequency, resonance -->
<!-- 		Envelopes, velocity sensitivity, aftertouch -->
<!-- 		Amplifiers -->
<!-- 		Effects: delay/reverb/panning -->

<!-- Complex modules and Compositions		 -->
<!-- 	Controllers	 -->
<!-- 		Clock, sequencing, arpggiators -->
<!-- 		Euclidean rhythms -->
<!-- 		Probability -->
<!-- 	Generators	 -->
<!-- 		PWM -->
<!-- 		FM/AM -->
<!-- 		Ring modulation -->
<!-- 		Vocoders -->
<!-- 		Random sampling -->
<!-- 	Modifiers	 -->
<!-- 		LFO -->
<!-- 		Sample and hold -->
<!-- 		Slew -->
<!-- 		Wave-folding -->
<!-- 		Attenuators, inverters, and attenuverters -->
<!-- 		Quantizers -->
<!-- 		Switches -->
<!-- 		Logic -->


