# Modifiers

Modifiers modify incoming signals that may be either audio or some kind of control signal.
Generators create audible sound.
Chapter \@ref(basic-modeling-concepts) introduced voltage controlled amplifiers (VCAs) that modify the amplitude of incoming signals, which can be either audio or control voltage.
That chapter also introduced envelopes that modify control voltage, and we have routinely used envelopes to control VCAs in order to model the dynamics of various instruments.

This chapter expands upon audio modifiers specifically and focuses on two foundational categories of modifiers, effects and voltage controlled filters.
Effects can substantially enrich the sounds you create both in terms of thickness of sound and sense of acoustic space, and voltage controlled filters create some of the most defining sounds in electronic music.

## TODO insert effects here.

## Voltage controlled filters

Voltage controlled filters (VCFs) are an essential component of subtractive synthesis.
Subtractive synthesis, as you recall, is characterized by taking harmonically complex waveshapes and then removing harmonic content to create the desired sounds. 
The opposite approach, additive synthesis, takes harmonically simple waveshapes and adds them together to create desired sounds; however, this becomes complex in analogue circuitry and is better suited to digital computers, which is why subtractive synthesis has historically been the dominant approach to synthesis.
Filters, if you haven't already guessed, are a primary method for removing harmonic content, which is why VCFs are an essential component of subtractive synthesis.

As discussed in Chapter \@ref(harmonic-and-inharmonic-sounds), timbre is intimately connected to waveshape, and removing harmonic content affects both the shape of the wave and its timbre.
You may assume from our discussion of Fourier analysis that a filter will remove selected harmonics completely.
If that were the case, we might expect a square wave with all but the first two harmonics filtered to look like Figure \@ref(fig:square-fourier-2-harmonics-2).^[This figure was created using the simulator in Section \@ref(resonators-formants-and-frequency-spectrum) which you can use to further explore these concepts.]

(ref:square-fourier-2-harmonics-2) Fourier approximation of the first 11 harmonics of a square wave.

<div class="figure">
<img src="images/square-fourier-2-harmonics-2.png" alt="(ref:square-fourier-2-harmonics-2)" width="100%" />
<p class="caption">(\#fig:square-fourier-2-harmonics-2)(ref:square-fourier-2-harmonics-2)</p>
</div>

Using Fourier decomposition to understand VCFs is misleading in many respects, as will become clear by the end of this section.
It is also not practical to build a filter based on Fourier decomposition for two at least two reasons.
First, we want our filter to happen in real time, i.e. before a wave has even completed its cycle, which Fourier can't do.
Second, Fourier introduces [Gibbs error](https://en.wikipedia.org/wiki/Gibbs_phenomenon) that you can see in Figure \@ref(fig:square-fourier-2-harmonics-2) as peaks where there should be 90 degree angles in the square wave.
If we were to use Fourier as the basis of a filter, those peaks would introduce ringing artifacts.

(ref:vcf-square-out) VCF output on a square wave. The figure has been aligned and scaled for comparison to Figure \@ref(fig:square-fourier-2-harmonics-2). Note the relatively flat low and high regions of the wave, which imply the presence of higher harmonics.

<div class="figure">
<img src="images/vcf-square-out.png" alt="(ref:vcf-square-out)" width="100%" />
<p class="caption">(\#fig:vcf-square-out)(ref:vcf-square-out)</p>
</div>

The output of a real VCF filtering out all but the first 11 harmonics is shown in Figure \@ref(fig:vcf-square-out).
The VCF output has two striking differences with the Fourier example.
First, the transition from maximum positive to maximum negative (and vice versa) is substantially smoother for the VCF, creating rounder edges.
Second, the VCF has relatively flat maximum regions of the wave, which imply higher harmonics.
By comparing the Fourier and VCF outputs, we can see that the VCF is removing more low frequency content than we would expect (rounder edges) but that the VCF is removing less high frequency content than we would expect (flatter maximum regions of the wave).
So a VCF is not like a net that either lets harmonics through or not.
Instead, a VCF affects a range of harmonics, but within that range, it affects some harmonics more than others.

Let's take a look at this in some patches that filter white noise.
The advantage of filtering white noise is that white noise contains all frequencies, so it is easy to see the shape of the filter's effect.
The patches will use two common filters: low-pass filters and high-pass filters.
Low-pass filters (LPF) let low frequencies pass through relatively unaffected, and high-pass filters (HPF) let high frequencies pass through relatively unaffected.
The effect of each filter is controlled using the cutoff frequency.
Try patching up the two filters using the button in Figure \@ref(fig:noiz-lfp-out-fft).

(ref:noiz-lfp-out-fft) [Virtual modular](https://cardinal.olney.ai) for applying low- and high-pass filtering on white noise.

<!-- MODAL HTML BLOCK -->


<!-- CAPTION BLOCK -->
<div class="figure">
<img src="images/launch-virtual-modular-button.png" alt="(ref:noiz-lfp-out-fft)" width="100%" />
<p class="caption">(\#fig:noiz-lfp-out-fft)(ref:noiz-lfp-out-fft)</p>
</div>



<!-- Remaining plan -->

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



