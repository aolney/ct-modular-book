# Modulating Modifiers {#complex-modifiers}

Modifying incoming audio and control signals was introduced in Chapter \@ref(modifiers).
The present chapter introduces new modules and extends earlier concepts in modifiers around the loose organizing theme of converting between earlier signals, e.g. from gates to envelopes.

## Rectification and wavefolding

As discussed in Chapter \@ref(basic-modeling-concepts), signals are either unipolar or bipolar.
One way to make a bipolar signal unipolar is to add an offset to it, e.g. if a signal ranges from -5 to +5 V, then add 5 V to obtain a 0 to +10 V signal.
Another more interesting way to convert a bipolar signal to unipolar is to rectify the signal, as shown in Figure \@ref(fig:rectification).
Half-wave rectification simply removes the negative part of the signal by stopping the signal at zero, and staying at zero until the signal becomes positive again.
Full-wave rectification reflects the signal across the x-axis, i.e. takes the absolute value of the signal.
If you add a fully rectified signal to the original signal, you will get a half rectified signal because the negative portion of the original signal and the reflected portion of the fully rectified signal will cancel out. 

(ref:rectification) [Rectification](https://upload.wikimedia.org/wikipedia/commons/0/08/Sine_curve_drawing_animation.gif) of a sine wave using either half or full rectification. Image [©  	Omegatron/CC-BY-SA-3.0](https://commons.wikimedia.org/wiki/File:Rectified_waves.png).

<div class="figure">
<img src="images/rectification.png" alt="(ref:rectification)" width="100%" />
<p class="caption">(\#fig:rectification)(ref:rectification)</p>
</div>

A variation of rectification is wavefolding.
In wavefolding, a comparator (see Section \@ref(addingremoving-gates-with-probability)) triggers reflection of the wave when it reaches an upper or lower threshold, as shown in Figure \@ref(fig:wavefold-sine).
Thus wavefolding is like rectification on parts of the signal that cross these boundaries, but a folding parameter allows the amplitude of the wave to increase until it reaches the opposing boundary, repeating the process.
Wavefolding does not affect the polarity of a signal.

(ref:wavefold-sine) Wavefolding (green) of a sine wave (purple). The fold parameter moves the top and bottom portions of the wave to their respective boundaries where they reflect (left). Further increase of the fold parameter causes them to reach the opposing boundary and reflect again (right), a repeatable process that creates additional folds.

<div class="figure">
<img src="images/sine-wavefold-2.png" alt="(ref:wavefold-sine)" width="100%" />
<p class="caption">(\#fig:wavefold-sine)(ref:wavefold-sine)</p>
</div>

Rectification and wavefolding change harmonics and therefore timbre.
The best way to understand their effect on harmonics is to consider a triangle at full rectification.
As the bottom part of the triangle is reflected, the resulting wave is still a triangle wave, but at twice the frequency as before, e.g. a 200 Hz wave becomes a 400 Hz wave, and the signal is offset above zero.
For a triangle wave, wavefolding doesn't double frequency but instead triples it, e.g. a 200 Hz wave becomes a 600 Hz wave. 
Tripling occurs because when a peak reflects, it creates two additional peaks in addition to itself.
Figure \@ref(fig:triangle-rect-fold) illustrates these two cases.
The tripling behavior of wavefolding means that it will add all odd harmonics to a sine wave but not add harmonics to the other basic waveshapes, because they already have odd harmonics.
Instead, wavefolding will change the relative strengths of the harmonics, and as wavefolding increases it will put more energy into higher harmonics for a brighter sound.


(ref:triangle-rect-fold) Full wave rectification (left) and wavefolding (right) of a triangle wave. The wavefolded peaks that have just reached the boundary are circled. 

<div class="figure">
<img src="images/triangle-rect-fold.png" alt="(ref:triangle-rect-fold)" width="100%" />
<p class="caption">(\#fig:triangle-rect-fold)(ref:triangle-rect-fold)</p>
</div>


The square wave has unusual behavior for wavefolding and rectification that deserves special mention.
During wavefolding, the upper and lower parts of the square wave will move in opposite directions rather than fold as shown in Figures \@ref(fig:wavefold-sine) and \@ref(fig:triangle-rect-fold).
As a consequence, there are moments where the two parts of the square wave meet at zero and result in a non-wave, somewhat comparable to amplitude modulation through wave folding.
Half rectification on a square wave turns it into an identical square wave, but at half amplitude and an offset.
Full rectification on a square wave turns it into just an offset, i.e. a constant voltage.
Because a constant voltage has zero frequency (0 Hz) it can be removed with a high pass filter - this is a good idea in most audio applications where constant voltages create noise.^[High pass filtering is a good idea when using clocks or clock dividers outputs as square waves for the same reason.]

The effects of rectification and wavefolding on the four basic wave shapes is summarized in Table \@ref(tab:freq-ratio) with respect to the addition of harmonics, change in frequency, and change in amplitude.
In all cases, the amplitude of individual harmonics changes, leading to a change in timbre with respect to the original wave.
Sometimes these changes can be quite extreme.
For example, a saw wave at full rectification keeps all harmonics, but the strongest harmonics more closely match a triangle wave than a saw.

Table: (\#tab:freq-ratio) Addition of harmonics, change in frequency, and change in amplitude to the four basic waveshapes under wavefolding, half rectification, and full rectification. Note all three affect strength of harmonics and so timbre.


| Wave     | Wavefolding   | Half rectification          | Full rectification                |
|----------|---------------|-----------------------------|-----------------------------------|
| Sine     | Odd harmonics | All harmonics               | All harmonics at double frequency |
| Triangle | -             | All harmonics but every 4th | Double frequency                  |
| Square   | -             | Amplitude reduced by half   | Offset voltage                    |
| Saw      | -             | -                           | -                                 |

Let's take a look at the change in harmonics resulting from wavefolding and rectification.
The best way to hear these is to step through with a sequential switch and use an LFO to drive the wavefolding.
Try creating this patch using the button in Figure \@ref(fig:wavefold-rect-example).

(ref:wavefold-rect-example) [Virtual modular](https://cardinal.olney.ai) for contrasting the effect of wavefolding and rectification on the four basic waveshapes. 

<!-- MODAL HTML BLOCK -->

```{=html}
<!-- Button trigger modal -->
<!-- <div class="d-flex flex-column min-vh-100 justify-content-center align-items-center"> -->
<div class="d-flex flex-column justify-content-center align-items-center">
  <button type="button" style="margin-top: 20px;margin-bottom: 5px" onclick="setwavefold_rect_exampleIframe('https://cardinal.olney.ai?patchurl=empty.vcv')" class="btn btn-primary" data-toggle="modal" data-target="#wavefold_rect_example">
    Launch Virtual Modular
  </button>
</div>


<!-- Modal -->
<div class="modal fade" id="wavefold_rect_example" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="wavefold_rect_exampleLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header justify-content-between">
        <!-- <h5 class="modal-title" id="wavefold_rect_exampleLabel">Modal title</h5> -->
        <!-- To dismiss popovers when other elements are clicked, add this back in and uncomment jquery at end of template
        <button type="button" class="btn btn-secondary" title="Instructions" data-toggle="popover" data-trigger="focus" data-html="true" data-content="&lt;ul&gt;
&lt;li&gt;Add WT VCO, Utilites, Folding, LFO, Triggers MKIII, 8:1, filtah, Scope, Host audio, and Sassy&lt;/li&gt;
&lt;li&gt;Connect WT VCO out to Utilities in, Folding in, 8:1 input 1, Scope input 2, and Scope trigger in&lt;/li&gt;
&lt;li&gt;Connect Utilities half rectify out to 8:1 input 3 and full rectify out to 8:1 input 4&lt;/li&gt;
&lt;li&gt;Connect LFO triangle out to Folding depth in and change the depth attenuverter (the small knob) to 9 o'clock, a slight amount&lt;/li&gt;
&lt;li&gt;Connect Folding out to 8:1 input 2&lt;/li&gt;
&lt;li&gt;Connect Triggers MKIII out to 8:1 clock&lt;/li&gt;
&lt;li&gt;Set 8:1 steps to 4 and connect out to filtah input&lt;/li&gt;
&lt;li&gt;Set filtah type switch to high pass and cutoff to the lowest level (lets everything above zero frequency through)and connect filtah out to Scope in 1&lt;/li&gt;
&lt;li&gt;Connect Scope out 1 to Host audio L and Sassy input 1&lt;/li&gt;
&lt;li&gt;Adjust Scope time and Sassy levels and FFT resolution to the highest level&lt;/li&gt;
&lt;li&gt;Run the patch and observe the following&lt;ul&gt;
&lt;li&gt;Starting with sine, cycle through the 4 wave options using the button and note the change in sound, the image on the scope, and the change in harmonics. Mouse over the harmonics to check if they are all, odd, or even. You may prefer to set the WT VCO frequency to a round number, e.g. 200 Hz, and set the LFO to a slow rate, e.g. .2 Hz in order to make comparisons easier&lt;/li&gt;
&lt;li&gt;Repeat the above for the other three waveshapes&lt;/li&gt;
&lt;/ul&gt;&lt;/li&gt;
&lt;/ul&gt;
&lt;div class='d-flex flex-row justify-content-around'&gt;
&lt;img class='rack-image' src='images/solo-modules/audibleutilities-solo.png'&gt;
&lt;img class='rack-image' src='images/solo-modules/animatedfolding-solo.png'&gt;
&lt;img class='rack-image' src='images/solo-modules/filtah-solo.png'&gt;
&lt;/div&gt;
">Instructions</button>
        <button type="button" class="btn btn-secondary" title="Solution" data-toggle="popover" data-trigger="focus" data-html="true" data-content="&lt;img class='rack-image' src='images/patch-solutions/wavefold-rect-example.png'&gt;">Solution</button> -->
        <!-- using a different data-toggle than 'popover' because bookdown seems to have customized popover for footnotes, etc, with a different close click behaviour -->
        <button type="button" class="btn btn-secondary" title="Instructions" data-toggle="modal-popover" data-placement="bottom" data-custom-class="modal-popover"
        data-html="true" data-content="&lt;ul&gt;
&lt;li&gt;Add WT VCO, Utilites, Folding, LFO, Triggers MKIII, 8:1, filtah, Scope, Host audio, and Sassy&lt;/li&gt;
&lt;li&gt;Connect WT VCO out to Utilities in, Folding in, 8:1 input 1, Scope input 2, and Scope trigger in&lt;/li&gt;
&lt;li&gt;Connect Utilities half rectify out to 8:1 input 3 and full rectify out to 8:1 input 4&lt;/li&gt;
&lt;li&gt;Connect LFO triangle out to Folding depth in and change the depth attenuverter (the small knob) to 9 o'clock, a slight amount&lt;/li&gt;
&lt;li&gt;Connect Folding out to 8:1 input 2&lt;/li&gt;
&lt;li&gt;Connect Triggers MKIII out to 8:1 clock&lt;/li&gt;
&lt;li&gt;Set 8:1 steps to 4 and connect out to filtah input&lt;/li&gt;
&lt;li&gt;Set filtah type switch to high pass and cutoff to the lowest level (lets everything above zero frequency through)and connect filtah out to Scope in 1&lt;/li&gt;
&lt;li&gt;Connect Scope out 1 to Host audio L and Sassy input 1&lt;/li&gt;
&lt;li&gt;Adjust Scope time and Sassy levels and FFT resolution to the highest level&lt;/li&gt;
&lt;li&gt;Run the patch and observe the following&lt;ul&gt;
&lt;li&gt;Starting with sine, cycle through the 4 wave options using the button and note the change in sound, the image on the scope, and the change in harmonics. Mouse over the harmonics to check if they are all, odd, or even. You may prefer to set the WT VCO frequency to a round number, e.g. 200 Hz, and set the LFO to a slow rate, e.g. .2 Hz in order to make comparisons easier&lt;/li&gt;
&lt;li&gt;Repeat the above for the other three waveshapes&lt;/li&gt;
&lt;/ul&gt;&lt;/li&gt;
&lt;/ul&gt;
&lt;div class='d-flex flex-row justify-content-around'&gt;
&lt;img class='rack-image' src='images/solo-modules/audibleutilities-solo.png'&gt;
&lt;img class='rack-image' src='images/solo-modules/animatedfolding-solo.png'&gt;
&lt;img class='rack-image' src='images/solo-modules/filtah-solo.png'&gt;
&lt;/div&gt;
">Instructions</button>
        <button type="button" class="btn btn-secondary" title="Solution" data-toggle="modal-popover" data-placement="bottom" data-custom-class="modal-popover"
        data-html="true" data-content="&lt;img class='rack-image' src='images/patch-solutions/wavefold-rect-example.png'&gt;">Solution</button>
        <button type="button" onclick="setwavefold_rect_exampleIframe('')" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <!-- For some reason the button type below will not play along with justify-content-between  -->
        <!-- <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button> -->
      </div>
      <div class="modal-body">
        <iframe id="wavefold_rect_example-iframe" src="" height="100%" width="100%"></iframe>
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
function setwavefold_rect_exampleIframe(url){
  var wavefold_rect_exampleIframe = document.getElementById("wavefold_rect_example-iframe");
  wavefold_rect_exampleIframe.src = url;
};

// This dismisses popovers when anything else is clicked, but users probably want to refer to instructions/solution while clicking on things, so commenting it out for now
// $('.popover-dismiss').popover({
//   trigger: 'focus'
// })
</script>

```

<!-- CAPTION BLOCK -->
<div class="figure" style="margin-top: 0px;padding-top: 0px;"><p class="caption">(\#fig:wavefold-rect-example)(ref:wavefold-rect-example)</p></div>

Rectification has multiple uses besides changing harmonics.
One obvious use is making a bipolar control signal unipolar (e.g. to drive a VCA).
Another interesting use is to use rectification to perform waveshape surgery and combine the top part of one waveshape with the bottom of another.
This is relatively simple to do by fully rectifying two waveshapes and inverting one to become the bottom portion of the wave.
It's slightly trickier to align the top and bottom portions, but it's possible to do so using a module that allows specfication of phase offsets.
Figure \@ref(fig:fraken-rect) shows an example of waveshape surgery using the top portion of a sine wave and the bottom portion of a square wave.
By blending parts of different waves, you can achieve an intermediate sound, e.g. a slightly more mellow square wave.

(ref:fraken-rect) Upper sine wave and lower square wave portions cut using rectification and aligned with a phase offset (left). The final wave is high pass filtered to remove the voltage offset (right).

<div class="figure">
<img src="images/fraken-rect.png" alt="(ref:fraken-rect)" width="100%" />
<p class="caption">(\#fig:fraken-rect)(ref:fraken-rect)</p>
</div>

Try creating a new waveshape through rectification using the button in Figure \@ref(fig:franken-rect).
This method would also allow you to perform operations on just one part of the signal if desired, e.g. waveshaping on just the top half.

(ref:franken-rect) [Virtual modular](https://cardinal.olney.ai) for contrasting the effect of wavefolding and rectification on the four basic waveshapes. 

<!-- TODO replace 8vert with Bogg Audio Offset? -->

<!-- MODAL HTML BLOCK -->

```{=html}
<!-- Button trigger modal -->
<!-- <div class="d-flex flex-column min-vh-100 justify-content-center align-items-center"> -->
<div class="d-flex flex-column justify-content-center align-items-center">
  <button type="button" style="margin-top: 20px;margin-bottom: 5px" onclick="setfranken_rectIframe('https://cardinal.olney.ai?patchurl=wavefold-rect-example.vcv')" class="btn btn-primary" data-toggle="modal" data-target="#franken_rect">
    Launch Virtual Modular
  </button>
</div>


<!-- Modal -->
<div class="modal fade" id="franken_rect" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="franken_rectLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header justify-content-between">
        <!-- <h5 class="modal-title" id="franken_rectLabel">Modal title</h5> -->
        <!-- To dismiss popovers when other elements are clicked, add this back in and uncomment jquery at end of template
        <button type="button" class="btn btn-secondary" title="Instructions" data-toggle="popover" data-trigger="focus" data-html="true" data-content="&lt;ul&gt;
&lt;li&gt;Delete Folding, LFO, Triggers, and 8:1&lt;/li&gt;
&lt;li&gt;Add 12 key, BoggAudio Sine, another utilities, QuadVCA/Mixer, and Bogg Audio Offset. Offset is an attenuator that will let us invert one of the waves&lt;/li&gt;
&lt;li&gt;Connect 12key CV out to WT VCO V/Oct and Sine V/Oct &lt;/li&gt;
&lt;li&gt;Set WT VCO frequency and Sine frequency to match, e.g. 200 Hz&lt;/li&gt;
&lt;li&gt;Connect WT VCO out to Sine sync. This will help us keep the phase relationship between them constant &lt;/li&gt;
&lt;li&gt;Connect the WT VCO's Utilities half rectify out to QuadVCA/Mixer input 1 &lt;/li&gt;
&lt;li&gt;Connect Sine out to the other Utilities input, and connect the half rectify out to QuadVCA/Mixer input 2&lt;/li&gt;
&lt;li&gt;Connect QuadVCA/Mixer mix out to filtah&lt;/li&gt;
&lt;li&gt;Connect filtah out to Scope in 1, Host Audio L, and Sassy input&lt;/li&gt;
&lt;li&gt;Try the following and note the differences in the sound and scopes &lt;ul&gt;
&lt;li&gt;Move the Offset scale knob to -1. This will invert the Sine signal&lt;/li&gt;
&lt;li&gt;Adjust the Sine phase offset. At 180 it should be correctly aligned&lt;/li&gt;
&lt;li&gt;Use the WT VCO position knob to change waveshapes, play the keyboard and check the scopes to see and hear the sound. Right click Sine to select non-sine waveshapes&lt;/li&gt;
&lt;/ul&gt;&lt;/li&gt;
&lt;/ul&gt;
&lt;div class='d-flex flex-row justify-content-around'&gt;
&lt;img class='rack-image' src='images/solo-modules/boggaudiooffset-solo.png'&gt;
&lt;/div&gt;
">Instructions</button>
        <button type="button" class="btn btn-secondary" title="Solution" data-toggle="popover" data-trigger="focus" data-html="true" data-content="&lt;img class='rack-image-6u' src='images/patch-solutions/franken-rect.png'&gt;">Solution</button> -->
        <!-- using a different data-toggle than 'popover' because bookdown seems to have customized popover for footnotes, etc, with a different close click behaviour -->
        <button type="button" class="btn btn-secondary" title="Instructions" data-toggle="modal-popover" data-placement="bottom" data-custom-class="modal-popover"
        data-html="true" data-content="&lt;ul&gt;
&lt;li&gt;Delete Folding, LFO, Triggers, and 8:1&lt;/li&gt;
&lt;li&gt;Add 12 key, BoggAudio Sine, another utilities, QuadVCA/Mixer, and Bogg Audio Offset. Offset is an attenuator that will let us invert one of the waves&lt;/li&gt;
&lt;li&gt;Connect 12key CV out to WT VCO V/Oct and Sine V/Oct &lt;/li&gt;
&lt;li&gt;Set WT VCO frequency and Sine frequency to match, e.g. 200 Hz&lt;/li&gt;
&lt;li&gt;Connect WT VCO out to Sine sync. This will help us keep the phase relationship between them constant &lt;/li&gt;
&lt;li&gt;Connect the WT VCO's Utilities half rectify out to QuadVCA/Mixer input 1 &lt;/li&gt;
&lt;li&gt;Connect Sine out to the other Utilities input, and connect the half rectify out to QuadVCA/Mixer input 2&lt;/li&gt;
&lt;li&gt;Connect QuadVCA/Mixer mix out to filtah&lt;/li&gt;
&lt;li&gt;Connect filtah out to Scope in 1, Host Audio L, and Sassy input&lt;/li&gt;
&lt;li&gt;Try the following and note the differences in the sound and scopes &lt;ul&gt;
&lt;li&gt;Move the Offset scale knob to -1. This will invert the Sine signal&lt;/li&gt;
&lt;li&gt;Adjust the Sine phase offset. At 180 it should be correctly aligned&lt;/li&gt;
&lt;li&gt;Use the WT VCO position knob to change waveshapes, play the keyboard and check the scopes to see and hear the sound. Right click Sine to select non-sine waveshapes&lt;/li&gt;
&lt;/ul&gt;&lt;/li&gt;
&lt;/ul&gt;
&lt;div class='d-flex flex-row justify-content-around'&gt;
&lt;img class='rack-image' src='images/solo-modules/boggaudiooffset-solo.png'&gt;
&lt;/div&gt;
">Instructions</button>
        <button type="button" class="btn btn-secondary" title="Solution" data-toggle="modal-popover" data-placement="bottom" data-custom-class="modal-popover"
        data-html="true" data-content="&lt;img class='rack-image-6u' src='images/patch-solutions/franken-rect.png'&gt;">Solution</button>
        <button type="button" onclick="setfranken_rectIframe('')" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <!-- For some reason the button type below will not play along with justify-content-between  -->
        <!-- <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button> -->
      </div>
      <div class="modal-body">
        <iframe id="franken_rect-iframe" src="" height="100%" width="100%"></iframe>
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
function setfranken_rectIframe(url){
  var franken_rectIframe = document.getElementById("franken_rect-iframe");
  franken_rectIframe.src = url;
};

// This dismisses popovers when anything else is clicked, but users probably want to refer to instructions/solution while clicking on things, so commenting it out for now
// $('.popover-dismiss').popover({
//   trigger: 'focus'
// })
</script>

```

<!-- CAPTION BLOCK -->
<div class="figure" style="margin-top: 0px;padding-top: 0px;"><p class="caption">(\#fig:franken-rect)(ref:franken-rect)</p></div>

## Slew

Slew slows the rate of change of a signal.
We've seen this before with low pass filters, where the signal being slowed was audio rate.
Slew limiters behaves much the same way as low pass filters but are designed to work with unipolar signals.
Recall RC circuits from Section \@ref(voltage-controlled-filters) leech out energy from parts of the wave shape and return that energy to other parts, thus smoothing the signal.
Slew limiters work the same way but typically have parameters to control the rate of slew for both upward and downward transitions.

Slew limiters have applications in many areas that involve delaying a signal. 
For example, we can make a gate delay by combining a slew limiter with a comparator.
When a slew limiter receives a gate, its output voltage will slowly rise depending on the rate of slew, until the voltage is high enough that the comparator sends out a high signal.
Before we look at portamento, try creating  a gate delay from a slew limiter and comparator using the button in Figure \@ref(fig:slew-gate-delay).
The second scope in the patch shows another interesting application of slew, which is to convert gates into envelopes.
If the rise time runs into the fall time, the envelope will only go up and down (attack and decay).
Shorter rise and fall times will preserve the top of the gate, making an attack-sustain-release envelope, with sustain at max level.

(ref:slew-gate-delay) [Virtual modular](https://cardinal.olney.ai) for using a slew limiter and comparator to make a gate delay and slew alone to convert a gate to an envelope.

<!-- MODAL HTML BLOCK -->

```{=html}
<!-- Button trigger modal -->
<!-- <div class="d-flex flex-column min-vh-100 justify-content-center align-items-center"> -->
<div class="d-flex flex-column justify-content-center align-items-center">
  <button type="button" style="margin-top: 20px;margin-bottom: 5px" onclick="setslew_gate_delayIframe('https://cardinal.olney.ai?patchurl=empty.vcv')" class="btn btn-primary" data-toggle="modal" data-target="#slew_gate_delay">
    Launch Virtual Modular
  </button>
</div>


<!-- Modal -->
<div class="modal fade" id="slew_gate_delay" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="slew_gate_delayLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header justify-content-between">
        <!-- <h5 class="modal-title" id="slew_gate_delayLabel">Modal title</h5> -->
        <!-- To dismiss popovers when other elements are clicked, add this back in and uncomment jquery at end of template
        <button type="button" class="btn btn-secondary" title="Instructions" data-toggle="popover" data-trigger="focus" data-html="true" data-content="&lt;ul&gt;
&lt;li&gt;Connect LFO square out to Slew in and the first Scope in 1 &lt;/li&gt;
&lt;li&gt;Connect Slew out to Edge In and the second Scope in 1&lt;/li&gt;
&lt;li&gt;Connect Edge high out to both Scope input 2 &lt;/li&gt;
&lt;li&gt;Turn on Scope trigger and adjust time so you see the slow gate&lt;/li&gt;
&lt;li&gt;Adjust the Slew rise/fall sliders to adjust. Rise affects the delay of the comparator gate, and fall affects the length of that gate&lt;/li&gt;
&lt;li&gt;Try adjusting the slew to make delayed gates at different delays and lengths&lt;/li&gt;
&lt;li&gt;As you can see, with this method we can only delay so far because we need an incoming gate for the slew to smooth. A clock divider could create an incoming signal for a longer delay &lt;/li&gt;
&lt;li&gt;Note the second scope trace for the slewed signal is identical to an envelope, i.e. slew can convert gates into simple envelopes &lt;/li&gt;
&lt;/ul&gt;&lt;/li&gt;
&lt;/ul&gt;
&lt;div class='d-flex flex-row justify-content-around'&gt;
&lt;img class='rack-image' src='images/solo-modules/befacoslew-solo.png'&gt;
&lt;/div&gt;
">Instructions</button>
        <button type="button" class="btn btn-secondary" title="Solution" data-toggle="popover" data-trigger="focus" data-html="true" data-content="&lt;img class='rack-image' src='images/patch-solutions/slew-gate-delay.png'&gt;">Solution</button> -->
        <!-- using a different data-toggle than 'popover' because bookdown seems to have customized popover for footnotes, etc, with a different close click behaviour -->
        <button type="button" class="btn btn-secondary" title="Instructions" data-toggle="modal-popover" data-placement="bottom" data-custom-class="modal-popover"
        data-html="true" data-content="&lt;ul&gt;
&lt;li&gt;Connect LFO square out to Slew in and the first Scope in 1 &lt;/li&gt;
&lt;li&gt;Connect Slew out to Edge In and the second Scope in 1&lt;/li&gt;
&lt;li&gt;Connect Edge high out to both Scope input 2 &lt;/li&gt;
&lt;li&gt;Turn on Scope trigger and adjust time so you see the slow gate&lt;/li&gt;
&lt;li&gt;Adjust the Slew rise/fall sliders to adjust. Rise affects the delay of the comparator gate, and fall affects the length of that gate&lt;/li&gt;
&lt;li&gt;Try adjusting the slew to make delayed gates at different delays and lengths&lt;/li&gt;
&lt;li&gt;As you can see, with this method we can only delay so far because we need an incoming gate for the slew to smooth. A clock divider could create an incoming signal for a longer delay &lt;/li&gt;
&lt;li&gt;Note the second scope trace for the slewed signal is identical to an envelope, i.e. slew can convert gates into simple envelopes &lt;/li&gt;
&lt;/ul&gt;&lt;/li&gt;
&lt;/ul&gt;
&lt;div class='d-flex flex-row justify-content-around'&gt;
&lt;img class='rack-image' src='images/solo-modules/befacoslew-solo.png'&gt;
&lt;/div&gt;
">Instructions</button>
        <button type="button" class="btn btn-secondary" title="Solution" data-toggle="modal-popover" data-placement="bottom" data-custom-class="modal-popover"
        data-html="true" data-content="&lt;img class='rack-image' src='images/patch-solutions/slew-gate-delay.png'&gt;">Solution</button>
        <button type="button" onclick="setslew_gate_delayIframe('')" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <!-- For some reason the button type below will not play along with justify-content-between  -->
        <!-- <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button> -->
      </div>
      <div class="modal-body">
        <iframe id="slew_gate_delay-iframe" src="" height="100%" width="100%"></iframe>
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
function setslew_gate_delayIframe(url){
  var slew_gate_delayIframe = document.getElementById("slew_gate_delay-iframe");
  slew_gate_delayIframe.src = url;
};

// This dismisses popovers when anything else is clicked, but users probably want to refer to instructions/solution while clicking on things, so commenting it out for now
// $('.popover-dismiss').popover({
//   trigger: 'focus'
// })
</script>

```

<!-- CAPTION BLOCK -->
<div class="figure" style="margin-top: 0px;padding-top: 0px;"><p class="caption">(\#fig:slew-gate-delay)(ref:slew-gate-delay)</p></div>

Perhaps the most common use of slew is to implement portamento/glissando by smoothing stepped V/Oct control signals to create glides.
If you consider V/Oct signals to be stepped like gates, then the last patch should help you understand how this works.
A slewed V/Oct signal will have a range of voltages between the steps, and these intermediate voltages will be cause a VCO receiving them to output intermediate pitches.
Most slew limiters will base the glide time on the distance between notes as well as the rise/fall settings.
This can be challenging musically, so if a constant glide time is desired, a better option is to use a low-pass filter.
Try patching up a slew limiter to a VCO to implement portamento using the button in Figure \@ref(fig:slew-portamento).

(ref:slew-portamento) [Virtual modular](https://cardinal.olney.ai) for using a slew limiter to implement portamento. 

<!-- MODAL HTML BLOCK -->

```{=html}
<!-- Button trigger modal -->
<!-- <div class="d-flex flex-column min-vh-100 justify-content-center align-items-center"> -->
<div class="d-flex flex-column justify-content-center align-items-center">
  <button type="button" style="margin-top: 20px;margin-bottom: 5px" onclick="setslew_portamentoIframe('https://cardinal.olney.ai?patchurl=empty.vcv')" class="btn btn-primary" data-toggle="modal" data-target="#slew_portamento">
    Launch Virtual Modular
  </button>
</div>


<!-- Modal -->
<div class="modal fade" id="slew_portamento" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="slew_portamentoLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header justify-content-between">
        <!-- <h5 class="modal-title" id="slew_portamentoLabel">Modal title</h5> -->
        <!-- To dismiss popovers when other elements are clicked, add this back in and uncomment jquery at end of template
        <button type="button" class="btn btn-secondary" title="Instructions" data-toggle="popover" data-trigger="focus" data-html="true" data-content="&lt;ul&gt;
&lt;li&gt;Add 12 key, Slew limiter, VCO, Host audio, and Scope &lt;/li&gt;
&lt;li&gt;Connect 12 key CV out to Slew in and Slew out to VCO V/Oct&lt;/li&gt;
&lt;li&gt;Connect VCO square out to Host audio L and Scope input 1&lt;/li&gt;
&lt;li&gt;Try the following and note the differences in the sound and scopes &lt;ul&gt;
&lt;li&gt;Play two keys close together and far apart. Note the differenct in portamento length&lt;/li&gt;
&lt;li&gt;Adjust the Slew sliders one at a time and repeat. Note the asymmetry depending on whether the note sequence is ascending or descending&lt;/li&gt;
&lt;li&gt;Change the shape knob to the right and repeat. Note the time it takes to implement the glide transition is much slower and matches the icon for that position (long attack)&lt;/li&gt;
&lt;li&gt;To get a constant time portamento, replace Slew with filtah in LPF mode with a low cutoff. The low cuttoff is essential because the voltage changes are low frequency and will be removed otherwise&lt;/li&gt;
&lt;/ul&gt;&lt;/li&gt;
&lt;/ul&gt;
">Instructions</button>
        <button type="button" class="btn btn-secondary" title="Solution" data-toggle="popover" data-trigger="focus" data-html="true" data-content="&lt;img class='rack-image' src='images/patch-solutions/slew-portamento.png'&gt;">Solution</button> -->
        <!-- using a different data-toggle than 'popover' because bookdown seems to have customized popover for footnotes, etc, with a different close click behaviour -->
        <button type="button" class="btn btn-secondary" title="Instructions" data-toggle="modal-popover" data-placement="bottom" data-custom-class="modal-popover"
        data-html="true" data-content="&lt;ul&gt;
&lt;li&gt;Add 12 key, Slew limiter, VCO, Host audio, and Scope &lt;/li&gt;
&lt;li&gt;Connect 12 key CV out to Slew in and Slew out to VCO V/Oct&lt;/li&gt;
&lt;li&gt;Connect VCO square out to Host audio L and Scope input 1&lt;/li&gt;
&lt;li&gt;Try the following and note the differences in the sound and scopes &lt;ul&gt;
&lt;li&gt;Play two keys close together and far apart. Note the differenct in portamento length&lt;/li&gt;
&lt;li&gt;Adjust the Slew sliders one at a time and repeat. Note the asymmetry depending on whether the note sequence is ascending or descending&lt;/li&gt;
&lt;li&gt;Change the shape knob to the right and repeat. Note the time it takes to implement the glide transition is much slower and matches the icon for that position (long attack)&lt;/li&gt;
&lt;li&gt;To get a constant time portamento, replace Slew with filtah in LPF mode with a low cutoff. The low cuttoff is essential because the voltage changes are low frequency and will be removed otherwise&lt;/li&gt;
&lt;/ul&gt;&lt;/li&gt;
&lt;/ul&gt;
">Instructions</button>
        <button type="button" class="btn btn-secondary" title="Solution" data-toggle="modal-popover" data-placement="bottom" data-custom-class="modal-popover"
        data-html="true" data-content="&lt;img class='rack-image' src='images/patch-solutions/slew-portamento.png'&gt;">Solution</button>
        <button type="button" onclick="setslew_portamentoIframe('')" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <!-- For some reason the button type below will not play along with justify-content-between  -->
        <!-- <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button> -->
      </div>
      <div class="modal-body">
        <iframe id="slew_portamento-iframe" src="" height="100%" width="100%"></iframe>
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
function setslew_portamentoIframe(url){
  var slew_portamentoIframe = document.getElementById("slew_portamento-iframe");
  slew_portamentoIframe.src = url;
};

// This dismisses popovers when anything else is clicked, but users probably want to refer to instructions/solution while clicking on things, so commenting it out for now
// $('.popover-dismiss').popover({
//   trigger: 'focus'
// })
</script>

```

<!-- CAPTION BLOCK -->
<div class="figure" style="margin-top: 0px;padding-top: 0px;"><p class="caption">(\#fig:slew-portamento)(ref:slew-portamento)</p></div>

Slew can also be combined with full rectification to make an envelope follower, a very useful tool for processing audio.
When we make sounds in modular, we typically apply an envelope like an ADSR in order to give the sound dynamic loudness.
We can further use the envelope to control modulation like filter cutoff, so that the spectrum of the sound changes at the same time as its loudness.
Envelopes can can be used for [sidechaining](https://en.wikipedia.org/wiki/Dynamic_range_compression#Side-chaining) effects like ducking, where the envelope on the kick is inverted and used to *reduce* the volume of other sounds, which gives the music a pulsing quality.

Sidechaining is relatively simple when an envelope was used to generate the sound, but when the sound isn't synthesized, like samples or live-recordings of instruments, an envelope follower is needed to generate the envelope that will be used for sidechaining.
An envelope follower essentially traces a curve along the peaks of a sound wave to outline an envelope akin to an ADSR.
Since ADSR envelopes are unipolar, full rectification of the audio takes place first.
Then slew is used to slow the rapid changes in the sound and generate a smoothish curve.
Some tuning of the envelope follower is typically required to create an envelope with the desired properties.
Try patching up an envelope follower using full rectification and a slew limiter using the button in Figure \@ref(fig:slew-sidechain-noise).
The audio in the patch comes from lo-fi synthesized speech with no envelope, and the patch demonstrates sidechaining to duck noise based on the followed envelope.

(ref:slew-sidechain-noise) [Virtual modular](https://cardinal.olney.ai) for using full rectification with a slew limiter to create an envelope follower. 

<!-- MODAL HTML BLOCK -->

```{=html}
<!-- Button trigger modal -->
<!-- <div class="d-flex flex-column min-vh-100 justify-content-center align-items-center"> -->
<div class="d-flex flex-column justify-content-center align-items-center">
  <button type="button" style="margin-top: 20px;margin-bottom: 5px" onclick="setslew_sidechain_noiseIframe('https://cardinal.olney.ai?patchurl=empty.vcv')" class="btn btn-primary" data-toggle="modal" data-target="#slew_sidechain_noise">
    Launch Virtual Modular
  </button>
</div>


<!-- Modal -->
<div class="modal fade" id="slew_sidechain_noise" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="slew_sidechain_noiseLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header justify-content-between">
        <!-- <h5 class="modal-title" id="slew_sidechain_noiseLabel">Modal title</h5> -->
        <!-- To dismiss popovers when other elements are clicked, add this back in and uncomment jquery at end of template
        <button type="button" class="btn btn-secondary" title="Instructions" data-toggle="popover" data-trigger="focus" data-html="true" data-content="&lt;ul&gt;
&lt;li&gt;Add LFO and Macro oscillator 2 to the top row, and add utilities Slew limiter, Offset, Noiz, QuadVCA/Mixer, Scope, and Host audio to the bottom row &lt;/li&gt;
&lt;li&gt;Press the Macro osc mode button until the bottom led is lit green. This is the voice/word mode&lt;/li&gt;
&lt;li&gt;Connect LFO triangle out to Macro osc morph in. Turn the morph attenuator all the way up and the LFO freq low, e.g. .05 &lt;/li&gt;
&lt;li&gt;Connect Macro osc out to utilities top in, QuadVCA/Mixer input 2, and Scope input 1&lt;/li&gt;
&lt;li&gt;Connect Utilities full rectify out to Slew in, Slew out to Offset in, and Offset out to QuadVCA/Mixer CV input 1&lt;/li&gt;
&lt;li&gt;Connect Noiz white out to QuadVCA/Mixer input 1. As you can see, the envelope follower is controling the level of the white noise &lt;/li&gt;
&lt;li&gt;Connect QuadVCA/Mixer mix out to Scope input 2 and Host audio L &lt;/li&gt;
&lt;li&gt;Try the following and note the differences in the sound and scopes &lt;ul&gt;
&lt;li&gt;Adjust the Slew times to the envelope. In the middle is reasonable&lt;/li&gt;
&lt;li&gt;Invert the envelope using negative scale of Offset&lt;/li&gt;
&lt;li&gt;Since the VCA CV input needs positive voltage to let signal through, use the Offset offset knob to create a constant positive voltage. The inverted envelope subtracts from this, so the net result should be zero volume when words are spoken but white noise when not&lt;/li&gt;
&lt;/ul&gt;&lt;/li&gt;
&lt;/ul&gt;
&lt;div class='d-flex flex-row justify-content-around'&gt;
&lt;img class='rack-image' src='images/solo-modules/plaits-solo.png'&gt;
&lt;/div&gt;
">Instructions</button>
        <button type="button" class="btn btn-secondary" title="Solution" data-toggle="popover" data-trigger="focus" data-html="true" data-content="&lt;img class='rack-image-6u' src='images/patch-solutions/slew-sidechain-noise.png'&gt;">Solution</button> -->
        <!-- using a different data-toggle than 'popover' because bookdown seems to have customized popover for footnotes, etc, with a different close click behaviour -->
        <button type="button" class="btn btn-secondary" title="Instructions" data-toggle="modal-popover" data-placement="bottom" data-custom-class="modal-popover"
        data-html="true" data-content="&lt;ul&gt;
&lt;li&gt;Add LFO and Macro oscillator 2 to the top row, and add utilities Slew limiter, Offset, Noiz, QuadVCA/Mixer, Scope, and Host audio to the bottom row &lt;/li&gt;
&lt;li&gt;Press the Macro osc mode button until the bottom led is lit green. This is the voice/word mode&lt;/li&gt;
&lt;li&gt;Connect LFO triangle out to Macro osc morph in. Turn the morph attenuator all the way up and the LFO freq low, e.g. .05 &lt;/li&gt;
&lt;li&gt;Connect Macro osc out to utilities top in, QuadVCA/Mixer input 2, and Scope input 1&lt;/li&gt;
&lt;li&gt;Connect Utilities full rectify out to Slew in, Slew out to Offset in, and Offset out to QuadVCA/Mixer CV input 1&lt;/li&gt;
&lt;li&gt;Connect Noiz white out to QuadVCA/Mixer input 1. As you can see, the envelope follower is controling the level of the white noise &lt;/li&gt;
&lt;li&gt;Connect QuadVCA/Mixer mix out to Scope input 2 and Host audio L &lt;/li&gt;
&lt;li&gt;Try the following and note the differences in the sound and scopes &lt;ul&gt;
&lt;li&gt;Adjust the Slew times to the envelope. In the middle is reasonable&lt;/li&gt;
&lt;li&gt;Invert the envelope using negative scale of Offset&lt;/li&gt;
&lt;li&gt;Since the VCA CV input needs positive voltage to let signal through, use the Offset offset knob to create a constant positive voltage. The inverted envelope subtracts from this, so the net result should be zero volume when words are spoken but white noise when not&lt;/li&gt;
&lt;/ul&gt;&lt;/li&gt;
&lt;/ul&gt;
&lt;div class='d-flex flex-row justify-content-around'&gt;
&lt;img class='rack-image' src='images/solo-modules/plaits-solo.png'&gt;
&lt;/div&gt;
">Instructions</button>
        <button type="button" class="btn btn-secondary" title="Solution" data-toggle="modal-popover" data-placement="bottom" data-custom-class="modal-popover"
        data-html="true" data-content="&lt;img class='rack-image-6u' src='images/patch-solutions/slew-sidechain-noise.png'&gt;">Solution</button>
        <button type="button" onclick="setslew_sidechain_noiseIframe('')" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <!-- For some reason the button type below will not play along with justify-content-between  -->
        <!-- <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button> -->
      </div>
      <div class="modal-body">
        <iframe id="slew_sidechain_noise-iframe" src="" height="100%" width="100%"></iframe>
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
function setslew_sidechain_noiseIframe(url){
  var slew_sidechain_noiseIframe = document.getElementById("slew_sidechain_noise-iframe");
  slew_sidechain_noiseIframe.src = url;
};

// This dismisses popovers when anything else is clicked, but users probably want to refer to instructions/solution while clicking on things, so commenting it out for now
// $('.popover-dismiss').popover({
//   trigger: 'focus'
// })
</script>

```

<!-- CAPTION BLOCK -->
<div class="figure" style="margin-top: 0px;padding-top: 0px;"><p class="caption">(\#fig:slew-sidechain-noise)(ref:slew-sidechain-noise)</p></div>


## Quantizers

A [quantizer](https://en.wikipedia.org/wiki/Quantization_(signal_processing)) maps input values to a smaller set of outputs.
We discussed quantization in Section \@ref(samplers) in the context of bit depth, where the height of a sound wave is approximately measured in order to convert it from analogue to digital.
In music, quantization is typically used to refer to either beat quantization or note quantization.
Beat quantization is often relevant when performing live into a sequencer.
If the sequencer is grid-based, any played beat will be snapped to the grid, i.e. snapped to the beat.
In modular, note quantization is the more commonly used, and note quantization maps a voltage range to a particular note.
Modular quantizers typically allow scales to be selected to determine what notes are available. 

Perhaps the easiest way to understand quantizers is through voltage controlled sequencers.
Recall that sequencers are typically clocked and advance one step at a time.
A voltage controlled sequencer will select the step based on the incoming voltage.
So when a voltage within a range corresponding to the step is received, that step will be selected, and whatever voltage was there will be output.
Quantizers perform the same function except that the output notes are determined by the scale rather than being assigned.

Despite this similarity, quantizers are often used after modular sequencers to make them easier to tune.
If a quantizer is used on the output of a sequencer, adjustment to a sequencer knob will step from one note to the next rather than move through all frequencies in between.
Also, if the quantizer has scale selection, then it will affect all notes in the sequence simultaneously, which can be very convenient.
However, it's important to keep in mind that a quantizer's voltage for a note, e.g. C4, may not make your oscillator go to the same note.
To ensure your oscillator's output matches a quantizer, you must tune your oscillator so they match. 
Try patching up a quantizer both ways using the button in Figure \@ref(fig:cv-sequencer-quantizer-plus-quantizer): first using a voltage controlled sequencer and then as a modifier on a sequencer's output.

(ref:cv-sequencer-quantizer-plus-quantizer) [Virtual modular](https://cardinal.olney.ai) for implementing a quantizer using a voltage controlled sequencer and using a quantizer module to process the output of a sequencer. 

<!-- MODAL HTML BLOCK -->

```{=html}
<!-- Button trigger modal -->
<!-- <div class="d-flex flex-column min-vh-100 justify-content-center align-items-center"> -->
<div class="d-flex flex-column justify-content-center align-items-center">
  <button type="button" style="margin-top: 20px;margin-bottom: 5px" onclick="setcv_sequencer_quantizer_plus_quantizerIframe('https://cardinal.olney.ai?patchurl=st-seq-arp-plus-dynamics.vcv')" class="btn btn-primary" data-toggle="modal" data-target="#cv_sequencer_quantizer_plus_quantizer">
    Launch Virtual Modular
  </button>
</div>


<!-- Modal -->
<div class="modal fade" id="cv_sequencer_quantizer_plus_quantizer" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="cv_sequencer_quantizer_plus_quantizerLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header justify-content-between">
        <!-- <h5 class="modal-title" id="cv_sequencer_quantizer_plus_quantizerLabel">Modal title</h5> -->
        <!-- To dismiss popovers when other elements are clicked, add this back in and uncomment jquery at end of template
        <button type="button" class="btn btn-secondary" title="Instructions" data-toggle="popover" data-trigger="focus" data-html="true" data-content="
&lt;em&gt;Quantizing an LFO signal into sequenced notes&lt;/em&gt;
&lt;ul&gt;
&lt;li&gt;We'll modify the Stranger Things patch to avoid programming specific pitches into the sequencer &lt;/li&gt;
&lt;li&gt;Add an LFO to the left of the Clock&lt;/li&gt;
&lt;li&gt;Disconnect the Clock beat from the ADDR-SEQ Clock input&lt;/li&gt;
&lt;li&gt;Connect the LFO triangle out to the ADDR-SEQ CV in and set the LFO to a low rate, e.g. .1 Hz&lt;/li&gt;
&lt;li&gt;The sequence should move up and down with the LFO. If it is not starting on step 1, connect Clock reset out to the reset ins for LFO and ADDR-SEQ, then hit the button to reset and synchronize them&lt;/li&gt;
&lt;/ul&gt;
&lt;em&gt;Cleaning up sequencer output with a quantizer&lt;/em&gt;
&lt;ul&gt;
&lt;li&gt;Add JW Quantizer to the right of ADDR-SEQ&lt;/li&gt;
&lt;li&gt;Move all connects from ADDR-SEQ out to JW Quantizer out and connect ADDR-SEQ out to Quantizer in&lt;/li&gt;
&lt;li&gt;Change the root note knob, mode knob, and octave shift knob to see how easy it is do do these manipulations with a quantizer to affect all the notes at once&lt;/li&gt;
&lt;li&gt;Disconnect the LFO so the sequence stops on a single step Turn the knob for that step and notice how it now goes from note to note instead of continuous frequencies - that is the essence of quantization &lt;/li&gt;
&lt;/ul&gt;
&lt;div class='d-flex flex-row justify-content-around'&gt;
&lt;img class='rack-image' src='images/solo-modules/jwquantizer-solo.png'&gt;
&lt;/div&gt;
">Instructions</button>
        <button type="button" class="btn btn-secondary" title="Solution" data-toggle="popover" data-trigger="focus" data-html="true" data-content="&lt;img class='rack-image-6u' src='images/patch-solutions/cv-sequencer-quantizer-plus-quantizer.png'&gt;">Solution</button> -->
        <!-- using a different data-toggle than 'popover' because bookdown seems to have customized popover for footnotes, etc, with a different close click behaviour -->
        <button type="button" class="btn btn-secondary" title="Instructions" data-toggle="modal-popover" data-placement="bottom" data-custom-class="modal-popover"
        data-html="true" data-content="
&lt;em&gt;Quantizing an LFO signal into sequenced notes&lt;/em&gt;
&lt;ul&gt;
&lt;li&gt;We'll modify the Stranger Things patch to avoid programming specific pitches into the sequencer &lt;/li&gt;
&lt;li&gt;Add an LFO to the left of the Clock&lt;/li&gt;
&lt;li&gt;Disconnect the Clock beat from the ADDR-SEQ Clock input&lt;/li&gt;
&lt;li&gt;Connect the LFO triangle out to the ADDR-SEQ CV in and set the LFO to a low rate, e.g. .1 Hz&lt;/li&gt;
&lt;li&gt;The sequence should move up and down with the LFO. If it is not starting on step 1, connect Clock reset out to the reset ins for LFO and ADDR-SEQ, then hit the button to reset and synchronize them&lt;/li&gt;
&lt;/ul&gt;
&lt;em&gt;Cleaning up sequencer output with a quantizer&lt;/em&gt;
&lt;ul&gt;
&lt;li&gt;Add JW Quantizer to the right of ADDR-SEQ&lt;/li&gt;
&lt;li&gt;Move all connects from ADDR-SEQ out to JW Quantizer out and connect ADDR-SEQ out to Quantizer in&lt;/li&gt;
&lt;li&gt;Change the root note knob, mode knob, and octave shift knob to see how easy it is do do these manipulations with a quantizer to affect all the notes at once&lt;/li&gt;
&lt;li&gt;Disconnect the LFO so the sequence stops on a single step Turn the knob for that step and notice how it now goes from note to note instead of continuous frequencies - that is the essence of quantization &lt;/li&gt;
&lt;/ul&gt;
&lt;div class='d-flex flex-row justify-content-around'&gt;
&lt;img class='rack-image' src='images/solo-modules/jwquantizer-solo.png'&gt;
&lt;/div&gt;
">Instructions</button>
        <button type="button" class="btn btn-secondary" title="Solution" data-toggle="modal-popover" data-placement="bottom" data-custom-class="modal-popover"
        data-html="true" data-content="&lt;img class='rack-image-6u' src='images/patch-solutions/cv-sequencer-quantizer-plus-quantizer.png'&gt;">Solution</button>
        <button type="button" onclick="setcv_sequencer_quantizer_plus_quantizerIframe('')" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <!-- For some reason the button type below will not play along with justify-content-between  -->
        <!-- <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button> -->
      </div>
      <div class="modal-body">
        <iframe id="cv_sequencer_quantizer_plus_quantizer-iframe" src="" height="100%" width="100%"></iframe>
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
function setcv_sequencer_quantizer_plus_quantizerIframe(url){
  var cv_sequencer_quantizer_plus_quantizerIframe = document.getElementById("cv_sequencer_quantizer_plus_quantizer-iframe");
  cv_sequencer_quantizer_plus_quantizerIframe.src = url;
};

// This dismisses popovers when anything else is clicked, but users probably want to refer to instructions/solution while clicking on things, so commenting it out for now
// $('.popover-dismiss').popover({
//   trigger: 'focus'
// })
</script>

```

<!-- CAPTION BLOCK -->
<div class="figure" style="margin-top: 0px;padding-top: 0px;"><p class="caption">(\#fig:cv-sequencer-quantizer-plus-quantizer)(ref:cv-sequencer-quantizer-plus-quantizer)</p></div>

The last patch used a sequencer to store notes, but it's also possible to use a quantizer without a sequencer.
Particularly for arpeggios, its easy enough to use LFOs that cycle up and down.
All that is needed is a sample and hold module to synchronize the pitches to gates, and an attenuator to restrict the range of the LFO to the range of notes desired.
The relationships between LFO frequency, LFO range, gate/trigger frequency, and gate/trigger synchronization are illustrated in Figure \@ref(fig:sine-quantize-figure).
If sampling occurs at the same frequency as the LFO, then it will always select the same note.
To get more notes, the sampling needs to occur at a higher frequency.

(ref:sine-quantize-figure) A sine wave LFO (purple) being sampled (green) so the sampled values can be input to a quantizer to create an arpeggio. If the sampling rate matches the LFO frequency, only one repeating note will be sampled (left). The samplng rate must be higher than the LFO rate (right) to increase the number of notes. See text for additional factors that effect what voltages are sampled.

<div class="figure">
<img src="images/sine-quantize-figure.png" alt="(ref:sine-quantize-figure)" width="100%" />
<p class="caption">(\#fig:sine-quantize-figure)(ref:sine-quantize-figure)</p>
</div>

If the sample and hold is clocked with another LFO whose frequency is not a multiple of the quantized LFO, then the arpeggio will slowly shift its played notes over a longer period. 
Try patching up an LFO quantizer arpeggio using the button in Figure \@ref(fig:lfo-quantizer-arpeggio).
Other ways of creating variations are to change the range of the LFO, the offset of the LFO, the sampling rate, and the sampling phase/synchronization to the LFO.

(ref:lfo-quantizer-arpeggio) [Virtual modular](https://cardinal.olney.ai) for creating an arpeggio using an LFO through a quantizer. 

<!-- MODAL HTML BLOCK -->

```{=html}
<!-- Button trigger modal -->
<!-- <div class="d-flex flex-column min-vh-100 justify-content-center align-items-center"> -->
<div class="d-flex flex-column justify-content-center align-items-center">
  <button type="button" style="margin-top: 20px;margin-bottom: 5px" onclick="setlfo_quantizer_arpeggioIframe('https://cardinal.olney.ai?patchurl=twelvekey-env-chorus.vcv')" class="btn btn-primary" data-toggle="modal" data-target="#lfo_quantizer_arpeggio">
    Launch Virtual Modular
  </button>
</div>


<!-- Modal -->
<div class="modal fade" id="lfo_quantizer_arpeggio" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="lfo_quantizer_arpeggioLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header justify-content-between">
        <!-- <h5 class="modal-title" id="lfo_quantizer_arpeggioLabel">Modal title</h5> -->
        <!-- To dismiss popovers when other elements are clicked, add this back in and uncomment jquery at end of template
        <button type="button" class="btn btn-secondary" title="Instructions" data-toggle="popover" data-trigger="focus" data-html="true" data-content="&lt;ul&gt;
&lt;li&gt;Add two LFOs, Bogg Audio Offset, holdah, and Quantizer&lt;/li&gt;
&lt;li&gt;Connect the 2nd LFO (the 'sequencer') triangle out Offset in and set the LFO to a low rate, e.g. .4 Hz&lt;/li&gt;
&lt;li&gt;Connect Offset out to holdah in&lt;/li&gt;
&lt;li&gt;Connect holdah out to Quantizer in&lt;/li&gt;
&lt;li&gt;Connect Quantizer out to VCO V/Oct&lt;/li&gt;
&lt;li&gt;Connect first LFO (the 'clock') square out to holdah trigger in and ADSR gate in. Set it to a higher rate, e.g. 2 or 3 Hz&lt;/li&gt;
&lt;li&gt;Try the following and note the differences in the sound &lt;ul&gt;
&lt;li&gt;Adjust the Offset scale to a small number, e.g. .15 to define how many notes are in the sweep of the sequencer LFO&lt;/li&gt;
&lt;li&gt;Adjust the frequencies of the clock LFO. The higher it is, the more notes will be selected from the sequencer LFO's sweep&lt;/li&gt;
&lt;li&gt;Adjust the frequencies of the sequencer LFO. The slower it is, the more opportunities the clock LFO will have to select notes before the sequencer LFO changes direction&lt;/li&gt;
&lt;/ul&gt;&lt;/li&gt;
&lt;/ul&gt;
&lt;div class='d-flex flex-row justify-content-around'&gt;
&lt;img class='rack-image' src='images/solo-modules/boggaudiooffset-solo.png'&gt;
&lt;/div&gt;
">Instructions</button>
        <button type="button" class="btn btn-secondary" title="Solution" data-toggle="popover" data-trigger="focus" data-html="true" data-content="&lt;img class='rack-image' src='images/patch-solutions/lfo-quantizer-arpeggio.png'&gt;">Solution</button> -->
        <!-- using a different data-toggle than 'popover' because bookdown seems to have customized popover for footnotes, etc, with a different close click behaviour -->
        <button type="button" class="btn btn-secondary" title="Instructions" data-toggle="modal-popover" data-placement="bottom" data-custom-class="modal-popover"
        data-html="true" data-content="&lt;ul&gt;
&lt;li&gt;Add two LFOs, Bogg Audio Offset, holdah, and Quantizer&lt;/li&gt;
&lt;li&gt;Connect the 2nd LFO (the 'sequencer') triangle out Offset in and set the LFO to a low rate, e.g. .4 Hz&lt;/li&gt;
&lt;li&gt;Connect Offset out to holdah in&lt;/li&gt;
&lt;li&gt;Connect holdah out to Quantizer in&lt;/li&gt;
&lt;li&gt;Connect Quantizer out to VCO V/Oct&lt;/li&gt;
&lt;li&gt;Connect first LFO (the 'clock') square out to holdah trigger in and ADSR gate in. Set it to a higher rate, e.g. 2 or 3 Hz&lt;/li&gt;
&lt;li&gt;Try the following and note the differences in the sound &lt;ul&gt;
&lt;li&gt;Adjust the Offset scale to a small number, e.g. .15 to define how many notes are in the sweep of the sequencer LFO&lt;/li&gt;
&lt;li&gt;Adjust the frequencies of the clock LFO. The higher it is, the more notes will be selected from the sequencer LFO's sweep&lt;/li&gt;
&lt;li&gt;Adjust the frequencies of the sequencer LFO. The slower it is, the more opportunities the clock LFO will have to select notes before the sequencer LFO changes direction&lt;/li&gt;
&lt;/ul&gt;&lt;/li&gt;
&lt;/ul&gt;
&lt;div class='d-flex flex-row justify-content-around'&gt;
&lt;img class='rack-image' src='images/solo-modules/boggaudiooffset-solo.png'&gt;
&lt;/div&gt;
">Instructions</button>
        <button type="button" class="btn btn-secondary" title="Solution" data-toggle="modal-popover" data-placement="bottom" data-custom-class="modal-popover"
        data-html="true" data-content="&lt;img class='rack-image' src='images/patch-solutions/lfo-quantizer-arpeggio.png'&gt;">Solution</button>
        <button type="button" onclick="setlfo_quantizer_arpeggioIframe('')" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <!-- For some reason the button type below will not play along with justify-content-between  -->
        <!-- <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button> -->
      </div>
      <div class="modal-body">
        <iframe id="lfo_quantizer_arpeggio-iframe" src="" height="100%" width="100%"></iframe>
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
function setlfo_quantizer_arpeggioIframe(url){
  var lfo_quantizer_arpeggioIframe = document.getElementById("lfo_quantizer_arpeggio-iframe");
  lfo_quantizer_arpeggioIframe.src = url;
};

// This dismisses popovers when anything else is clicked, but users probably want to refer to instructions/solution while clicking on things, so commenting it out for now
// $('.popover-dismiss').popover({
//   trigger: 'focus'
// })
</script>

```

<!-- CAPTION BLOCK -->
<div class="figure" style="margin-top: 0px;padding-top: 0px;"><p class="caption">(\#fig:lfo-quantizer-arpeggio)(ref:lfo-quantizer-arpeggio)</p></div>

Another common application for quantizers is in generative patches where probability is used to generate voltages which are then turned into notes.
We can incorporate probability into the last patch using almost the same modules but connected a different way.
Try patching up a probability-based generative patch using sample and hold on noise through a quantizer and speed variable clocks for different note lengths using the button in Figure \@ref(fig:sh-quantizer-generative).

(ref:sh-quantizer-generative) [Virtual modular](https://cardinal.olney.ai) for creating an generative melody using sample and hold on noise through a quantizer. 

<!-- MODAL HTML BLOCK -->

```{=html}
<!-- Button trigger modal -->
<!-- <div class="d-flex flex-column min-vh-100 justify-content-center align-items-center"> -->
<div class="d-flex flex-column justify-content-center align-items-center">
  <button type="button" style="margin-top: 20px;margin-bottom: 5px" onclick="setsh_quantizer_generativeIframe('https://cardinal.olney.ai?patchurl=lfo-quantizer-arpeggio.vcv')" class="btn btn-primary" data-toggle="modal" data-target="#sh_quantizer_generative">
    Launch Virtual Modular
  </button>
</div>


<!-- Modal -->
<div class="modal fade" id="sh_quantizer_generative" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="sh_quantizer_generativeLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header justify-content-between">
        <!-- <h5 class="modal-title" id="sh_quantizer_generativeLabel">Modal title</h5> -->
        <!-- To dismiss popovers when other elements are clicked, add this back in and uncomment jquery at end of template
        <button type="button" class="btn btn-secondary" title="Instructions" data-toggle="popover" data-trigger="focus" data-html="true" data-content="&lt;ul&gt;
&lt;li&gt;Add Utilities and delete holdah and 12 key. The bottom section of Utilities has an integrated noise source and sample and hold, so we can use it to generate random stepped voltage&lt;/li&gt;
&lt;li&gt;Connect the 2nd LFO (the 'clock') square out to Utilities S&amp;H in&lt;/li&gt;
&lt;li&gt;Connect Utilities out to offset in&lt;/li&gt;
&lt;li&gt;Connect offset out out to Quantizer in&lt;/li&gt;
&lt;li&gt;Connect 1st LFO triangle out to the FM in of the clock LFO&lt;/li&gt;
&lt;li&gt;Try the following and note the differences in the sound &lt;ul&gt;
&lt;li&gt;Adjust the Offset scale to a small number, e.g. .15 to define how many notes are in the sweep of the sequencer LFO&lt;/li&gt;
&lt;li&gt;Adjust the frequencies of the clock LFO. The higher it is, the more notes will be selected from the sample and hold&lt;/li&gt;
&lt;li&gt;Adjust the frequencies of the first LFO and the FM attenuator of the clock LFO. The faster the first LFO is, the faster the note durations will change. The stronger the attenuated signal is, the more the first LFO will influence the speed of the clock. You might want the first LFO to be bipolar for this&lt;/li&gt;
&lt;/ul&gt;&lt;/li&gt;
&lt;/ul&gt;
">Instructions</button>
        <button type="button" class="btn btn-secondary" title="Solution" data-toggle="popover" data-trigger="focus" data-html="true" data-content="&lt;img class='rack-image' src='images/patch-solutions/sh-quantizer-generative.png'&gt;">Solution</button> -->
        <!-- using a different data-toggle than 'popover' because bookdown seems to have customized popover for footnotes, etc, with a different close click behaviour -->
        <button type="button" class="btn btn-secondary" title="Instructions" data-toggle="modal-popover" data-placement="bottom" data-custom-class="modal-popover"
        data-html="true" data-content="&lt;ul&gt;
&lt;li&gt;Add Utilities and delete holdah and 12 key. The bottom section of Utilities has an integrated noise source and sample and hold, so we can use it to generate random stepped voltage&lt;/li&gt;
&lt;li&gt;Connect the 2nd LFO (the 'clock') square out to Utilities S&amp;H in&lt;/li&gt;
&lt;li&gt;Connect Utilities out to offset in&lt;/li&gt;
&lt;li&gt;Connect offset out out to Quantizer in&lt;/li&gt;
&lt;li&gt;Connect 1st LFO triangle out to the FM in of the clock LFO&lt;/li&gt;
&lt;li&gt;Try the following and note the differences in the sound &lt;ul&gt;
&lt;li&gt;Adjust the Offset scale to a small number, e.g. .15 to define how many notes are in the sweep of the sequencer LFO&lt;/li&gt;
&lt;li&gt;Adjust the frequencies of the clock LFO. The higher it is, the more notes will be selected from the sample and hold&lt;/li&gt;
&lt;li&gt;Adjust the frequencies of the first LFO and the FM attenuator of the clock LFO. The faster the first LFO is, the faster the note durations will change. The stronger the attenuated signal is, the more the first LFO will influence the speed of the clock. You might want the first LFO to be bipolar for this&lt;/li&gt;
&lt;/ul&gt;&lt;/li&gt;
&lt;/ul&gt;
">Instructions</button>
        <button type="button" class="btn btn-secondary" title="Solution" data-toggle="modal-popover" data-placement="bottom" data-custom-class="modal-popover"
        data-html="true" data-content="&lt;img class='rack-image' src='images/patch-solutions/sh-quantizer-generative.png'&gt;">Solution</button>
        <button type="button" onclick="setsh_quantizer_generativeIframe('')" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <!-- For some reason the button type below will not play along with justify-content-between  -->
        <!-- <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button> -->
      </div>
      <div class="modal-body">
        <iframe id="sh_quantizer_generative-iframe" src="" height="100%" width="100%"></iframe>
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
function setsh_quantizer_generativeIframe(url){
  var sh_quantizer_generativeIframe = document.getElementById("sh_quantizer_generative-iframe");
  sh_quantizer_generativeIframe.src = url;
};

// This dismisses popovers when anything else is clicked, but users probably want to refer to instructions/solution while clicking on things, so commenting it out for now
// $('.popover-dismiss').popover({
//   trigger: 'focus'
// })
</script>

```

<!-- CAPTION BLOCK -->
<div class="figure" style="margin-top: 0px;padding-top: 0px;"><p class="caption">(\#fig:sh-quantizer-generative)(ref:sh-quantizer-generative)</p></div>

