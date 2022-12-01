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
<iframe src="https://www.youtube.com/embed/-RcPZdihrp4?start=0" width="672" height="400px" data-external="1"></iframe>
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
        <button type="button" class="btn btn-secondary" title="Solution" data-toggle="popover" data-trigger="focus" data-html="true" data-content="&lt;h4&gt;Solution for two square waves only&lt;/h4&gt;&lt;img class='rack-image' src='images/patch-solutions/st-square40-square82.png'&gt;">Solution</button> -->
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
        data-html="true" data-content="&lt;h4&gt;Solution for two square waves only&lt;/h4&gt;&lt;img class='rack-image' src='images/patch-solutions/st-square40-square82.png'&gt;">Solution</button>
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

```{=html}
<!-- Button trigger modal -->
<!-- <div class="d-flex flex-column min-vh-100 justify-content-center align-items-center"> -->
<div class="d-flex flex-column justify-content-center align-items-center">
  <button type="button" style="margin-top: 20px;margin-bottom: 5px" onclick="setst_square40_square82at36pwmIframe('https://cardinal.olney.ai?patchurl=st-square40-square82.vcv')" class="btn btn-primary" data-toggle="modal" data-target="#st_square40_square82at36pwm">
    Launch Virtual Modular
  </button>
</div>


<!-- Modal -->
<div class="modal fade" id="st_square40_square82at36pwm" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="st_square40_square82at36pwmLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header justify-content-between">
        <!-- <h5 class="modal-title" id="st_square40_square82at36pwmLabel">Modal title</h5> -->
        <!-- To dismiss popovers when other elements are clicked, add this back in and uncomment jquery at end of template
        <button type="button" class="btn btn-secondary" title="Instructions" data-toggle="popover" data-trigger="focus" data-html="true" data-content="&lt;ul&gt;
&lt;li&gt;Try the following and note the differences in the sound, scope waveshape, and spectrum&lt;ul&gt;
&lt;li&gt;Alternate between adjusting the PWM and adjusting the mix levels for the two oscillators to best match the target spectrum&lt;/li&gt;
&lt;li&gt;Capture audio in Audacity and compute the spectrum. The mix ratios to match the target spectrum are approximately 60% and 100%, and the PWM is 36%&lt;/li&gt;
&lt;/ul&gt;&lt;/li&gt;
&lt;li&gt;After changing VCO 1 to saw, try the following and note the differences in the sound, scope waveshape, and spectrum&lt;ul&gt;
&lt;li&gt;Alternate between adjusting the PWM and adjusting the mix levels for the two oscillators to best match the target spectrum&lt;/li&gt;
&lt;li&gt;Capture audio in Audacity and compute the spectrum. The mix ratios to match the target spectrum are approximately 100% and 100%, and the PWM is 36%&lt;/li&gt;
&lt;/ul&gt;&lt;/li&gt;
&lt;/ul&gt;
">Instructions</button>
        <button type="button" class="btn btn-secondary" title="Solution" data-toggle="popover" data-trigger="focus" data-html="true" data-content="&lt;h4&gt;Solution for two square waves only&lt;/h4&gt;&lt;img class='rack-image' src='images/patch-solutions/st-square40-square82at36pwm.png'&gt;">Solution</button> -->
        <!-- using a different data-toggle than 'popover' because bookdown seems to have customized popover for footnotes, etc, with a different close click behaviour -->
        <button type="button" class="btn btn-secondary" title="Instructions" data-toggle="modal-popover" data-placement="bottom" data-custom-class="modal-popover"
        data-html="true" data-content="&lt;ul&gt;
&lt;li&gt;Try the following and note the differences in the sound, scope waveshape, and spectrum&lt;ul&gt;
&lt;li&gt;Alternate between adjusting the PWM and adjusting the mix levels for the two oscillators to best match the target spectrum&lt;/li&gt;
&lt;li&gt;Capture audio in Audacity and compute the spectrum. The mix ratios to match the target spectrum are approximately 60% and 100%, and the PWM is 36%&lt;/li&gt;
&lt;/ul&gt;&lt;/li&gt;
&lt;li&gt;After changing VCO 1 to saw, try the following and note the differences in the sound, scope waveshape, and spectrum&lt;ul&gt;
&lt;li&gt;Alternate between adjusting the PWM and adjusting the mix levels for the two oscillators to best match the target spectrum&lt;/li&gt;
&lt;li&gt;Capture audio in Audacity and compute the spectrum. The mix ratios to match the target spectrum are approximately 100% and 100%, and the PWM is 36%&lt;/li&gt;
&lt;/ul&gt;&lt;/li&gt;
&lt;/ul&gt;
">Instructions</button>
        <button type="button" class="btn btn-secondary" title="Solution" data-toggle="modal-popover" data-placement="bottom" data-custom-class="modal-popover"
        data-html="true" data-content="&lt;h4&gt;Solution for two square waves only&lt;/h4&gt;&lt;img class='rack-image' src='images/patch-solutions/st-square40-square82at36pwm.png'&gt;">Solution</button>
        <button type="button" onclick="setst_square40_square82at36pwmIframe('')" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <!-- For some reason the button type below will not play along with justify-content-between  -->
        <!-- <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button> -->
      </div>
      <div class="modal-body">
        <iframe id="st_square40_square82at36pwm-iframe" src="" height="100%" width="100%"></iframe>
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
function setst_square40_square82at36pwmIframe(url){
  var st_square40_square82at36pwmIframe = document.getElementById("st_square40_square82at36pwm-iframe");
  st_square40_square82at36pwmIframe.src = url;
};

// This dismisses popovers when anything else is clicked, but users probably want to refer to instructions/solution while clicking on things, so commenting it out for now
// $('.popover-dismiss').popover({
//   trigger: 'focus'
// })
</script>

```

<!-- CAPTION BLOCK -->
<div class="figure" style="margin-top: 0px;padding-top: 0px;"><p class="caption">(\#fig:st-square40-square82at36pwm)(ref:st-square40-square82at36pwm)</p></div>

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

```{=html}
<!-- Button trigger modal -->
<!-- <div class="d-flex flex-column min-vh-100 justify-content-center align-items-center"> -->
<div class="d-flex flex-column justify-content-center align-items-center">
  <button type="button" style="margin-top: 20px;margin-bottom: 5px" onclick="setst_square40_square82at36pwm_square164Iframe('https://cardinal.olney.ai?patchurl=st-square40-square82at36pwm.vcv')" class="btn btn-primary" data-toggle="modal" data-target="#st_square40_square82at36pwm_square164">
    Launch Virtual Modular
  </button>
</div>


<!-- Modal -->
<div class="modal fade" id="st_square40_square82at36pwm_square164" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="st_square40_square82at36pwm_square164Label" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header justify-content-between">
        <!-- <h5 class="modal-title" id="st_square40_square82at36pwm_square164Label">Modal title</h5> -->
        <!-- To dismiss popovers when other elements are clicked, add this back in and uncomment jquery at end of template
        <button type="button" class="btn btn-secondary" title="Instructions" data-toggle="popover" data-trigger="focus" data-html="true" data-content="&lt;ul&gt;
&lt;li&gt;Add another VCO to the right of the last VCO, set its frequncy to 164, and connect its square out to QuadVCA/Mixer input 3&lt;/li&gt;
&lt;li&gt;Try the following and note the differences in the sound, scope waveshape, and spectrum&lt;ul&gt;
&lt;li&gt;Adjust the mix levels for the two oscillators to best match the target spectrum&lt;/li&gt;
&lt;li&gt;Capture audio in Audacity and compute the spectrum. The mix ratios to match the target spectrum are approximately 34%, 100%, and 56%&lt;/li&gt;
&lt;/ul&gt;&lt;/li&gt;
&lt;li&gt;After changing VCO 1 to saw, try the following and note the differences in the sound, scope waveshape, and spectrum&lt;ul&gt;
&lt;li&gt;Adjust the mix levels for the two oscillators to best match the target spectrum&lt;/li&gt;
&lt;li&gt;Capture audio in Audacity and compute the spectrum. The mix ratios to match the target spectrum are approximately the same&lt;/li&gt;
&lt;/ul&gt;&lt;/li&gt;
&lt;/ul&gt;
">Instructions</button>
        <button type="button" class="btn btn-secondary" title="Solution" data-toggle="popover" data-trigger="focus" data-html="true" data-content="&lt;h4&gt;Solution for square waves only&lt;/h4&gt;&lt;img class='rack-image' src='images/patch-solutions/st-square40-square82at36pwm-square164.png'&gt;">Solution</button> -->
        <!-- using a different data-toggle than 'popover' because bookdown seems to have customized popover for footnotes, etc, with a different close click behaviour -->
        <button type="button" class="btn btn-secondary" title="Instructions" data-toggle="modal-popover" data-placement="bottom" data-custom-class="modal-popover"
        data-html="true" data-content="&lt;ul&gt;
&lt;li&gt;Add another VCO to the right of the last VCO, set its frequncy to 164, and connect its square out to QuadVCA/Mixer input 3&lt;/li&gt;
&lt;li&gt;Try the following and note the differences in the sound, scope waveshape, and spectrum&lt;ul&gt;
&lt;li&gt;Adjust the mix levels for the two oscillators to best match the target spectrum&lt;/li&gt;
&lt;li&gt;Capture audio in Audacity and compute the spectrum. The mix ratios to match the target spectrum are approximately 34%, 100%, and 56%&lt;/li&gt;
&lt;/ul&gt;&lt;/li&gt;
&lt;li&gt;After changing VCO 1 to saw, try the following and note the differences in the sound, scope waveshape, and spectrum&lt;ul&gt;
&lt;li&gt;Adjust the mix levels for the two oscillators to best match the target spectrum&lt;/li&gt;
&lt;li&gt;Capture audio in Audacity and compute the spectrum. The mix ratios to match the target spectrum are approximately the same&lt;/li&gt;
&lt;/ul&gt;&lt;/li&gt;
&lt;/ul&gt;
">Instructions</button>
        <button type="button" class="btn btn-secondary" title="Solution" data-toggle="modal-popover" data-placement="bottom" data-custom-class="modal-popover"
        data-html="true" data-content="&lt;h4&gt;Solution for square waves only&lt;/h4&gt;&lt;img class='rack-image' src='images/patch-solutions/st-square40-square82at36pwm-square164.png'&gt;">Solution</button>
        <button type="button" onclick="setst_square40_square82at36pwm_square164Iframe('')" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <!-- For some reason the button type below will not play along with justify-content-between  -->
        <!-- <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button> -->
      </div>
      <div class="modal-body">
        <iframe id="st_square40_square82at36pwm_square164-iframe" src="" height="100%" width="100%"></iframe>
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
function setst_square40_square82at36pwm_square164Iframe(url){
  var st_square40_square82at36pwm_square164Iframe = document.getElementById("st_square40_square82at36pwm_square164-iframe");
  st_square40_square82at36pwm_square164Iframe.src = url;
};

// This dismisses popovers when anything else is clicked, but users probably want to refer to instructions/solution while clicking on things, so commenting it out for now
// $('.popover-dismiss').popover({
//   trigger: 'focus'
// })
</script>

```

<!-- CAPTION BLOCK -->
<div class="figure" style="margin-top: 0px;padding-top: 0px;"><p class="caption">(\#fig:st-square40-square82at36pwm-square164)(ref:st-square40-square82at36pwm-square164)</p></div>


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

```{=html}
<!-- Button trigger modal -->
<!-- <div class="d-flex flex-column min-vh-100 justify-content-center align-items-center"> -->
<div class="d-flex flex-column justify-content-center align-items-center">
  <button type="button" style="margin-top: 20px;margin-bottom: 5px" onclick="setst_seq_arp_no_modulated_dynamicsIframe('https://cardinal.olney.ai?patchurl=st-square40-square82at36pwm-square164.vcv')" class="btn btn-primary" data-toggle="modal" data-target="#st_seq_arp_no_modulated_dynamics">
    Launch Virtual Modular
  </button>
</div>


<!-- Modal -->
<div class="modal fade" id="st_seq_arp_no_modulated_dynamics" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="st_seq_arp_no_modulated_dynamicsLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header justify-content-between">
        <!-- <h5 class="modal-title" id="st_seq_arp_no_modulated_dynamicsLabel">Modal title</h5> -->
        <!-- To dismiss popovers when other elements are clicked, add this back in and uncomment jquery at end of template
        <button type="button" class="btn btn-secondary" title="Instructions" data-toggle="popover" data-trigger="focus" data-html="true" data-content="&lt;ul&gt;
&lt;li&gt;Add BPM Clock and ADDR-SEQ to the top left row, connect ADDR-SEQ out to V/Oct of all three oscillators&lt;/li&gt;
&lt;li&gt;Connect Clock 16ths out to ADDR-SEQ clock in and connect Clock Beat to Scope ext trig&lt;/li&gt;
&lt;li&gt;Add Reftone and Volt meter; connect Reftone V/Oct to Volt Meter input 1&lt;/li&gt;
&lt;li&gt;The ADDR-SEQ knobs control the notes for each step, and you can select the current note using the select knob. Turn this knob to select each step and tune the following way&lt;ul&gt;
&lt;li&gt;Use the Reftone pitch and octave knobs to get the voltage for the notes you need: low C, E, G, B, C, B, G, and E &lt;/li&gt;
&lt;li&gt;Select the appropriate ADDR-SEQ step using the select knob&lt;/li&gt;
&lt;li&gt;Move the knob until the voltage matches your target; you can also right click and type the voltage in&lt;/li&gt;
&lt;/ul&gt;&lt;/li&gt;
&lt;li&gt;Add ADSR between last VCO and Mixer, connect Clock 16th out to ADSR gate and then connect ADSR out to first three mixer gain inputs&lt;/li&gt;
&lt;li&gt;Run the clock and adjust the BPM to match the target song&lt;/li&gt;
&lt;/ul&gt;
&lt;div class='d-flex flex-row justify-content-around'&gt;
&lt;img class='rack-image' src='images/solo-modules/reftone-voltmeter-solo.png'&gt;
&lt;/div&gt;
">Instructions</button>
        <button type="button" class="btn btn-secondary" title="Solution" data-toggle="popover" data-trigger="focus" data-html="true" data-content="&lt;img class='rack-image-6u' src='images/patch-solutions/st-seq-arp-no-modulated-dynamics.png'&gt;">Solution</button> -->
        <!-- using a different data-toggle than 'popover' because bookdown seems to have customized popover for footnotes, etc, with a different close click behaviour -->
        <button type="button" class="btn btn-secondary" title="Instructions" data-toggle="modal-popover" data-placement="bottom" data-custom-class="modal-popover"
        data-html="true" data-content="&lt;ul&gt;
&lt;li&gt;Add BPM Clock and ADDR-SEQ to the top left row, connect ADDR-SEQ out to V/Oct of all three oscillators&lt;/li&gt;
&lt;li&gt;Connect Clock 16ths out to ADDR-SEQ clock in and connect Clock Beat to Scope ext trig&lt;/li&gt;
&lt;li&gt;Add Reftone and Volt meter; connect Reftone V/Oct to Volt Meter input 1&lt;/li&gt;
&lt;li&gt;The ADDR-SEQ knobs control the notes for each step, and you can select the current note using the select knob. Turn this knob to select each step and tune the following way&lt;ul&gt;
&lt;li&gt;Use the Reftone pitch and octave knobs to get the voltage for the notes you need: low C, E, G, B, C, B, G, and E &lt;/li&gt;
&lt;li&gt;Select the appropriate ADDR-SEQ step using the select knob&lt;/li&gt;
&lt;li&gt;Move the knob until the voltage matches your target; you can also right click and type the voltage in&lt;/li&gt;
&lt;/ul&gt;&lt;/li&gt;
&lt;li&gt;Add ADSR between last VCO and Mixer, connect Clock 16th out to ADSR gate and then connect ADSR out to first three mixer gain inputs&lt;/li&gt;
&lt;li&gt;Run the clock and adjust the BPM to match the target song&lt;/li&gt;
&lt;/ul&gt;
&lt;div class='d-flex flex-row justify-content-around'&gt;
&lt;img class='rack-image' src='images/solo-modules/reftone-voltmeter-solo.png'&gt;
&lt;/div&gt;
">Instructions</button>
        <button type="button" class="btn btn-secondary" title="Solution" data-toggle="modal-popover" data-placement="bottom" data-custom-class="modal-popover"
        data-html="true" data-content="&lt;img class='rack-image-6u' src='images/patch-solutions/st-seq-arp-no-modulated-dynamics.png'&gt;">Solution</button>
        <button type="button" onclick="setst_seq_arp_no_modulated_dynamicsIframe('')" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <!-- For some reason the button type below will not play along with justify-content-between  -->
        <!-- <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button> -->
      </div>
      <div class="modal-body">
        <iframe id="st_seq_arp_no_modulated_dynamics-iframe" src="" height="100%" width="100%"></iframe>
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
function setst_seq_arp_no_modulated_dynamicsIframe(url){
  var st_seq_arp_no_modulated_dynamicsIframe = document.getElementById("st_seq_arp_no_modulated_dynamics-iframe");
  st_seq_arp_no_modulated_dynamicsIframe.src = url;
};

// This dismisses popovers when anything else is clicked, but users probably want to refer to instructions/solution while clicking on things, so commenting it out for now
// $('.popover-dismiss').popover({
//   trigger: 'focus'
// })
</script>

```

<!-- CAPTION BLOCK -->
<div class="figure" style="margin-top: 0px;padding-top: 0px;"><p class="caption">(\#fig:st-seq-arp-no-modulated-dynamics)(ref:st-seq-arp-no-modulated-dynamics)</p></div>

Now we can add dynamics to the patch as previously discussed.
Try adding a VCF and an LFO to control both the VCF and the ADSR  using the button in Figure \@ref(fig:st-seq-arp-plus-dynamics).
Deciding the VCF and ADSR's setpoints and just how much the LFO will affect them can require a lot of back and forth as the changes are fairly subtle.


(ref:st-seq-arp-plus-dynamics) [Virtual modular](https://cardinal.olney.ai) for adjusting  dynamics using the arpeggio patch from Figure \@ref(fig:st-seq-arp-no-modulated-dynamics).

<!-- MODAL HTML BLOCK -->

```{=html}
<!-- Button trigger modal -->
<!-- <div class="d-flex flex-column min-vh-100 justify-content-center align-items-center"> -->
<div class="d-flex flex-column justify-content-center align-items-center">
  <button type="button" style="margin-top: 20px;margin-bottom: 5px" onclick="setst_seq_arp_plus_dynamicsIframe('https://cardinal.olney.ai?patchurl=st-seq-arp-no-modulated-dynamics.vcv')" class="btn btn-primary" data-toggle="modal" data-target="#st_seq_arp_plus_dynamics">
    Launch Virtual Modular
  </button>
</div>


<!-- Modal -->
<div class="modal fade" id="st_seq_arp_plus_dynamics" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="st_seq_arp_plus_dynamicsLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header justify-content-between">
        <!-- <h5 class="modal-title" id="st_seq_arp_plus_dynamicsLabel">Modal title</h5> -->
        <!-- To dismiss popovers when other elements are clicked, add this back in and uncomment jquery at end of template
        <button type="button" class="btn btn-secondary" title="Instructions" data-toggle="popover" data-trigger="focus" data-html="true" data-content="&lt;ul&gt;
&lt;li&gt;Add LFO and VCF to the left of Sassy on the lower row&lt;/li&gt;
&lt;li&gt;Connect Scope out 1 to VCF in and Sassy input 1, VCF LPF out to Scope 2 in, and Scope 2 out to Host audio L&lt;/li&gt;
&lt;li&gt;Connect LFO out (pick a wave) to VCF cutoff in&lt;/li&gt;
&lt;li&gt;Try to iteratively adjust the following and note the change in sound, scope, and spectrum&lt;ul&gt;
&lt;li&gt;Change the VCF cutoff to either the floor of the dull/bright cycle or the average (and depending on your choice, change the offset button on the LFO)&lt;/li&gt;
&lt;li&gt;Change the cutoff attenuator to adjust the depth of the change coming from the LFO&lt;/li&gt;
&lt;li&gt;Change the shape of the LFO to match the sound - does it spend more time at the extremes (sine) or move evenly between them (triangle) or something else?&lt;/li&gt;
&lt;/ul&gt;&lt;/li&gt;
&lt;li&gt;Once you have the VCF adjusted, connect the LFO to the ADSR parameter inputs (attack, decay, etc)&lt;/li&gt;
&lt;li&gt;Try to iteratively adjust the following and note the change in sound, scope, and spectrum&lt;ul&gt;
&lt;li&gt;Change the ADSR parameters to either the floor of the dull/bright cycle or the average (mirror your previous choice)&lt;/li&gt;
&lt;li&gt;Change the parameter attenuators to adjust the depth of the change coming from the LFO, remembering this can be in the positive or negative direction&lt;/li&gt;
&lt;li&gt;Reconsider the shape of the LFO - does the current shape work, or is a different shape needed?&lt;/li&gt;
&lt;/ul&gt;&lt;/li&gt;
&lt;/ul&gt;
">Instructions</button>
        <button type="button" class="btn btn-secondary" title="Solution" data-toggle="popover" data-trigger="focus" data-html="true" data-content="&lt;img class='rack-image-6u' src='images/patch-solutions/st-seq-arp-plus-dynamics.png'&gt;">Solution</button> -->
        <!-- using a different data-toggle than 'popover' because bookdown seems to have customized popover for footnotes, etc, with a different close click behaviour -->
        <button type="button" class="btn btn-secondary" title="Instructions" data-toggle="modal-popover" data-placement="bottom" data-custom-class="modal-popover"
        data-html="true" data-content="&lt;ul&gt;
&lt;li&gt;Add LFO and VCF to the left of Sassy on the lower row&lt;/li&gt;
&lt;li&gt;Connect Scope out 1 to VCF in and Sassy input 1, VCF LPF out to Scope 2 in, and Scope 2 out to Host audio L&lt;/li&gt;
&lt;li&gt;Connect LFO out (pick a wave) to VCF cutoff in&lt;/li&gt;
&lt;li&gt;Try to iteratively adjust the following and note the change in sound, scope, and spectrum&lt;ul&gt;
&lt;li&gt;Change the VCF cutoff to either the floor of the dull/bright cycle or the average (and depending on your choice, change the offset button on the LFO)&lt;/li&gt;
&lt;li&gt;Change the cutoff attenuator to adjust the depth of the change coming from the LFO&lt;/li&gt;
&lt;li&gt;Change the shape of the LFO to match the sound - does it spend more time at the extremes (sine) or move evenly between them (triangle) or something else?&lt;/li&gt;
&lt;/ul&gt;&lt;/li&gt;
&lt;li&gt;Once you have the VCF adjusted, connect the LFO to the ADSR parameter inputs (attack, decay, etc)&lt;/li&gt;
&lt;li&gt;Try to iteratively adjust the following and note the change in sound, scope, and spectrum&lt;ul&gt;
&lt;li&gt;Change the ADSR parameters to either the floor of the dull/bright cycle or the average (mirror your previous choice)&lt;/li&gt;
&lt;li&gt;Change the parameter attenuators to adjust the depth of the change coming from the LFO, remembering this can be in the positive or negative direction&lt;/li&gt;
&lt;li&gt;Reconsider the shape of the LFO - does the current shape work, or is a different shape needed?&lt;/li&gt;
&lt;/ul&gt;&lt;/li&gt;
&lt;/ul&gt;
">Instructions</button>
        <button type="button" class="btn btn-secondary" title="Solution" data-toggle="modal-popover" data-placement="bottom" data-custom-class="modal-popover"
        data-html="true" data-content="&lt;img class='rack-image-6u' src='images/patch-solutions/st-seq-arp-plus-dynamics.png'&gt;">Solution</button>
        <button type="button" onclick="setst_seq_arp_plus_dynamicsIframe('')" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <!-- For some reason the button type below will not play along with justify-content-between  -->
        <!-- <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button> -->
      </div>
      <div class="modal-body">
        <iframe id="st_seq_arp_plus_dynamics-iframe" src="" height="100%" width="100%"></iframe>
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
function setst_seq_arp_plus_dynamicsIframe(url){
  var st_seq_arp_plus_dynamicsIframe = document.getElementById("st_seq_arp_plus_dynamics-iframe");
  st_seq_arp_plus_dynamicsIframe.src = url;
};

// This dismisses popovers when anything else is clicked, but users probably want to refer to instructions/solution while clicking on things, so commenting it out for now
// $('.popover-dismiss').popover({
//   trigger: 'focus'
// })
</script>

```

<!-- CAPTION BLOCK -->
<div class="figure" style="margin-top: 0px;padding-top: 0px;"><p class="caption">(\#fig:st-seq-arp-plus-dynamics)(ref:st-seq-arp-plus-dynamics)</p></div>

Altogether the solution seems fairly reasonable, though since the waveshapes were based on a sample of the the spectrum in a particular part of the overall cycle, it could be that the lowest square wave should be a saw in order to sound correct as the filter cutoff cycles up and down.
Other possibilities in our current design space include a slight detuning between square waves that changes over time or PWM that changes over time.

## Chiptune

Chiptune is a genre of music so-called because it originated in sound chips used to synthesize music in early electronics like arcade games and computers.
These early sound chips had low-fidelity digital implementations of various functions we've encountered in modular, like basic waveshapes, noise generators, and envelopes.
Because the sound chips were relatively limited in capability, designers developed various techniques to create bigger and more interesting sounds.
One of these tricks, the arpeggio, allowed chips with limited polyphony to emulate it, and thus arpeggio, particularly fast arpeggio, is common in chiptune. 
If you are not familiar with chiptune, check out the video in Figure \@ref(fig:chiptune-video).

(ref:chiptune-video) [YouTube video](https://youtu.be/NfxArPJpN5I) of a chiptune groove.  Image [© Noise Engineering](https://www.youtube.com/c/NoiseEngineering).

<div class="figure">
<iframe src="https://www.youtube.com/embed/NfxArPJpN5I?start=0" width="672" height="400px" data-external="1"></iframe>
<p class="caption">(\#fig:chiptune-video)(ref:chiptune-video)</p>
</div>

Our design problem is to create a rapid arpeggio reminiscent of chiptune that transposes over time, like Figure \@ref(fig:chiptune-video), along with simple percussion in the form of hats and kick drum.
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

```{=html}
<!-- Button trigger modal -->
<!-- <div class="d-flex flex-column min-vh-100 justify-content-center align-items-center"> -->
<div class="d-flex flex-column justify-content-center align-items-center">
  <button type="button" style="margin-top: 20px;margin-bottom: 5px" onclick="setchiptune_single_arpIframe('https://cardinal.olney.ai?patchurl=empty.vcv')" class="btn btn-primary" data-toggle="modal" data-target="#chiptune_single_arp">
    Launch Virtual Modular
  </button>
</div>


<!-- Modal -->
<div class="modal fade" id="chiptune_single_arp" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="chiptune_single_arpLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header justify-content-between">
        <!-- <h5 class="modal-title" id="chiptune_single_arpLabel">Modal title</h5> -->
        <!-- To dismiss popovers when other elements are clicked, add this back in and uncomment jquery at end of template
        <button type="button" class="btn btn-secondary" title="Instructions" data-toggle="popover" data-trigger="focus" data-html="true" data-content="&lt;ul&gt;
&lt;li&gt;Add Reftone, Volt meter, BPM Clock, ADDR-SEQ, VCO, QuadVCA/Mixer, Scope, and Host audio&lt;/li&gt;
&lt;li&gt;Connect Clock 16ths out to ADDR-SEQ clock in&lt;/li&gt;
&lt;li&gt;Connect ADDR-SEQ out to V/Oct of the VCO &lt;/li&gt;
&lt;li&gt;Connect VCO square out to QuadVCA/Mixer input 1&lt;/li&gt;
&lt;li&gt;Connect QuadVCA/Mixer mix output to Scope input 1 and Scope out to Host audio L&lt;/li&gt;
&lt;li&gt;Connect Reftone V/Oct to Volt Meter input 1&lt;/li&gt;
&lt;li&gt;Selecting the first three steps of ADDR-SEQ in turn, use the Reftone pitch and octave knobs to get the voltage for the notes you need, A, B, and E, and set the corresponding step voltage. Make sure the sequencer is set for 3 steps only&lt;/li&gt;
&lt;li&gt;Try runnning the clock at different BPMs; a target BPM around 225 is suggested&lt;/li&gt;
&lt;/ul&gt;
">Instructions</button>
        <button type="button" class="btn btn-secondary" title="Solution" data-toggle="popover" data-trigger="focus" data-html="true" data-content="&lt;img class='rack-image' src='images/patch-solutions/chiptune-single-arp.png'&gt;">Solution</button> -->
        <!-- using a different data-toggle than 'popover' because bookdown seems to have customized popover for footnotes, etc, with a different close click behaviour -->
        <button type="button" class="btn btn-secondary" title="Instructions" data-toggle="modal-popover" data-placement="bottom" data-custom-class="modal-popover"
        data-html="true" data-content="&lt;ul&gt;
&lt;li&gt;Add Reftone, Volt meter, BPM Clock, ADDR-SEQ, VCO, QuadVCA/Mixer, Scope, and Host audio&lt;/li&gt;
&lt;li&gt;Connect Clock 16ths out to ADDR-SEQ clock in&lt;/li&gt;
&lt;li&gt;Connect ADDR-SEQ out to V/Oct of the VCO &lt;/li&gt;
&lt;li&gt;Connect VCO square out to QuadVCA/Mixer input 1&lt;/li&gt;
&lt;li&gt;Connect QuadVCA/Mixer mix output to Scope input 1 and Scope out to Host audio L&lt;/li&gt;
&lt;li&gt;Connect Reftone V/Oct to Volt Meter input 1&lt;/li&gt;
&lt;li&gt;Selecting the first three steps of ADDR-SEQ in turn, use the Reftone pitch and octave knobs to get the voltage for the notes you need, A, B, and E, and set the corresponding step voltage. Make sure the sequencer is set for 3 steps only&lt;/li&gt;
&lt;li&gt;Try runnning the clock at different BPMs; a target BPM around 225 is suggested&lt;/li&gt;
&lt;/ul&gt;
">Instructions</button>
        <button type="button" class="btn btn-secondary" title="Solution" data-toggle="modal-popover" data-placement="bottom" data-custom-class="modal-popover"
        data-html="true" data-content="&lt;img class='rack-image' src='images/patch-solutions/chiptune-single-arp.png'&gt;">Solution</button>
        <button type="button" onclick="setchiptune_single_arpIframe('')" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <!-- For some reason the button type below will not play along with justify-content-between  -->
        <!-- <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button> -->
      </div>
      <div class="modal-body">
        <iframe id="chiptune_single_arp-iframe" src="" height="100%" width="100%"></iframe>
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
function setchiptune_single_arpIframe(url){
  var chiptune_single_arpIframe = document.getElementById("chiptune_single_arp-iframe");
  chiptune_single_arpIframe.src = url;
};

// This dismisses popovers when anything else is clicked, but users probably want to refer to instructions/solution while clicking on things, so commenting it out for now
// $('.popover-dismiss').popover({
//   trigger: 'focus'
// })
</script>

```

<!-- CAPTION BLOCK -->
<div class="figure" style="margin-top: 0px;padding-top: 0px;"><p class="caption">(\#fig:chiptune-single-arp)(ref:chiptune-single-arp)</p></div>

### LFO PWM

We previously controlled PWM using an LFO in Section \@ref(pulse-width-modulation), so it is easy to adapt that solution to control the square wave chiptune VCO.
Additionally, let's add an ADSR to control the VCA to get more note-like dynamics.
Try patching up the LFO into a PWM and ADSR using the button in Figure \@ref(fig:chiptune-single-arp-pwm).

(ref:chiptune-single-arp-pwm) [Virtual modular](https://cardinal.olney.ai) for setting up an enveloped chiptune arpeggio with pulse width modulated by an LFO.

<!-- MODAL HTML BLOCK -->

```{=html}
<!-- Button trigger modal -->
<!-- <div class="d-flex flex-column min-vh-100 justify-content-center align-items-center"> -->
<div class="d-flex flex-column justify-content-center align-items-center">
  <button type="button" style="margin-top: 20px;margin-bottom: 5px" onclick="setchiptune_single_arp_pwmIframe('https://cardinal.olney.ai?patchurl=chiptune-single-arp.vcv')" class="btn btn-primary" data-toggle="modal" data-target="#chiptune_single_arp_pwm">
    Launch Virtual Modular
  </button>
</div>


<!-- Modal -->
<div class="modal fade" id="chiptune_single_arp_pwm" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="chiptune_single_arp_pwmLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header justify-content-between">
        <!-- <h5 class="modal-title" id="chiptune_single_arp_pwmLabel">Modal title</h5> -->
        <!-- To dismiss popovers when other elements are clicked, add this back in and uncomment jquery at end of template
        <button type="button" class="btn btn-secondary" title="Instructions" data-toggle="popover" data-trigger="focus" data-html="true" data-content="&lt;ul&gt;
&lt;li&gt;Add an LFO to the left of the VCO, and add an ADSR to the right of the VCO&lt;/li&gt;
&lt;li&gt;Connect LFO triangle out to VCO PWM&lt;/li&gt;
&lt;li&gt;Connect Clock 16ths to ADSR gate &lt;/li&gt;
&lt;li&gt;Connect ADSR out to QuadVCA/Mixer CV input 1&lt;/li&gt;
&lt;li&gt;Try the following and note the differences in the sound and scope waveshape&lt;ul&gt;
&lt;li&gt;Adjust the PWM width manually, deciding if you want a unipolar or bipolar LFO offset&lt;/li&gt;
&lt;li&gt;Adjust the LFO rate and the PWM attenuator knob to change the speed and depth of the modulation&lt;/li&gt;
&lt;li&gt;Manually adjust the ADSR parameters to taste&lt;/li&gt;
&lt;/ul&gt;&lt;/li&gt;
&lt;/ul&gt;
">Instructions</button>
        <button type="button" class="btn btn-secondary" title="Solution" data-toggle="popover" data-trigger="focus" data-html="true" data-content="&lt;img class='rack-image' src='images/patch-solutions/chiptune-single-arp-pwm.png'&gt;">Solution</button> -->
        <!-- using a different data-toggle than 'popover' because bookdown seems to have customized popover for footnotes, etc, with a different close click behaviour -->
        <button type="button" class="btn btn-secondary" title="Instructions" data-toggle="modal-popover" data-placement="bottom" data-custom-class="modal-popover"
        data-html="true" data-content="&lt;ul&gt;
&lt;li&gt;Add an LFO to the left of the VCO, and add an ADSR to the right of the VCO&lt;/li&gt;
&lt;li&gt;Connect LFO triangle out to VCO PWM&lt;/li&gt;
&lt;li&gt;Connect Clock 16ths to ADSR gate &lt;/li&gt;
&lt;li&gt;Connect ADSR out to QuadVCA/Mixer CV input 1&lt;/li&gt;
&lt;li&gt;Try the following and note the differences in the sound and scope waveshape&lt;ul&gt;
&lt;li&gt;Adjust the PWM width manually, deciding if you want a unipolar or bipolar LFO offset&lt;/li&gt;
&lt;li&gt;Adjust the LFO rate and the PWM attenuator knob to change the speed and depth of the modulation&lt;/li&gt;
&lt;li&gt;Manually adjust the ADSR parameters to taste&lt;/li&gt;
&lt;/ul&gt;&lt;/li&gt;
&lt;/ul&gt;
">Instructions</button>
        <button type="button" class="btn btn-secondary" title="Solution" data-toggle="modal-popover" data-placement="bottom" data-custom-class="modal-popover"
        data-html="true" data-content="&lt;img class='rack-image' src='images/patch-solutions/chiptune-single-arp-pwm.png'&gt;">Solution</button>
        <button type="button" onclick="setchiptune_single_arp_pwmIframe('')" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <!-- For some reason the button type below will not play along with justify-content-between  -->
        <!-- <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button> -->
      </div>
      <div class="modal-body">
        <iframe id="chiptune_single_arp_pwm-iframe" src="" height="100%" width="100%"></iframe>
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
function setchiptune_single_arp_pwmIframe(url){
  var chiptune_single_arp_pwmIframe = document.getElementById("chiptune_single_arp_pwm-iframe");
  chiptune_single_arp_pwmIframe.src = url;
};

// This dismisses popovers when anything else is clicked, but users probably want to refer to instructions/solution while clicking on things, so commenting it out for now
// $('.popover-dismiss').popover({
//   trigger: 'focus'
// })
</script>

```

<!-- CAPTION BLOCK -->
<div class="figure" style="margin-top: 0px;padding-top: 0px;"><p class="caption">(\#fig:chiptune-single-arp-pwm)(ref:chiptune-single-arp-pwm)</p></div>

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
<iframe src="https://www.youtube.com/embed/BlHnw4rgUEc?start=0" width="672" height="400px" data-external="1"></iframe>
<p class="caption">(\#fig:two-sequencers-mixed)(ref:two-sequencers-mixed)</p>
</div>

(ref:chiptune-single-arp-pwm-transpose) [Virtual modular](https://cardinal.olney.ai) for setting up an enveloped chiptune arpeggio with pulse width modulated by an LFO, transposed by a second sequencer every bar.

<!-- MODAL HTML BLOCK -->

```{=html}
<!-- Button trigger modal -->
<!-- <div class="d-flex flex-column min-vh-100 justify-content-center align-items-center"> -->
<div class="d-flex flex-column justify-content-center align-items-center">
  <button type="button" style="margin-top: 20px;margin-bottom: 5px" onclick="setchiptune_single_arp_pwm_transposeIframe('https://cardinal.olney.ai?patchurl=chiptune-single-arp-pwm.vcv')" class="btn btn-primary" data-toggle="modal" data-target="#chiptune_single_arp_pwm_transpose">
    Launch Virtual Modular
  </button>
</div>


<!-- Modal -->
<div class="modal fade" id="chiptune_single_arp_pwm_transpose" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="chiptune_single_arp_pwm_transposeLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header justify-content-between">
        <!-- <h5 class="modal-title" id="chiptune_single_arp_pwm_transposeLabel">Modal title</h5> -->
        <!-- To dismiss popovers when other elements are clicked, add this back in and uncomment jquery at end of template
        <button type="button" class="btn btn-secondary" title="Instructions" data-toggle="popover" data-trigger="focus" data-html="true" data-content="&lt;ul&gt;
&lt;li&gt;Add a second ADDR-SEQ to the right of the existing one, and add mixer to the right of the new ADDR-SEQ&lt;/li&gt;
&lt;li&gt;Connect Clock Bar to the new ADDR-SEQ clock in&lt;/li&gt;
&lt;li&gt;Connect the outs of the two ADDR-SEQ to the new QuadVCA/Mixer inputs 1 and 2&lt;/li&gt;
&lt;li&gt;Connect  QuadVCA/Mixer out to VCO V/Oct&lt;/li&gt;
&lt;li&gt;Selecting each of the eight ADDR-SEQ steps in turn, use the Reftone pitch and octave knobs to get the voltage for the notes you need, e.g. G#, D#, C#, C, G#, D#, E, and C - note most of these are just the negative of the original arpeggio voltages except C which is zero and E.  Make sure the sequencer is set for all 8 steps&lt;/li&gt;
&lt;li&gt;Try different clock settings and different beat divisions for both sequencers&lt;/li&gt;
&lt;/ul&gt;
">Instructions</button>
        <button type="button" class="btn btn-secondary" title="Solution" data-toggle="popover" data-trigger="focus" data-html="true" data-content="&lt;img class='rack-image' src='images/patch-solutions/chiptune-single-arp-pwm-transpose.png'&gt;">Solution</button> -->
        <!-- using a different data-toggle than 'popover' because bookdown seems to have customized popover for footnotes, etc, with a different close click behaviour -->
        <button type="button" class="btn btn-secondary" title="Instructions" data-toggle="modal-popover" data-placement="bottom" data-custom-class="modal-popover"
        data-html="true" data-content="&lt;ul&gt;
&lt;li&gt;Add a second ADDR-SEQ to the right of the existing one, and add mixer to the right of the new ADDR-SEQ&lt;/li&gt;
&lt;li&gt;Connect Clock Bar to the new ADDR-SEQ clock in&lt;/li&gt;
&lt;li&gt;Connect the outs of the two ADDR-SEQ to the new QuadVCA/Mixer inputs 1 and 2&lt;/li&gt;
&lt;li&gt;Connect  QuadVCA/Mixer out to VCO V/Oct&lt;/li&gt;
&lt;li&gt;Selecting each of the eight ADDR-SEQ steps in turn, use the Reftone pitch and octave knobs to get the voltage for the notes you need, e.g. G#, D#, C#, C, G#, D#, E, and C - note most of these are just the negative of the original arpeggio voltages except C which is zero and E.  Make sure the sequencer is set for all 8 steps&lt;/li&gt;
&lt;li&gt;Try different clock settings and different beat divisions for both sequencers&lt;/li&gt;
&lt;/ul&gt;
">Instructions</button>
        <button type="button" class="btn btn-secondary" title="Solution" data-toggle="modal-popover" data-placement="bottom" data-custom-class="modal-popover"
        data-html="true" data-content="&lt;img class='rack-image' src='images/patch-solutions/chiptune-single-arp-pwm-transpose.png'&gt;">Solution</button>
        <button type="button" onclick="setchiptune_single_arp_pwm_transposeIframe('')" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <!-- For some reason the button type below will not play along with justify-content-between  -->
        <!-- <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button> -->
      </div>
      <div class="modal-body">
        <iframe id="chiptune_single_arp_pwm_transpose-iframe" src="" height="100%" width="100%"></iframe>
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
function setchiptune_single_arp_pwm_transposeIframe(url){
  var chiptune_single_arp_pwm_transposeIframe = document.getElementById("chiptune_single_arp_pwm_transpose-iframe");
  chiptune_single_arp_pwm_transposeIframe.src = url;
};

// This dismisses popovers when anything else is clicked, but users probably want to refer to instructions/solution while clicking on things, so commenting it out for now
// $('.popover-dismiss').popover({
//   trigger: 'focus'
// })
</script>

```

<!-- CAPTION BLOCK -->
<div class="figure" style="margin-top: 0px;padding-top: 0px;"><p class="caption">(\#fig:chiptune-single-arp-pwm-transpose)(ref:chiptune-single-arp-pwm-transpose)</p></div>

### Hats and kick

We made hats in Section \@ref(noise) and simple kicks in Section \@ref(clocks-as-sequencers), so these are both problems we know how to solve.
A simple hat is just high frequency noise through an envelope/VCA, and a simple kick is just a sine through an envelope/VCA.
Both voices are ideally controlled with trigger sequencers, and by using two different sequencers we can use different patterns for each.
Try patching up hats and kick with their own sequencers using the button in Figure \@ref(fig:chiptune-single-arp-pwm-transpose-hats-kick).


(ref:chiptune-single-arp-pwm-transpose-hats-kick) [Virtual modular](https://cardinal.olney.ai) for setting up an enveloped chiptune arpeggio with pulse width modulated by an LFO, transposed by a second sequencer every bar, with hats and kick as additional voices.

<!-- MODAL HTML BLOCK -->

```{=html}
<!-- Button trigger modal -->
<!-- <div class="d-flex flex-column min-vh-100 justify-content-center align-items-center"> -->
<div class="d-flex flex-column justify-content-center align-items-center">
  <button type="button" style="margin-top: 20px;margin-bottom: 5px" onclick="setchiptune_single_arp_pwm_transpose_hats_kickIframe('https://cardinal.olney.ai?patchurl=chiptune-single-arp-pwm-transpose.vcv')" class="btn btn-primary" data-toggle="modal" data-target="#chiptune_single_arp_pwm_transpose_hats_kick">
    Launch Virtual Modular
  </button>
</div>


<!-- Modal -->
<div class="modal fade" id="chiptune_single_arp_pwm_transpose_hats_kick" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="chiptune_single_arp_pwm_transpose_hats_kickLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header justify-content-between">
        <!-- <h5 class="modal-title" id="chiptune_single_arp_pwm_transpose_hats_kickLabel">Modal title</h5> -->
        <!-- To dismiss popovers when other elements are clicked, add this back in and uncomment jquery at end of template
        <button type="button" class="btn btn-secondary" title="Instructions" data-toggle="popover" data-trigger="focus" data-html="true" data-content="&lt;ul&gt;
&lt;li&gt;Add a TRG, Noiz, and ADSR on the bottom row&lt;/li&gt;
&lt;li&gt;Connect Clock 8ths to TRG clock in&lt;/li&gt;
&lt;li&gt;Connect TRG gate out to ADSR gate in&lt;/li&gt;
&lt;li&gt;Connect Noiz blue out to the main QuadVCA/Mixer input 2 and ADSR out to the CV control of that same mixer channel&lt;/li&gt;
&lt;li&gt;Adjust the TRG steps down to 8 and select steps for the hats and adjust the ADSR envelope to suit&lt;/li&gt;
&lt;li&gt;Repeat these steps but use a VCO sine out instead of Noiz&lt;/li&gt;
&lt;li&gt;Adjust the main mix out levels and rhythms to match chiptune as best you can&lt;/li&gt;
&lt;/ul&gt;
">Instructions</button>
        <button type="button" class="btn btn-secondary" title="Solution" data-toggle="popover" data-trigger="focus" data-html="true" data-content="&lt;img class='rack-image-6u' src='images/patch-solutions/chiptune-single-arp-pwm-transpose-hats-kick.png'&gt;">Solution</button> -->
        <!-- using a different data-toggle than 'popover' because bookdown seems to have customized popover for footnotes, etc, with a different close click behaviour -->
        <button type="button" class="btn btn-secondary" title="Instructions" data-toggle="modal-popover" data-placement="bottom" data-custom-class="modal-popover"
        data-html="true" data-content="&lt;ul&gt;
&lt;li&gt;Add a TRG, Noiz, and ADSR on the bottom row&lt;/li&gt;
&lt;li&gt;Connect Clock 8ths to TRG clock in&lt;/li&gt;
&lt;li&gt;Connect TRG gate out to ADSR gate in&lt;/li&gt;
&lt;li&gt;Connect Noiz blue out to the main QuadVCA/Mixer input 2 and ADSR out to the CV control of that same mixer channel&lt;/li&gt;
&lt;li&gt;Adjust the TRG steps down to 8 and select steps for the hats and adjust the ADSR envelope to suit&lt;/li&gt;
&lt;li&gt;Repeat these steps but use a VCO sine out instead of Noiz&lt;/li&gt;
&lt;li&gt;Adjust the main mix out levels and rhythms to match chiptune as best you can&lt;/li&gt;
&lt;/ul&gt;
">Instructions</button>
        <button type="button" class="btn btn-secondary" title="Solution" data-toggle="modal-popover" data-placement="bottom" data-custom-class="modal-popover"
        data-html="true" data-content="&lt;img class='rack-image-6u' src='images/patch-solutions/chiptune-single-arp-pwm-transpose-hats-kick.png'&gt;">Solution</button>
        <button type="button" onclick="setchiptune_single_arp_pwm_transpose_hats_kickIframe('')" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <!-- For some reason the button type below will not play along with justify-content-between  -->
        <!-- <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button> -->
      </div>
      <div class="modal-body">
        <iframe id="chiptune_single_arp_pwm_transpose_hats_kick-iframe" src="" height="100%" width="100%"></iframe>
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
function setchiptune_single_arp_pwm_transpose_hats_kickIframe(url){
  var chiptune_single_arp_pwm_transpose_hats_kickIframe = document.getElementById("chiptune_single_arp_pwm_transpose_hats_kick-iframe");
  chiptune_single_arp_pwm_transpose_hats_kickIframe.src = url;
};

// This dismisses popovers when anything else is clicked, but users probably want to refer to instructions/solution while clicking on things, so commenting it out for now
// $('.popover-dismiss').popover({
//   trigger: 'focus'
// })
</script>

```

<!-- CAPTION BLOCK -->
<div class="figure" style="margin-top: 0px;padding-top: 0px;"><p class="caption">(\#fig:chiptune-single-arp-pwm-transpose-hats-kick)(ref:chiptune-single-arp-pwm-transpose-hats-kick)</p></div>


