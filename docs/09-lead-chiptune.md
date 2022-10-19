# Eighties Lead & Chiptune
<!-- sic 'Stranger Lead'? -->

This chapter explores additional sound design problems using the problem solving approach elaborated in Chapter \@ref(designing-a-kick-drum).
The first problem is to recreate an 80's-style lead from the show [*Stranger Things*](https://en.wikipedia.org/wiki/Stranger_Things).
The major strategy used to this problem is working backwards, since the goal is to emulate something that already exists.
The second problem is to create a chiptune-style groove reminiscent of arcade games and early computers.
For the chiptune problem, the main strategies are decomposition and looking at related problems.

## Eighties Lead

The music of the show *Stranger Things* [uses vintage synthesizers](https://www.synthhistory.com/post/interview-with-kyle-dixon-michael-stein) in order to match the 1980's setting of the show.
The theme song uses an [arpeggio](https://en.wikipedia.org/wiki/Arpeggio) as a lead.
An arpeggio is a type of broken chord, or chord that is played one note at a time.
Arpeggios are a common element in electronic music likely because many synthesizers (and VCOs) have historically been monophonic and so can only play one note at a time.
Recreating the *Stranger Things* arpeggio in modular is an interesting sound design problem because it requires working backward from the recording and doing a little detective work to infer how the sound was originally created.

### Waveshape

The first step is to determine the waveshape used in the arpeggio.
Because the theme is composed using vintage synthesizers, we can expect it to use basic waveshapes like sine, triangle, saw, or square rather than a complex wavetable.
Listen to the theme in Figure \@ref(fig:stranger-things-theme) to see if you can identify what kind of waveshape is used, paying particular attention to the brightness of the sound, which indicates higher harmonics.

(ref:stranger-things-theme) [YouTube video](https://youtu.be/-RcPZdihrp4) of the *Stranger Things* theme song. Image [© Netflix](https://www.youtube.com/c/strangerthings).

<div class="figure">
<img src="downloadFigs4latex/stranger-things-theme.jpg" alt="(ref:stranger-things-theme)"  />
<p class="caption">(\#fig:stranger-things-theme)(ref:stranger-things-theme)</p>
</div>

To me, it starts off a bit dull, like a sine or triangle, then gets brighter around 15 seconds, duller again around 30 seconds, and has a quick run up to brightness around 50 seconds.
The brightness suggests that the waveshape is either saw or square.
We'll return to the change in brightness in the next section.

Saws and square waves can be distinguished by their frequency spectrum as discussed in Section \@ref(resonators-formants-and-frequency-spectrum).
Specifically, saws have both even and odd harmonics, whereas squares have only odd harmonics.
Thus a frequency spectrum could help identify which waveshape is being used.
Using a frequency spectrum this way allows us to use the working backwards strategy and also use the frequency spectrum as an evaluation criteria.

It is much more convenient to use Audacity than R here because Audacity allows a portion of a track to be auditioned and then frequency spectrum to be computed for that portion.
This makes it relatively easy to isolate a portion of the song with just a single note of the arpeggio while it is bright.^[To calculate frequency spectrum in Audacity, drag select the region of the audio, audition it using the play button, and then use Analyze -> Plot Spectrum. A high window size is needed for a detailed spectrum, e.g. 4096.]
Figure \@ref(fig:stranger-things-theme-frequency-audacity-7-top-4096) shows the frequency spectrum of a single note of the arpeggio around the 50 second mark. 

(ref:stranger-things-theme-frequency-audacity-7-top-4096) Frequency spectrum of a single note from the *Stranger Things* theme arpeggio.

<div class="figure">
<img src="images/stranger-things-theme-frequency-audacity-7-top-4096.png" alt="(ref:stranger-things-theme-frequency-audacity-7-top-4096)" width="100%" />
<p class="caption">(\#fig:stranger-things-theme-frequency-audacity-7-top-4096)(ref:stranger-things-theme-frequency-audacity-7-top-4096)</p>
</div>


Characteristics of the frequency peaks are shown in Table \@ref(tab:stranger-things-ref-peaks), including the harmonic ratio of each peak with the fundamental.
Assume for a moment that these are harmonics even though the harmonic ratios are not strictly integers.
Since both even and odd harmonics are present, this spectrum is consistent with a saw wave.
However, this pattern is also close to that of two square waves, one with a fundamental at 40 Hz and one with a fundamental at 82 Hz.^[Because 80 Hz is the second harmonic of 40 Hz, the odd harmonics of the 80 Hz square wave would match half the even harmonics of 40 Hz.]

The ambiguity between a single saw and two squares can interrogated by examining the amplitudes in Table \@ref(tab:stranger-things-ref-peaks).
The amplitude peaks at 82 Hz and 164 Hz could be from constructive interference, specifically a saw at 40 Hz and a square at 82 Hz where the square reinforces the existing harmonics of the saw.
Alternatively, these amplitude peaks could potentially be created by two square waves where the square wave at 82 Hz is mixed in more strongly.


Table: (\#tab:stranger-things-ref-peaks) Characterisitcs of the frequency peaks in Figure \@ref(fig:stranger-things-theme-frequency-audacity-7-top-4096).

| Frequency | Amplitude  | Harmonic Ratio |
|-----------|------------|----------------|
| 40        | -39.1      | 1.00           |
| 82        | -25.2      | 2.05           |
| 122       | -39.6      | 3.05           |
| 164       | -27.4      | 4.10           |
| 204       | -40.5      | 5.10           |
| 247       | -43.7      | 6.18           |
| 285       | -43.4      | 7.13           |
| 326       | -37.1      | 8.15           |
| 367       | -46.9      | 9.18           |
| 410       | -40.6      | 10.25          |

These possibilities can be examined by modeling each in modular.
The problem solving approach then is to create a model of each possibility and then use them to reason about how the true frequency spectrum was created.
This is a subtle, yet significant shift in using modular: we are now using it to create alternative models in order to reason about the correct model.

Try patching two square waves at 40 and 82 Hz and a saw and square wave at the same frequencies using the button in Figure \@ref(fig:st-square40-square82).
Because the current spectrum analyzers available in Rack are too noisy to closely compare with the target spectrum, you'll need to [record output with Audacity](https://manual.audacityteam.org/man/tutorial_recording_audio_playing_on_the_computer.html) and [plot spectrum there](https://manual.audacityteam.org/man/plot_spectrum.html).^[The Bogaudio spectrum analyzers are sufficient for *approximately* matching spectrum at higher quality settings, but these are not currently working in Cardinal and so must be used in VCVRack. High quality spectrum comparisons currently require Audacity regardless.]

(ref:st-square40-square82) [Virtual modular](https://cardinal.olney.ai) for assessing whether two square waves or a saw and a square wave are a closer match for the target spectrum.

<!-- MODAL HTML BLOCK -->


<!-- CAPTION BLOCK -->
<div class="figure">
<img src="images/launch-virtual-modular-button.png" alt="(ref:st-square40-square82)" width="100%" />
<p class="caption">(\#fig:st-square40-square82)(ref:st-square40-square82)</p>
</div>

Figure \@ref(fig:stranger-things-two-squares-and-saw-square-mixed-to-match-sample7) shows the frequency spectrum of the two square waves and the saw plus square wave model. 
In both cases, the first three harmonics approximately match the target spectrum in Figure \@ref(fig:stranger-things-theme-frequency-audacity-7-top-4096), but they diverge on the 4th harmonic.
Our inability to get the 4th harmonic with either of these models suggests another element is needed.
One possibility is a third wave, but we may also be able to further adjust the spectrum in our existing models by applying PWM to the square waves. 
Try adding PWM to the 82 Hz square wave in both models to match the target spectrum using the button in Figure \@ref(fig:st-square40-square82at36pwm).

(ref:stranger-things-two-squares-and-saw-square-mixed-to-match-sample7) Frequency spectrum of two square waves (upper) and a saw and square wave (lower) at 40 and 82 Hz, respectively.

<div class="figure">
<img src="images/stranger-things-two-squares-and-saw-square-mixed-to-match-sample7.png" alt="(ref:stranger-things-two-squares-and-saw-square-mixed-to-match-sample7)" width="100%" />
<p class="caption">(\#fig:stranger-things-two-squares-and-saw-square-mixed-to-match-sample7)(ref:stranger-things-two-squares-and-saw-square-mixed-to-match-sample7)</p>
</div>


(ref:st-square40-square82at36pwm) [Virtual modular](https://cardinal.olney.ai) for assessing whether two square waves or a saw and a square wave are a closer match for the target spectrum, when PWM is applied to the higher frequency square wave.

<!-- MODAL HTML BLOCK -->


<!-- CAPTION BLOCK -->
<div class="figure">
<img src="images/launch-virtual-modular-button.png" alt="(ref:st-square40-square82at36pwm)" width="100%" />
<p class="caption">(\#fig:st-square40-square82at36pwm)(ref:st-square40-square82at36pwm)</p>
</div>

Figure \@ref(fig:stranger-things-square40-square82at36pwm-mixed-to-match-sample7) shows the effect of PWM on the 82 Hz square wave.
In both cases, the 4th harmonic got boosted but not enough to match the target spectrum in Figure \@ref(fig:stranger-things-theme-frequency-audacity-7-top-4096).
However there is a nice flattening of harmonics 5-7 that matches the target spectrum, which suggests PWM should be kept.
Thus it seems necessary to add another wave at the 4th harmonic (164 Hz). 
A square wave is appropriate because it would more precisely target the 4th harmonic, whereas a saw would affect the 4th harmonic relatively less and increase successive harmonics more evenly.
Try adding an additional square VCO at 164 Hz square wave in both models to match the target spectrum using the button in Figure \@ref(fig:st-square40-square82at36pwm-square164).

(ref:stranger-things-square40-square82at36pwm-mixed-to-match-sample7) Frequency spectrum of two square waves (upper) and a saw and square wave (lower) at 40 and 82 Hz, respectively, when the 82 Hz wave is pulse width modulated with a 36% duty cycle.

<div class="figure">
<img src="images/stranger-things-square40-square82at36pwm-mixed-to-match-sample7.png" alt="(ref:stranger-things-square40-square82at36pwm-mixed-to-match-sample7)" width="100%" />
<p class="caption">(\#fig:stranger-things-square40-square82at36pwm-mixed-to-match-sample7)(ref:stranger-things-square40-square82at36pwm-mixed-to-match-sample7)</p>
</div>

(ref:st-square40-square82at36pwm-square164) [Virtual modular](https://cardinal.olney.ai) for assessing whether two square waves or a saw and a square wave, both with PWM applied to the higher frequency square wave, are a closer match for the target spectrum when an additional square wave is added at the 4th harmonic.

<!-- MODAL HTML BLOCK -->


<!-- CAPTION BLOCK -->
<div class="figure">
<img src="images/launch-virtual-modular-button.png" alt="(ref:st-square40-square82at36pwm-square164)" width="100%" />
<p class="caption">(\#fig:st-square40-square82at36pwm-square164)(ref:st-square40-square82at36pwm-square164)</p>
</div>


Figure \@ref(fig:stranger-things-square40-square82at36pwm-square164-mixed-to-match-sample7) shows the effect of the new 164 Hz square wave.
In both cases, the 4th harmonic looks good and the spectrum is a good match to the target spectrum for the first 8 harmonics.
Choosing between them is therefore somewhat subjective, but the all square wave spectrum seems to match the target spectrum a bit more closely to me in the higher harmonics, so let's use that as we move to the next step.

(ref:stranger-things-square40-square82at36pwm-square164-mixed-to-match-sample7) Frequency spectrum of three square waves (upper) and a saw with two square waves (lower) at 40, 82, and 164 Hz, respectively, when the 82 Hz wave is pulse width modulated with a 36% duty cycle.

<div class="figure">
<img src="images/stranger-things-square40-square82at36pwm-square164-mixed-to-match-sample7.png" alt="(ref:stranger-things-square40-square82at36pwm-square164-mixed-to-match-sample7)" width="100%" />
<p class="caption">(\#fig:stranger-things-square40-square82at36pwm-square164-mixed-to-match-sample7)(ref:stranger-things-square40-square82at36pwm-square164-mixed-to-match-sample7)</p>
</div>

### Dynamics

It was previously noted that the arpeggio changes in brightness over time.
We know that filter sweeps are a common effect that would change brightness. 
Since the brightness comes and goes every 15 seconds (1/15 = .07 Hz), we could set up an LFO to change the cutoff on an LPF that would, presumably, create the change in brightness we're looking for.
However, there seems to be another more subtle change to the brightness, which is the shape of the envelope.
Take another listen to the target recording and see if you hear more pronounced notes when the arpeggio is bright and more slurred notes when the the arpeggio is dull.
We can try to use the same LFO to affect the ASDR envelope to create this effect as well.

Before moving on with dynamics, it makes sense to update the patch with sequenced notes rather than a constant pitch.
This will facilitate going back and forth between the patch and the target recording when making small parameter changes.
Try setting up the arpeggio using the button in Figure \@ref(fig:st-seq-arp-no-modulated-dynamics).
This will require adding a clock and sequencer, tuning the sequencer steps, and running the VCOs through an envelope.
The arpeggio plays up and down over a broken C major 7th chord: low C, E, G, B, C, B, G, and E.

(ref:st-seq-arp-no-modulated-dynamics) [Virtual modular](https://cardinal.olney.ai) for setting up an arpeggio using the final patch from Section \@ref(waveshape).

<!-- MODAL HTML BLOCK -->


<!-- CAPTION BLOCK -->
<div class="figure">
<img src="images/launch-virtual-modular-button.png" alt="(ref:st-seq-arp-no-modulated-dynamics)" width="100%" />
<p class="caption">(\#fig:st-seq-arp-no-modulated-dynamics)(ref:st-seq-arp-no-modulated-dynamics)</p>
</div>

Now we can add dynamics to the patch as previously discussed.
Try adding a VCF and an LFO to control both the VCF and the ADSR  using the button in Figure \@ref(fig:st-seq-arp-plus-dynamics).
Deciding the VCF and ADSR's setpoints and just how much the LFO will affect them can require a lot of back and forth as the changes are fairly subtle.


(ref:st-seq-arp-plus-dynamics) [Virtual modular](https://cardinal.olney.ai) for adjusting  dynamics using the arpeggio patch from Figure \@ref(fig:st-seq-arp-no-modulated-dynamics).

<!-- MODAL HTML BLOCK -->


<!-- CAPTION BLOCK -->
<div class="figure">
<img src="images/launch-virtual-modular-button.png" alt="(ref:st-seq-arp-plus-dynamics)" width="100%" />
<p class="caption">(\#fig:st-seq-arp-plus-dynamics)(ref:st-seq-arp-plus-dynamics)</p>
</div>

Altogether the solution seems fairly reasonable, though since the waveshapes were based on a sample of the the spectrum in a particular part of the overall cycle, it could be that the lowest square wave should be a saw in order to sound correct as the filter cutoff cycles up and down.
Other possibilities in our current design space include a slight detuning between square waves that changes over time or PWM that changes over time.

## Chiptune

Chiptune is a genre of music so-called because it originated in sound chips used to synthesize music in early electronics like arcade games and computers.
These early sound chips had low-fidelity digital implementations of various functions we've encountered in modular, like basic waveshapes, noise generators, and envelopes.
Because the sound chips were relatively limited in capability, designers developed various techniques to create bigger and more interesting sounds.
One of these tricks, the arpeggio, allowed chips with limited polyphony to emulate it, and thus arpeggio, particularly fast arpeggio, is common in chiptune. 

Our design problem is to create a rapid arpeggio reminiscent of chiptune that transposes over time, along with simple percussion in the form of hats and kick drum.
Let's use a decomposition strategy and look at related problems along the way, using the following sequence:

- Triad arpeggio
- LFO-controlled PWM 
- Secondary sequencer for transposition
- Hats and kick

Building this out incrementally nicely illustrates the power of decomposition into related problems we already know how to solve.

### Triad arpeggio

We made an arpeggio in the previous patch, so this that is a related solution we can adapt.
A few changes are necessary for chiptune however.
First, arpeggios in chiptune are very fast.
Second, we need a new chord to work from.
Let's go with A minor, so A, B, E.
Try patching up this arpgeggio from scratch using the button in Figure \@ref(fig:chiptune-single-arp).

(ref:chiptune-single-arp) [Virtual modular](https://cardinal.olney.ai) for setting up a chiptune arpeggio.

<!-- MODAL HTML BLOCK -->


<!-- CAPTION BLOCK -->
<div class="figure">
<img src="images/launch-virtual-modular-button.png" alt="(ref:chiptune-single-arp)" width="100%" />
<p class="caption">(\#fig:chiptune-single-arp)(ref:chiptune-single-arp)</p>
</div>

### LFO PWM

We previously controlled PWM using an LFO in Section \@ref(pulse-width-modulation), so it is easy to adapt that solution to control the square wave chiptune VCO.
Additionally, let's add an ADSR to control the VCA to get more note-like dynamics.
Try patching up the LFO into a PWM and ADSR using the button in Figure \@ref(fig:chiptune-single-arp-pwm).

(ref:chiptune-single-arp-pwm) [Virtual modular](https://cardinal.olney.ai) for setting up an enveloped chiptune arpeggio with pulse-width modulated by an LFO.

<!-- MODAL HTML BLOCK -->


<!-- CAPTION BLOCK -->
<div class="figure">
<img src="images/launch-virtual-modular-button.png" alt="(ref:chiptune-single-arp-pwm)" width="100%" />
<p class="caption">(\#fig:chiptune-single-arp-pwm)(ref:chiptune-single-arp-pwm)</p>
</div>

### Secondary sequencer for transposition

The transposition element is the most novel technique in this patch, relative to what's been covered so far.
Recall that the V/Oct standard means that doubling any voltage will transpose a note up one octave.
Therefore, adding any voltage to an existing V/Oct signal will raise the pitch, and subtracting any voltage from an existing V/Oct signal will lower the pitch.
We can accomplish adding and subtracting from a signal by using a mixer, since a mixer simply adds two signals together and voltage signals can be negative.

A very simple idea is to use a longer sequence on the transposing sequencer where each voltage either does nothing (0 V) or is the negative of one of the voltages in the arpeggio sequence.
Negating the voltage means that the resulting note will be C^[0 V is C4 in VCVRack, apparently, though there is no such standard in modular in general. V/Oct is a *relative* standard, not a standard that specifies what frequencies are associated with specific voltages.]
To keep things interesting, it's nice to have one or two notes that don't follow this pattern.
In the patch below, I used G#, D#, C#, C, G#, D#, E, and C as the transposing sequence, changing the step at each bar.
A slowed down video of the two sequencer outputs and their mixed output is shown in Figure \@ref(fig:two-sequencers-mixed).
Try patching up the transposing sequencer and mixer using the button in Figure \@ref(fig:chiptune-single-arp-pwm-transpose).

(ref:two-sequencers-mixed) [YouTube video](https://youtu.be/BlHnw4rgUEc) of a slow-motion arpeggio (left) voltage mixed with the output of another sequencer (middle) to produce a transposed arpgeggio that changes with each bar (right).

<div class="figure">
<img src="downloadFigs4latex/two-sequencers-mixed.jpg" alt="(ref:two-sequencers-mixed)"  />
<p class="caption">(\#fig:two-sequencers-mixed)(ref:two-sequencers-mixed)</p>
</div>

(ref:chiptune-single-arp-pwm-transpose) [Virtual modular](https://cardinal.olney.ai) for setting up an enveloped chiptune arpeggio with pulse-width modulated by an LFO, transposed by a second sequencer every bar.

<!-- MODAL HTML BLOCK -->


<!-- CAPTION BLOCK -->
<div class="figure">
<img src="images/launch-virtual-modular-button.png" alt="(ref:chiptune-single-arp-pwm-transpose)" width="100%" />
<p class="caption">(\#fig:chiptune-single-arp-pwm-transpose)(ref:chiptune-single-arp-pwm-transpose)</p>
</div>

### Hats and kick

We made hats in Section \@ref(noise) and simple kicks in Section \@ref(clocks-as-sequencers), so these are both problems we know how to solve.
A simple hat is just high frequency noise through an envelope/VCA, and a simple kick is just a sine through an envelope/VCA.
Both voices are ideally controlled with trigger sequencers, and by using two different sequencers we can use different patterns for each.
Try patching up hats and kick with their own sequencers using the button in Figure \@ref(fig:chiptune-single-arp-pwm-transpose-hats-kick).


(ref:chiptune-single-arp-pwm-transpose-hats-kick) [Virtual modular](https://cardinal.olney.ai) for setting up an enveloped chiptune arpeggio with pulse-width modulated by an LFO, transposed by a second sequencer every bar, with hats and kick as additional voices.

<!-- MODAL HTML BLOCK -->


<!-- CAPTION BLOCK -->
<div class="figure">
<img src="images/launch-virtual-modular-button.png" alt="(ref:chiptune-single-arp-pwm-transpose-hats-kick)" width="100%" />
<p class="caption">(\#fig:chiptune-single-arp-pwm-transpose-hats-kick)(ref:chiptune-single-arp-pwm-transpose-hats-kick)</p>
</div>



<!-- Remaining plan -->

<!-- Sound design ideas -->

<!-- Cymbal PUSH UNTIL AFTER RING MOD -->
<!-- Video game lead -->
<!-- 80’s music bass -->

<!-- Maybe use these? -->
<!-- keyboard filter tracking or notes would disappear; filtering sine wave example -->
<!-- pinging: sending a gate/trigger to a near-oscillating filter; use AR on filter's freq -->
<!-- Growl: Low frequency sine wave modulation of the filter cut-off frequency -->
<!-- wah wah is LFO on LPF cutoff freq -->



<!-- Complex modules and Compositions		 -->
<!-- 	Controllers	 -->
<!-- 		Clock, sequencing, arpggiators -->
<!-- 		Euclidean rhythms -->
<!-- 		Probability -->
<!-- 	Generators	 -->
<!-- 		PWM -->
<!-- 		FM/AM -->
<!-- 		Ring modulation -->
<!-- audio rate modulation into resonant filter? -->
<!-- 		Vocoders -->
<!-- 		Random sampling -->
<!-- 	Modifiers	 -->
<!-- 		~~LFO~~ -->
<!-- 		Sample and hold -->
<!-- 		Slew -->
<!-- 		Wave-folding -->
<!-- 		Attenuators, inverters, and attenuverters -->
<!-- 		Quantizers -->
<!-- 		Switches -->
<!-- 		Logic -->


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



