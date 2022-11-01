# Generators {#complex-generators}

This chapter extends Chapter \@ref(generators) and focuses entirely on audio-rate modulation.
Audio-rate modulation uses an audio-rate signal, typically an oscillator, to modulate a parameter, most commonly a parameter on another oscillator.^[Audio-rate modulation of a filter's cutoff is another common option but is beyond the scope of this chapter. Try it!]
Although the basic idea is simple to explain, sounds produced can be complex and require a new idea to understand: the sideband.

Before proceeding, let's introduce some terminology.
The audio rate signal source will be called the *modulator*.
The oscillator receiving the modulation is the *carrier*.
The depth, or strength, of modulation the carrier receives from the modulator will be called the *modulation index*.
The modulation index defines how much the parameter of the carrier changes around its default value.
For example, if a carrier has a frequency of 800 Hz, the modulation index may cause it to go +/- 1 Hz (from 799 to 801 Hz) or +/- 100 Hz (from 700 Hz to 900 Hz).

Recall that we can describe any wave by its shape, amplitude, frequency, and phase.
If we assume we can describe any waveshape by a collection of sine waves via Fourier transform, then we can focus on the amplitude, frequency, and phase parameters of these waves.
Audio-rate modulation can be performed on each of these parameters.
When the modulator acts on the amplitude parameter of the carrier, the result is amplitude modulation (AM).
When the modulator acts on the frequency parameter of the carrier, the result is frequency modulation (FM).
And when the modulator acts on the phase parameter of the carrier, the result is phase modulation (PM).

Each of these types of audio-rate modulation creates sidebands, which are new partials in the output.
Audio-rate modulation therefore is related to additive synthesis in that both involve adding partials to change the timbre of the output sound.
The main difference is that audio-rate modulation is often not strictly additive but also removes or changes some partials in the carrier.
However, with sufficient control of audio-rate modulation, one can create a wide variety of sounds more efficiently than additive synthesis, as shown by the explosion of inexpensive FM keyboards in the 1980's, like the Yamaha DX7.

The following sections outline the use of audio-rate modulation in modular sound synthesis according to the parameters of amplitude, frequency, and phase.
However, the story is more complicated than this due to the history of synthesis, limitations of analogue hardware, and mathematical relationships between methods.
There are actually two families of methods that cover all three parameters, as will be explained.

## Modulating amplitude

AM
side bands
Ring mod


## Modulating frequency

FM
linear/exponential/through zero

<!-- Remaining plan -->


<!-- 	Generators	 -->
<!-- 		PWM -->
<!-- 		FM/AM -->
<!-- 		Ring modulation -->
<!-- audio rate modulation into resonant filter? -->
<!-- 		Vocoders -->
<!-- 		Random sampling -->
<!-- 	Modifiers	 -->
<!-- 		~~LFO~~ -->
<!-- 		~~Sample and hold~~ -->
<!-- 		Slew -->
<!-- 		Wave-folding -->
<!-- 		Attenuators, inverters, and attenuverters -->
<!-- 		Quantizers -->
<!-- 		~~Switches~~ -->
<!-- 		~~Logic~~ -->

<!-- Sound design ideas -->
<!-- Cymbal PUSH UNTIL AFTER RING MOD -->
<!-- Maybe use these? -->
<!-- keyboard filter tracking or notes would disappear; filtering sine wave example -->
<!-- Growl: Low frequency sine wave modulation of the filter cut-off frequency -->
<!-- wah wah is LFO on LPF cutoff freq -->



<!-- Actual -->
<!--     4 Basic Modeling Concepts -->
<!--     4.1 Modules are the model elements -->
<!--     4.2 Signals are how the model elements interact -->
<!--     4.3 Signals are interpreted by modules -->
<!--     4.4 Pulling it all together -->
<!--         4.4.1 Drone -->
<!--         4.4.2 Using an oscilloscope -->
<!--         4.4.3 Controlling pitch -->
<!--         4.4.4 Controlling note duration (on/off volume) -->
<!--         4.4.5 Controlling note dynamics (volume during note) -->
<!--     4.5 Moving forward -->

<!-- 5 Controllers -->
<!-- 5.1 Clocks -->

<!--     5.1.1 Clock under a scope -->
<!--     5.1.2 Clock as a generator -->

<!-- 5.2 Sequencers -->

<!--     5.2.1 Clocks as sequencers -->
<!--     5.2.2 Trigger sequencers -->
<!--     5.2.3 Control voltage sequencers -->


<!--     6 Generators -->
<!--     6.1 Chords -->
<!--     6.2 Chorus -->
<!--     6.3 Low frequency oscillators & uses -->
<!--         6.3.1 Pulse width modulation -->
<!--         6.3.2 Vibrato -->
<!--         6.3.3 Tremolo -->
<!--     6.4 Synchronization -->
<!--     6.5 Noise -->
<!--     6.6 Samplers -->

<!-- 7 Modifiers -->
<!-- 7.1 Effects -->
<!--     7.1.1 Delays -->
<!--     7.1.2 Reverb -->
<!--     7.1.3 Chorus -->
<!--     7.1.4 Flanger -->
<!--     7.1.5 Phaser -->
<!-- 7.2 Voltage controlled filters -->
<!--     7.2.1 Filters are imperfect -->
<!--     7.2.2 Filters change frequency and phase -->
<!--     7.2.3 Combining filters -->
<!--     7.2.4 Resonance -->


<!-- 8 Designing a Kick Drum -->
<!-- 8.1 Problem solving for sound synthesis -->
<!--     8.1.1 Understand the problem -->
<!--     8.1.2 Devise a plan -->
<!--     8.1.3 Carry out the plan (and replanning) -->
<!--     8.1.4 Evaluate the solution -->
<!-- 8.2 Reviewing previous kick drum patches -->
<!--     8.2.1 Sine with envelope -->
<!--     8.2.2 Sine with an envelope plus noise burst -->
<!-- 8.3 Alternative approaches -->
<!--     8.3.1 Improving our understanding of the problem -->
<!--     8.3.2 Devising new plans -->
<!--     8.3.3 Working backwards -->


<!-- 9 Eighties Lead & Chiptune -->
<!-- 9.1 Eighties Lead -->
<!--     9.1.1 Waveshape -->
<!--     9.1.2 Dynamics -->
<!-- 9.2 Chiptune -->
<!--     9.2.1 Triad arpeggio -->
<!--     9.2.2 LFO PWM -->
<!--     9.2.3 Secondary sequencer for transposition -->
<!--     9.2.4 Hats and kick -->


<!-- 10 Controllers -->
<!-- 10.1 Modifying gates -->
<!-- 10.2 Making gates with logic -->
<!-- 10.3 Adding/removing gates with probability -->
<!-- 10.4 Speed variable clocks using LFOs -->
<!-- 10.5 Euclidean rhythm -->
<!-- 10.6 Sequential switches -->
