# '80s Lead & ???Bass
<!-- sic 'Stranger Lead'? -->

This chapter explores additional sound design problems using the problem solving approach elaborated in Chapter \@ref(designing-a-kick-drum).
The first problem is to recreate an 80's-style lead from the show [*Stranger Things*](https://en.wikipedia.org/wiki/Stranger_Things).
The major strategy used to this problem is working backwards, since the goal is to emulate something that already exists.

SAY SOMETHING ABOUT THE SECOND PROBLEM HERE.

## '80s Lead

The music of the show *Stranger Things* [uses vintage synthesizers](https://www.synthhistory.com/post/interview-with-kyle-dixon-michael-stein) in order to match the 1980's setting of the show.
The theme song uses an [arpeggio](https://en.wikipedia.org/wiki/Arpeggio) as a lead.
An arpeggio is a type of broken chord, or chord that is played one note at a time.
Arpeggios are a common element in electronic music likely because many synthesizers (and VCOs) have historically been monophonic and so can only play one note at a time.
<!-- The *Stranger Things* theme arpeggio plays up and down over a broken C major 7th chord: low C, E, G, B, C, B, G, E and then repeats throughout the theme. -->
Recreating the *Stranger Things* arpeggio in modular is an interesting sound design problem because it requires working backward from the recording and doing a little detective work to infer how the sound was originally created.

### Waveshape

The first step is to determine the waveshape used in the arpeggio.
Because the theme is composed using vintage synthesizers, we can expect it to use basic waveshapes like sine, triangle, saw, or square rather than a complex wavetable.
Listen to the theme in Figure \@ref(fig:stranger-things-theme) to see if you can identify what kind of waveshape is used, paying particular attention to the brightness of the sound, which indicates higher harmonics.

(ref:stranger-things-theme) [YouTube video](https://youtu.be/-RcPZdihrp4) of the *Stranger Things* theme song. Image [© Netflix](https://www.youtube.com/c/strangerthings).

<div class="figure">
<iframe src="https://www.youtube.com/embed/-RcPZdihrp4?start=0" width="672" height="400px" data-external="1"></iframe>
<p class="caption">(\#fig:stranger-things-theme)(ref:stranger-things-theme)</p>
</div>

To me, it starts off a bit dull, like a sine or triangel, then gets brighter around 15 seconds, duller again around 30 seconds, and has a quick run up to brightness around 50 seconds.
The brightness suggests that the waveshape is either saw or square.
We'll return to the change in brightness in a moment.

Saws and square waves can be distinguished by their frequency spectrum as discussed in Section \@ref(resonators-formants-and-frequency-spectrum).
Specifically, saws have both even and odd harmonics, whereas squares have only odd harmonics.
Thus a frequency spectrum could help identify which waveshape is being used.
It is much more convenient to use Audacity for this than R because Audacity allows selections of tracks to be auditioned and then frequency spectrum to be computed for those selections.
This makes it relatively easy to isolate a portion of the song with just a single note of the arpeggio while it is bright.^[To calculate frequency spectrum in Audacity, drag select the region of the audio, audition it using the play button, and then use Analyze -> Plot Spectrum. A high window size is needed for a detailed spectrum, e.g. 4096.]
Figure \@ref(fig:stranger-things-theme-frequency-audacity-7-top-4096) shows the frequency spectrum of a single note of the arpeggio around 50 seconds. 

(ref:stranger-things-theme-frequency-audacity-7-top-4096) Frequency spectrum of a single note from the *Stranger Things* theme arpeggio.

<div class="figure">
<img src="images/stranger-things-theme-frequency-audacity-7-top-4096.png" alt="(ref:stranger-things-theme-frequency-audacity-7-top-4096)" width="100%" />
<p class="caption">(\#fig:stranger-things-theme-frequency-audacity-7-top-4096)(ref:stranger-things-theme-frequency-audacity-7-top-4096)</p>
</div>


Characteristics of the frequency peaks are shown in Table \@ref(tab:stranger-things-ref-peaks), including the harmonic ratio of each peak with the fundamental.
Assume for a moment that these are harmonics even though the harmonic ratios are not strictly integers.
Since both even and odd harmonics are present, this spectrum is consistent with a saw wave.
However, this pattern could also be observed if there were two square waves, one with a fundamental at 40 Hz and one with a fundamental at 82 Hz.^[Because 80 Hz is the second harmonic of 40 Hz, the harmonics of the 80 Hz square wave would look like the even harmonics of 40 Hz.]

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

(ref:st-square40-square82) [Virtual modular](https://cardinal.olney.ai) for asessing whether two square waves or a saw and a square wave are a closer match for the target spectrum.

<!-- MODAL HTML BLOCK -->

```{=html}
<!-- Button trigger modal -->
<!-- <div class="d-flex flex-column min-vh-100 justify-content-center align-items-center"> -->
<div class="d-flex flex-column justify-content-center align-items-center">
  <button type="button" style="margin-top: 20px;margin-bottom: 5px" onclick="setst_square40_square82Iframe('https://cardinal.olney.ai?patchurl=empty.vcv')" class="btn btn-primary" data-toggle="modal" data-target="#st_square40_square82">
    Launch Virtual Modular
  </button>
</div>


<!-- Modal -->
<div class="modal fade" id="st_square40_square82" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="st_square40_square82Label" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header justify-content-between">
        <!-- <h5 class="modal-title" id="st_square40_square82Label">Modal title</h5> -->
        <!-- To dismiss popovers when other elements are clicked, add this back in and uncomment jquery at end of template
        <button type="button" class="btn btn-secondary" title="Instructions" data-toggle="popover" data-trigger="focus" data-html="true" data-content="&lt;ul&gt;
&lt;li&gt;Add two VCOs, QuadVCA/Mixer, Scope, Host audio, and Sassy Scope&lt;/li&gt;
&lt;li&gt;Tune VCO 1 to 40 Hz and VCO 2 to 82 Hz&lt;/li&gt;
&lt;li&gt;Connect VCO 1 square out to QuadVCA/Mixer input 1 and VCO 2 square out to QuadVCA/Mixer input 2&lt;/li&gt;
&lt;li&gt;Connect QuadVCA/Mixer mix out to Scope in 1, connect Scope out 1 to Host audio L and Sassy input 1&lt;/li&gt;
&lt;li&gt;Adjust the Scope time to see a single wave or two; use TRG button to sync the scope&lt;/li&gt;
&lt;li&gt;Adjust Sassy to Freq, channel 1 level down to 1/32, resolution to 1000ms, and FFT to 8x. Note it is challenging to get the relative amplitudes of the spectrum using this or other settings with Sassy.&lt;/li&gt;
&lt;li&gt;Try the following and note the differences in the sound, scope waveshape, and spectrum&lt;ul&gt;
&lt;li&gt;Adjust the mix levels for the two oscillators to best match the target spectrum&lt;/li&gt;
&lt;li&gt;Adjust the tuning of VCO 1 to 41 Hz and note the waveshape stabilizes on the scope. This shows the effect of the original detuning. Now change it back.&lt;/li&gt;
&lt;li&gt;Capture audio in Audacity and compute the spectrum. The mix ratios to match the target spectrum are approximately 60% and 100%&lt;/li&gt;
&lt;/ul&gt;&lt;/li&gt;
&lt;li&gt;After changing VCO 1 to saw, try the following and note the differences in the sound, scope waveshape, and spectrum&lt;ul&gt;
&lt;li&gt;Adjust the mix levels for the two oscillators to best match the target spectrum&lt;/li&gt;
&lt;li&gt;Adjust the tuning of VCO 1 to 41 Hz and note the waveshape stabilizes on the scope. This shows the effect of the original detuning. Now change it back.&lt;/li&gt;
&lt;li&gt;Capture audio in Audacity and compute the spectrum. The mix ratios to match the target spectrum are approximately 100% and 100%&lt;/li&gt;
&lt;/ul&gt;&lt;/li&gt;
&lt;/ul&gt;
">Instructions</button>
        <button type="button" class="btn btn-secondary" title="Solution" data-toggle="popover" data-trigger="focus" data-html="true" data-content="&lt;h4&gt;Solution for two square waves only&lt;/h4&gt;&lt;img class='rack-image-6u' src='images/patch-solutions/st-square40-square82.png'&gt;">Solution</button> -->
        <!-- using a different data-toggle than 'popover' because bookdown seems to have customized popover for footnotes, etc, with a different close click behaviour -->
        <button type="button" class="btn btn-secondary" title="Instructions" data-toggle="modal-popover" data-placement="bottom" data-custom-class="modal-popover"
        data-html="true" data-content="&lt;ul&gt;
&lt;li&gt;Add two VCOs, QuadVCA/Mixer, Scope, Host audio, and Sassy Scope&lt;/li&gt;
&lt;li&gt;Tune VCO 1 to 40 Hz and VCO 2 to 82 Hz&lt;/li&gt;
&lt;li&gt;Connect VCO 1 square out to QuadVCA/Mixer input 1 and VCO 2 square out to QuadVCA/Mixer input 2&lt;/li&gt;
&lt;li&gt;Connect QuadVCA/Mixer mix out to Scope in 1, connect Scope out 1 to Host audio L and Sassy input 1&lt;/li&gt;
&lt;li&gt;Adjust the Scope time to see a single wave or two; use TRG button to sync the scope&lt;/li&gt;
&lt;li&gt;Adjust Sassy to Freq, channel 1 level down to 1/32, resolution to 1000ms, and FFT to 8x. Note it is challenging to get the relative amplitudes of the spectrum using this or other settings with Sassy.&lt;/li&gt;
&lt;li&gt;Try the following and note the differences in the sound, scope waveshape, and spectrum&lt;ul&gt;
&lt;li&gt;Adjust the mix levels for the two oscillators to best match the target spectrum&lt;/li&gt;
&lt;li&gt;Adjust the tuning of VCO 1 to 41 Hz and note the waveshape stabilizes on the scope. This shows the effect of the original detuning. Now change it back.&lt;/li&gt;
&lt;li&gt;Capture audio in Audacity and compute the spectrum. The mix ratios to match the target spectrum are approximately 60% and 100%&lt;/li&gt;
&lt;/ul&gt;&lt;/li&gt;
&lt;li&gt;After changing VCO 1 to saw, try the following and note the differences in the sound, scope waveshape, and spectrum&lt;ul&gt;
&lt;li&gt;Adjust the mix levels for the two oscillators to best match the target spectrum&lt;/li&gt;
&lt;li&gt;Adjust the tuning of VCO 1 to 41 Hz and note the waveshape stabilizes on the scope. This shows the effect of the original detuning. Now change it back.&lt;/li&gt;
&lt;li&gt;Capture audio in Audacity and compute the spectrum. The mix ratios to match the target spectrum are approximately 100% and 100%&lt;/li&gt;
&lt;/ul&gt;&lt;/li&gt;
&lt;/ul&gt;
">Instructions</button>
        <button type="button" class="btn btn-secondary" title="Solution" data-toggle="modal-popover" data-placement="bottom" data-custom-class="modal-popover"
        data-html="true" data-content="&lt;h4&gt;Solution for two square waves only&lt;/h4&gt;&lt;img class='rack-image-6u' src='images/patch-solutions/st-square40-square82.png'&gt;">Solution</button>
        <button type="button" onclick="setst_square40_square82Iframe('')" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <!-- For some reason the button type below will not play along with justify-content-between  -->
        <!-- <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button> -->
      </div>
      <div class="modal-body">
        <iframe id="st_square40_square82-iframe" src="" height="100%" width="100%"></iframe>
      </div>      
      <!-- <div class="modal-footer justify-content-between">
        <button type="button" class="btn btn-secondary mr-auto" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Understood</button>
      </div> -->
    </div>
  </div>
</div>

  

<script>
// Enable popovers for instructions, etc 
// var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-toggle="popover"]'))
// var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
//   return new bootstrap.Popover(popoverTriggerEl)
// });
$(function () {
  $('[data-toggle="modal-popover"]').popover()
})

// Set/reset iframe to prevent it loading when page loads and persisting when modal closed 
function setst_square40_square82Iframe(url){
  var st_square40_square82Iframe = document.getElementById("st_square40_square82-iframe");
  st_square40_square82Iframe.src = url;
};

// This dismisses popovers when anything else is clicked, but users probably want to refer to instructions/solution while clicking on things, so commenting it out for now
// $('.popover-dismiss').popover({
//   trigger: 'focus'
// })
</script>

```

<!-- CAPTION BLOCK -->
<div class="figure" style="margin-top: 0px;padding-top: 0px;"><p class="caption">(\#fig:st-square40-square82)(ref:st-square40-square82)</p></div>

Figure \@ref(fig:stranger-things_two-squares-and-saw-square-mixed-to-match-sample7) shows the frequency spectrum of the two square waves and the saw plus square wave model. 
In both cases, the first three harmonics approximately match the target spectrum in Figure \@ref(fig:stranger-things-theme-frequency-audacity-7-top-4096), but they diverge on the 4th harmonic.
Our inability to get the 4th harmonic with either of these models suggests another element is needed.
One possibility is a third wave, but we may also be able to further adjust the spectrum in our existing models by applying PWM to the square waves. 


Try adjusting the PWM on both of these until the spectrum looks similar to our sample.


(ref:stranger-things_two-squares-and-saw-square-mixed-to-match-sample7) Frequency spectrum of a single note from the *Stranger Things* theme arpeggio.

<div class="figure">
<img src="images/stranger-things_two-squares-and-saw-square-mixed-to-match-sample7.png" alt="(ref:stranger-things_two-squares-and-saw-square-mixed-to-match-sample7)" width="100%" />
<p class="caption">(\#fig:stranger-things_two-squares-and-saw-square-mixed-to-match-sample7)(ref:stranger-things_two-squares-and-saw-square-mixed-to-match-sample7)</p>
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




