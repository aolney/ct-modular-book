# Modulating Modifiers {#complex-modifiers}

Modifying incoming audio and control signals was introduced in Chapter \@ref(modifiers).
The present chapter introduces new modules and extends earlier concepts in modifiers around the loose organizing theme of converting between earlier signals, e.g. from gates to envelopes.

## Rectification, wavefolding, and composition

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

(ref:wavefold-rect-example) [Virtual modular](https://olney.ai/ct-modular-book/modular-for-pdf.html?starter=empty.vcv&solution=%3cimg+class%3d%27rack-image%27+src%3d%27images%2fpatch-solutions%2fwavefold-rect-example.png%27%3e&instructions=%3cul%3e%0a%3cli%3eAdd+WT+VCO%2c+Utilites%2c+Folding%2c+LFO%2c+Triggers+MKIII%2c+8%3a1%2c+filtah%2c+Scope%2c+Host+audio%2c+and+Sassy%3c%2fli%3e%0a%3cli%3eConnect+WT+VCO+out+to+Utilities+in%2c+Folding+in%2c+8%3a1+input+1%2c+Scope+input+2%2c+and+Scope+trigger+in%3c%2fli%3e%0a%3cli%3eConnect+Utilities+half+rectify+out+to+8%3a1+input+3+and+full+rectify+out+to+8%3a1+input+4%3c%2fli%3e%0a%3cli%3eConnect+LFO+triangle+out+to+Folding+depth+in+and+change+the+depth+attenuverter+%28the+small+knob%29+to+9+o%27clock%2c+a+slight+amount%3c%2fli%3e%0a%3cli%3eConnect+Folding+out+to+8%3a1+input+2%3c%2fli%3e%0a%3cli%3eConnect+Triggers+MKIII+out+to+8%3a1+clock%3c%2fli%3e%0a%3cli%3eSet+8%3a1+steps+to+4+and+connect+out+to+filtah+input%3c%2fli%3e%0a%3cli%3eSet+filtah+type+switch+to+high+pass+and+cutoff+to+the+lowest+level+%28lets+everything+above+zero+frequency+through%29and+connect+filtah+out+to+Scope+in+1%3c%2fli%3e%0a%3cli%3eConnect+Scope+out+1+to+Host+audio+L+and+Sassy+input+1%3c%2fli%3e%0a%3cli%3eAdjust+Scope+time+and+Sassy+levels+and+FFT+resolution+to+the+highest+level%3c%2fli%3e%0a%3cli%3eRun+the+patch+and+observe+the+following%3cul%3e%0a%3cli%3eStarting+with+sine%2c+cycle+through+the+4+wave+options+using+the+button+and+note+the+change+in+sound%2c+the+image+on+the+scope%2c+and+the+change+in+harmonics.+Mouse+over+the+harmonics+to+check+if+they+are+all%2c+odd%2c+or+even.+You+may+prefer+to+set+the+WT+VCO+frequency+to+a+round+number%2c+e.g.+200+Hz%2c+and+set+the+LFO+to+a+slow+rate%2c+e.g.+.2+Hz+in+order+to+make+comparisons+easier%3c%2fli%3e%0a%3cli%3eRepeat+the+above+for+the+other+three+waveshapes%3c%2fli%3e%0a%3c%2ful%3e%3c%2fli%3e%0a%3c%2ful%3e%0a%3cdiv+class%3d%27d-flex+flex-row+justify-content-around%27%3e%0a%3cimg+class%3d%27rack-image%27+src%3d%27images%2fsolo-modules%2faudibleutilities-solo.png%27%3e%0a%3cimg+class%3d%27rack-image%27+src%3d%27images%2fsolo-modules%2fanimatedfolding-solo.png%27%3e%0a%3cimg+class%3d%27rack-image%27+src%3d%27images%2fsolo-modules%2ffiltah-solo.png%27%3e%0a%3c%2fdiv%3e%0a) for contrasting the effect of wavefolding and rectification on the four basic waveshapes. 

<!-- MODAL HTML BLOCK -->


<!-- CAPTION BLOCK -->
<div class="figure">
<img src="images/launch-virtual-modular-button.png" alt="(ref:wavefold-rect-example)" width="100%" />
<p class="caption">(\#fig:wavefold-rect-example)(ref:wavefold-rect-example)</p>
</div>

Rectification has multiple uses besides changing harmonics.
One obvious use is making a bipolar control signal unipolar (e.g. to drive a VCA).
Another interesting use is to use rectification to create composite waveshapes by combining the top part of one waveshape with the bottom of another.
This is relatively simple to do by fully rectifying two waveshapes and inverting one to become the bottom portion of the wave.
It's slightly trickier to align the top and bottom portions, but it's possible to do so using a module that allows specification of phase offsets.
Figure \@ref(fig:fraken-rect) shows an example of waveshape composition using the top portion of a sine wave and the bottom portion of a square wave.
By blending parts of different waves, you can achieve an intermediate sound, e.g. a slightly more mellow square wave.

(ref:fraken-rect) Upper sine wave and lower square wave portions cut using rectification and aligned with a phase offset (left). The final wave is high pass filtered to remove the voltage offset (right).

<div class="figure">
<img src="images/fraken-rect.png" alt="(ref:fraken-rect)" width="100%" />
<p class="caption">(\#fig:fraken-rect)(ref:fraken-rect)</p>
</div>

Try creating a new waveshape through rectification using the button in Figure \@ref(fig:franken-rect).
This method would also allow you to perform operations on just one part of the signal if desired, e.g. waveshaping on just the top half.

(ref:franken-rect) [Virtual modular](https://olney.ai/ct-modular-book/modular-for-pdf.html?starter=wavefold-rect-example.vcv&solution=%3cimg+class%3d%27rack-image-6u%27+src%3d%27images%2fpatch-solutions%2ffranken-rect.png%27%3e&instructions=%3cul%3e%0a%3cli%3eDelete+Folding%2c+LFO%2c+Triggers%2c+and+8%3a1%3c%2fli%3e%0a%3cli%3eAdd+12+key%2c+BoggAudio+Sine%2c+another+utilities%2c+QuadVCA%2fMixer%2c+and+Bogg+Audio+Offset.+Offset+is+an+attenuator+that+will+let+us+invert+one+of+the+waves%3c%2fli%3e%0a%3cli%3eConnect+12key+CV+out+to+WT+VCO+V%2fOct+and+Sine+V%2fOct+%3c%2fli%3e%0a%3cli%3eSet+WT+VCO+frequency+and+Sine+frequency+to+match%2c+e.g.+200+Hz%3c%2fli%3e%0a%3cli%3eConnect+WT+VCO+out+to+Sine+sync.+This+will+help+us+keep+the+phase+relationship+between+them+constant+%3c%2fli%3e%0a%3cli%3eConnect+the+WT+VCO%27s+Utilities+half+rectify+out+to+QuadVCA%2fMixer+input+1+%3c%2fli%3e%0a%3cli%3eConnect+Sine+out+to+the+other+Utilities+input%2c+and+connect+the+half+rectify+out+to+QuadVCA%2fMixer+input+2%3c%2fli%3e%0a%3cli%3eConnect+QuadVCA%2fMixer+mix+out+to+filtah%3c%2fli%3e%0a%3cli%3eConnect+filtah+out+to+Scope+in+1%2c+Host+Audio+L%2c+and+Sassy+input%3c%2fli%3e%0a%3cli%3eTry+the+following+and+note+the+differences+in+the+sound+and+scopes+%3cul%3e%0a%3cli%3eMove+the+Offset+scale+knob+to+-1.+This+will+invert+the+Sine+signal%3c%2fli%3e%0a%3cli%3eAdjust+the+Sine+phase+offset.+At+180+it+should+be+correctly+aligned%3c%2fli%3e%0a%3cli%3eUse+the+WT+VCO+position+knob+to+change+waveshapes%2c+play+the+keyboard+and+check+the+scopes+to+see+and+hear+the+sound.+Right+click+Sine+to+select+non-sine+waveshapes%3c%2fli%3e%0a%3c%2ful%3e%3c%2fli%3e%0a%3c%2ful%3e%0a%3cdiv+class%3d%27d-flex+flex-row+justify-content-around%27%3e%0a%3cimg+class%3d%27rack-image%27+src%3d%27images%2fsolo-modules%2fboggaudiooffset-solo.png%27%3e%0a%3c%2fdiv%3e%0a) for contrasting the effect of wavefolding and rectification on the four basic waveshapes. 

<!-- MODAL HTML BLOCK -->


<!-- CAPTION BLOCK -->
<div class="figure">
<img src="images/launch-virtual-modular-button.png" alt="(ref:franken-rect)" width="100%" />
<p class="caption">(\#fig:franken-rect)(ref:franken-rect)</p>
</div>

A simpler way to perform waveshape composition is to use analog logic.
In analog logic, AND is the maximum of two inputs, and OR is the minimum of two inputs.
Figure \@ref(fig:minmax-compare) shows an example of applying the minimum to the two waveshapes from above.
The way to understand the operation is to follow the wave from left to right and at each point ask which wave is the lower of the two (i.e. is the minimum). 
Sine is below the square wave for the positive portion of the wave, but in the negative portion of the wave, square is lower.
Note for this example, sync was still required to maintain the relative position of the two waves to each other, but manipulating phase was not necessary.
The maximum operation proceeds similarly to the minimum operation, except the maximum of the two waves is output at each point.
The min/max operations are a simpler way to compose than the rectification approach above, but the trade off is that there is somewhat less control over what part of the waveshape is used.

(ref:minmax-compare) Sine and square waves with matched frequency and synchronized (left). The output wave from the minimum operation is high pass filtered to remove the voltage offset (right).

<div class="figure">
<img src="images/minmax-compare.png" alt="(ref:minmax-compare)" width="100%" />
<p class="caption">(\#fig:minmax-compare)(ref:minmax-compare)</p>
</div>

Explore waveshape composition with min/max operators using the button in Figure \@ref(fig:minmax).
As in the previous patch, sync between the waveshapes and high pass filtering are useful for maintaining a consistent result across pitches and removing voltage offsets, respectively.

(ref:minmax) [Virtual modular](https://olney.ai/ct-modular-book/modular-for-pdf.html?starter=franken-rect.vcv&solution=%3cimg+class%3d%27rack-image-6u%27+src%3d%27images%2fpatch-solutions%2fminmax.png%27%3e&instructions=%3cul%3e%0a%3cli%3eDelete+the+second+Utilities%2c+Offset%2c+and+QuadVCA%2fMixer%3c%2fli%3e%0a%3cli%3eConnect+WT+VCO+out+to+Utilities+logic+in+A+%3c%2fli%3e%0a%3cli%3eConnect+Sine+out+to+Utilities+logic+in+B+%3c%2fli%3e%0a%3cli%3eConnect+Utilities+min+out+to+filtah%3c%2fli%3e%0a%3cli%3eSet+the+phase+on+Sine+to+zero+%28double+click+to+reset+it%29%3c%2fli%3e%0a%3cli%3eTry+the+following+and+note+the+differences+in+the+sound+and+scopes+%3cul%3e%0a%3cli%3ePlay+across+the+keyboard+and+note+the+consistent+shape+resulting+from+the+sync+between+oscillators%3c%2fli%3e%0a%3cli%3eUse+the+WT+VCO+position+knob+to+change+waveshapes%2c+play+the+keyboard+and+check+the+scopes+to+see+and+hear+the+sound.+Because+Sine+is+set+to+square%2c+which+is+the+most+minimum+shape%2c+only+the+top+of+the+waveshape+will+be+affected%3c%2fli%3e%0a%3cli%3eSwitch+the+Utilities+output+to+max+and+repeat.+Again%2c+square+is+the+most+maximum+waveshape%2c+only+the+bottom+will+change%3c%2fli%3e%0a%3cli%3eChange+the+Sine+waveshape+to+sine+%28right+click%2c+waveform+submenu%29.+Repeat+the+above+and+note+that+now+both+top+and+bottom+change.+This+is+the+general+behavior+of+min%2fmax+-+they+typically+affect+the+entire+waveshape%3c%2fli%3e%0a%3c%2ful%3e%3c%2fli%3e%0a%3c%2ful%3e%0a) for composing waveshapes using min/max operations. 

<!-- MODAL HTML BLOCK -->


<!-- CAPTION BLOCK -->
<div class="figure">
<img src="images/launch-virtual-modular-button.png" alt="(ref:minmax)" width="100%" />
<p class="caption">(\#fig:minmax)(ref:minmax)</p>
</div>


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

(ref:slew-gate-delay) [Virtual modular](https://olney.ai/ct-modular-book/modular-for-pdf.html?starter=empty.vcv&solution=%3cimg+class%3d%27rack-image%27+src%3d%27images%2fpatch-solutions%2fslew-gate-delay.png%27%3e&instructions=%3cul%3e%0a%3cli%3eConnect+LFO+square+out+to+Slew+in+and+the+first+Scope+in+1+%3c%2fli%3e%0a%3cli%3eConnect+Slew+out+to+Edge+In+and+the+second+Scope+in+1%3c%2fli%3e%0a%3cli%3eConnect+Edge+high+out+to+both+Scope+input+2+%3c%2fli%3e%0a%3cli%3eTurn+on+Scope+trigger+and+adjust+time+so+you+see+the+slow+gate%3c%2fli%3e%0a%3cli%3eAdjust+the+Slew+rise%2ffall+sliders+to+adjust.+Rise+affects+the+delay+of+the+comparator+gate%2c+and+fall+affects+the+length+of+that+gate%3c%2fli%3e%0a%3cli%3eTry+adjusting+the+slew+to+make+delayed+gates+at+different+delays+and+lengths%3c%2fli%3e%0a%3cli%3eAs+you+can+see%2c+with+this+method+we+can+only+delay+so+far+because+we+need+an+incoming+gate+for+the+slew+to+smooth.+A+clock+divider+could+create+an+incoming+signal+for+a+longer+delay+%3c%2fli%3e%0a%3cli%3eNote+the+second+scope+trace+for+the+slewed+signal+is+identical+to+an+envelope%2c+i.e.+slew+can+convert+gates+into+simple+envelopes+%3c%2fli%3e%0a%3c%2ful%3e%3c%2fli%3e%0a%3c%2ful%3e%0a%3cdiv+class%3d%27d-flex+flex-row+justify-content-around%27%3e%0a%3cimg+class%3d%27rack-image%27+src%3d%27images%2fsolo-modules%2fbefacoslew-solo.png%27%3e%0a%3c%2fdiv%3e%0a) for using a slew limiter and comparator to make a gate delay and slew alone to convert a gate to an envelope.

<!-- MODAL HTML BLOCK -->


<!-- CAPTION BLOCK -->
<div class="figure">
<img src="images/launch-virtual-modular-button.png" alt="(ref:slew-gate-delay)" width="100%" />
<p class="caption">(\#fig:slew-gate-delay)(ref:slew-gate-delay)</p>
</div>

Perhaps the most common use of slew is to implement portamento/glissando by smoothing stepped V/Oct control signals to create glides.
If you consider V/Oct signals to be stepped like gates, then the last patch should help you understand how this works.
A slewed V/Oct signal will have a range of voltages between the steps, and these intermediate voltages will be cause a VCO receiving them to output intermediate pitches.
Most slew limiters will base the glide time on the distance between notes as well as the rise/fall settings.
This can be challenging musically, so if a constant glide time is desired, a better option is to use a low-pass filter.
Try patching up a slew limiter to a VCO to implement portamento using the button in Figure \@ref(fig:slew-portamento).

(ref:slew-portamento) [Virtual modular](https://olney.ai/ct-modular-book/modular-for-pdf.html?starter=empty.vcv&solution=%3cimg+class%3d%27rack-image%27+src%3d%27images%2fpatch-solutions%2fslew-portamento.png%27%3e&instructions=%3cul%3e%0a%3cli%3eAdd+12+key%2c+Slew+limiter%2c+VCO%2c+Host+audio%2c+and+Scope+%3c%2fli%3e%0a%3cli%3eConnect+12+key+CV+out+to+Slew+in+and+Slew+out+to+VCO+V%2fOct%3c%2fli%3e%0a%3cli%3eConnect+VCO+square+out+to+Host+audio+L+and+Scope+input+1%3c%2fli%3e%0a%3cli%3eTry+the+following+and+note+the+differences+in+the+sound+and+scopes+%3cul%3e%0a%3cli%3ePlay+two+keys+close+together+and+far+apart.+Note+the+differenct+in+portamento+length%3c%2fli%3e%0a%3cli%3eAdjust+the+Slew+sliders+one+at+a+time+and+repeat.+Note+the+asymmetry+depending+on+whether+the+note+sequence+is+ascending+or+descending%3c%2fli%3e%0a%3cli%3eChange+the+shape+knob+to+the+right+and+repeat.+Note+the+time+it+takes+to+implement+the+glide+transition+is+much+slower+and+matches+the+icon+for+that+position+%28long+attack%29%3c%2fli%3e%0a%3cli%3eTo+get+a+constant+time+portamento%2c+replace+Slew+with+filtah+in+LPF+mode+with+a+low+cutoff.+The+low+cuttoff+is+essential+because+the+voltage+changes+are+low+frequency+and+will+be+removed+otherwise%3c%2fli%3e%0a%3c%2ful%3e%3c%2fli%3e%0a%3c%2ful%3e%0a) for using a slew limiter to implement portamento. 

<!-- MODAL HTML BLOCK -->


<!-- CAPTION BLOCK -->
<div class="figure">
<img src="images/launch-virtual-modular-button.png" alt="(ref:slew-portamento)" width="100%" />
<p class="caption">(\#fig:slew-portamento)(ref:slew-portamento)</p>
</div>

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

(ref:slew-sidechain-noise) [Virtual modular](https://olney.ai/ct-modular-book/modular-for-pdf.html?starter=empty.vcv&solution=%3cimg+class%3d%27rack-image-6u%27+src%3d%27images%2fpatch-solutions%2fslew-sidechain-noise.png%27%3e&instructions=%3cul%3e%0a%3cli%3eAdd+LFO+and+Macro+oscillator+2+to+the+top+row%2c+and+add+utilities+Slew+limiter%2c+Offset%2c+Noiz%2c+QuadVCA%2fMixer%2c+Scope%2c+and+Host+audio+to+the+bottom+row+%3c%2fli%3e%0a%3cli%3ePress+the+Macro+osc+mode+button+until+the+bottom+led+is+lit+green.+This+is+the+voice%2fword+mode%3c%2fli%3e%0a%3cli%3eConnect+LFO+triangle+out+to+Macro+osc+morph+in.+Turn+the+morph+attenuator+all+the+way+up+and+the+LFO+freq+low%2c+e.g.+.05+%3c%2fli%3e%0a%3cli%3eConnect+Macro+osc+out+to+utilities+top+in%2c+QuadVCA%2fMixer+input+2%2c+and+Scope+input+1%3c%2fli%3e%0a%3cli%3eConnect+Utilities+full+rectify+out+to+Slew+in%2c+Slew+out+to+Offset+in%2c+and+Offset+out+to+QuadVCA%2fMixer+CV+input+1%3c%2fli%3e%0a%3cli%3eConnect+Noiz+white+out+to+QuadVCA%2fMixer+input+1.+As+you+can+see%2c+the+envelope+follower+is+controling+the+level+of+the+white+noise+%3c%2fli%3e%0a%3cli%3eConnect+QuadVCA%2fMixer+mix+out+to+Scope+input+2+and+Host+audio+L+%3c%2fli%3e%0a%3cli%3eTry+the+following+and+note+the+differences+in+the+sound+and+scopes+%3cul%3e%0a%3cli%3eAdjust+the+Slew+times+to+the+envelope.+In+the+middle+is+reasonable%3c%2fli%3e%0a%3cli%3eInvert+the+envelope+using+negative+scale+of+Offset%3c%2fli%3e%0a%3cli%3eSince+the+VCA+CV+input+needs+positive+voltage+to+let+signal+through%2c+use+the+Offset+offset+knob+to+create+a+constant+positive+voltage.+The+inverted+envelope+subtracts+from+this%2c+so+the+net+result+should+be+zero+volume+when+words+are+spoken+but+white+noise+when+not%3c%2fli%3e%0a%3c%2ful%3e%3c%2fli%3e%0a%3c%2ful%3e%0a%3cdiv+class%3d%27d-flex+flex-row+justify-content-around%27%3e%0a%3cimg+class%3d%27rack-image%27+src%3d%27images%2fsolo-modules%2fplaits-solo.png%27%3e%0a%3c%2fdiv%3e%0a) for using full rectification with a slew limiter to create an envelope follower. 

<!-- MODAL HTML BLOCK -->


<!-- CAPTION BLOCK -->
<div class="figure">
<img src="images/launch-virtual-modular-button.png" alt="(ref:slew-sidechain-noise)" width="100%" />
<p class="caption">(\#fig:slew-sidechain-noise)(ref:slew-sidechain-noise)</p>
</div>


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

(ref:cv-sequencer-quantizer-plus-quantizer) [Virtual modular](https://olney.ai/ct-modular-book/modular-for-pdf.html?starter=st-seq-arp-plus-dynamics.vcv&solution=%3cimg+class%3d%27rack-image-6u%27+src%3d%27images%2fpatch-solutions%2fcv-sequencer-quantizer-plus-quantizer.png%27%3e&instructions=%0a%3cem%3eQuantizing+an+LFO+signal+into+sequenced+notes%3c%2fem%3e%0a%3cul%3e%0a%3cli%3eWe%27ll+modify+the+Stranger+Things+patch+to+avoid+programming+specific+pitches+into+the+sequencer+%3c%2fli%3e%0a%3cli%3eAdd+an+LFO+to+the+left+of+the+Clock%3c%2fli%3e%0a%3cli%3eDisconnect+the+Clock+beat+from+the+ADDR-SEQ+Clock+input%3c%2fli%3e%0a%3cli%3eConnect+the+LFO+triangle+out+to+the+ADDR-SEQ+CV+in+and+set+the+LFO+to+a+low+rate%2c+e.g.+.1+Hz%3c%2fli%3e%0a%3cli%3eThe+sequence+should+move+up+and+down+with+the+LFO.+If+it+is+not+starting+on+step+1%2c+connect+Clock+reset+out+to+the+reset+ins+for+LFO+and+ADDR-SEQ%2c+then+hit+the+button+to+reset+and+synchronize+them%3c%2fli%3e%0a%3c%2ful%3e%0a%3cem%3eCleaning+up+sequencer+output+with+a+quantizer%3c%2fem%3e%0a%3cul%3e%0a%3cli%3eAdd+JW+Quantizer+to+the+right+of+ADDR-SEQ%3c%2fli%3e%0a%3cli%3eMove+all+connects+from+ADDR-SEQ+out+to+JW+Quantizer+out+and+connect+ADDR-SEQ+out+to+Quantizer+in%3c%2fli%3e%0a%3cli%3eChange+the+root+note+knob%2c+mode+knob%2c+and+octave+shift+knob+to+see+how+easy+it+is+do+do+these+manipulations+with+a+quantizer+to+affect+all+the+notes+at+once%3c%2fli%3e%0a%3cli%3eDisconnect+the+LFO+so+the+sequence+stops+on+a+single+step+Turn+the+knob+for+that+step+and+notice+how+it+now+goes+from+note+to+note+instead+of+continuous+frequencies+-+that+is+the+essence+of+quantization+%3c%2fli%3e%0a%3c%2ful%3e%0a%3cdiv+class%3d%27d-flex+flex-row+justify-content-around%27%3e%0a%3cimg+class%3d%27rack-image%27+src%3d%27images%2fsolo-modules%2fjwquantizer-solo.png%27%3e%0a%3c%2fdiv%3e%0a) for implementing a quantizer using a voltage controlled sequencer and using a quantizer module to process the output of a sequencer. 

<!-- MODAL HTML BLOCK -->


<!-- CAPTION BLOCK -->
<div class="figure">
<img src="images/launch-virtual-modular-button.png" alt="(ref:cv-sequencer-quantizer-plus-quantizer)" width="100%" />
<p class="caption">(\#fig:cv-sequencer-quantizer-plus-quantizer)(ref:cv-sequencer-quantizer-plus-quantizer)</p>
</div>

The last patch used a sequencer to store notes, but it's also possible to use a quantizer without a sequencer.
Particularly for arpeggios, its easy enough to use LFOs that cycle up and down.
All that is needed is a sample and hold module to synchronize the pitches to gates, and an attenuator to restrict the range of the LFO to the range of notes desired.
The relationships between LFO frequency, LFO range, gate/trigger frequency, and gate/trigger synchronization are illustrated in Figure \@ref(fig:sine-quantize-figure).
If sampling occurs at the same frequency as the LFO, then it will always select the same note.
To get more notes, the sampling needs to occur at a higher frequency.

(ref:sine-quantize-figure) A sine wave LFO (purple) being sampled (green) so the sampled values can be input to a quantizer to create an arpeggio. If the sampling rate matches the LFO frequency, only one repeating note will be sampled (left). The sampling rate must be higher than the LFO rate (right) to increase the number of notes. See text for additional factors that effect what voltages are sampled.

<div class="figure">
<img src="images/sine-quantize-figure.png" alt="(ref:sine-quantize-figure)" width="100%" />
<p class="caption">(\#fig:sine-quantize-figure)(ref:sine-quantize-figure)</p>
</div>

If the sample and hold is clocked with another LFO whose frequency is not a multiple of the quantized LFO, then the arpeggio will slowly shift its played notes over a longer period. 
Try patching up an LFO quantizer arpeggio using the button in Figure \@ref(fig:lfo-quantizer-arpeggio).
Other ways of creating variations are to change the range of the LFO, the offset of the LFO, the sampling rate, and the sampling phase/synchronization to the LFO.

(ref:lfo-quantizer-arpeggio) [Virtual modular](https://olney.ai/ct-modular-book/modular-for-pdf.html?starter=twelvekey-env-chorus.vcv&solution=%3cimg+class%3d%27rack-image%27+src%3d%27images%2fpatch-solutions%2flfo-quantizer-arpeggio.png%27%3e&instructions=%3cul%3e%0a%3cli%3eAdd+two+LFOs%2c+Bogg+Audio+Offset%2c+holdah%2c+and+Quantizer%3c%2fli%3e%0a%3cli%3eConnect+the+2nd+LFO+%28the+%27sequencer%27%29+triangle+out+Offset+in+and+set+the+LFO+to+a+low+rate%2c+e.g.+.4+Hz%3c%2fli%3e%0a%3cli%3eConnect+Offset+out+to+holdah+in%3c%2fli%3e%0a%3cli%3eConnect+holdah+out+to+Quantizer+in%3c%2fli%3e%0a%3cli%3eConnect+Quantizer+out+to+VCO+V%2fOct%3c%2fli%3e%0a%3cli%3eConnect+first+LFO+%28the+%27clock%27%29+square+out+to+holdah+trigger+in+and+ADSR+gate+in.+Set+it+to+a+higher+rate%2c+e.g.+2+or+3+Hz%3c%2fli%3e%0a%3cli%3eTry+the+following+and+note+the+differences+in+the+sound+%3cul%3e%0a%3cli%3eAdjust+the+Offset+scale+to+a+small+number%2c+e.g.+.15+to+define+how+many+notes+are+in+the+sweep+of+the+sequencer+LFO%3c%2fli%3e%0a%3cli%3eAdjust+the+frequencies+of+the+clock+LFO.+The+higher+it+is%2c+the+more+notes+will+be+selected+from+the+sequencer+LFO%27s+sweep%3c%2fli%3e%0a%3cli%3eAdjust+the+frequencies+of+the+sequencer+LFO.+The+slower+it+is%2c+the+more+opportunities+the+clock+LFO+will+have+to+select+notes+before+the+sequencer+LFO+changes+direction%3c%2fli%3e%0a%3c%2ful%3e%3c%2fli%3e%0a%3c%2ful%3e%0a%3cdiv+class%3d%27d-flex+flex-row+justify-content-around%27%3e%0a%3cimg+class%3d%27rack-image%27+src%3d%27images%2fsolo-modules%2fboggaudiooffset-solo.png%27%3e%0a%3c%2fdiv%3e%0a) for creating an arpeggio using an LFO through a quantizer. 

<!-- MODAL HTML BLOCK -->


<!-- CAPTION BLOCK -->
<div class="figure">
<img src="images/launch-virtual-modular-button.png" alt="(ref:lfo-quantizer-arpeggio)" width="100%" />
<p class="caption">(\#fig:lfo-quantizer-arpeggio)(ref:lfo-quantizer-arpeggio)</p>
</div>

Another common application for quantizers is in generative patches where probability is used to generate voltages which are then turned into notes.
We can incorporate probability into the last patch using almost the same modules but connected a different way.
Try patching up a probability-based generative patch using sample and hold on noise through a quantizer and speed variable clocks for different note lengths using the button in Figure \@ref(fig:sh-quantizer-generative).

(ref:sh-quantizer-generative) [Virtual modular](https://olney.ai/ct-modular-book/modular-for-pdf.html?starter=lfo-quantizer-arpeggio.vcv&solution=%3cimg+class%3d%27rack-image%27+src%3d%27images%2fpatch-solutions%2fsh-quantizer-generative.png%27%3e&instructions=%3cul%3e%0a%3cli%3eAdd+Utilities+and+delete+holdah+and+12+key.+The+bottom+section+of+Utilities+has+an+integrated+noise+source+and+sample+and+hold%2c+so+we+can+use+it+to+generate+random+stepped+voltage%3c%2fli%3e%0a%3cli%3eConnect+the+2nd+LFO+%28the+%27clock%27%29+square+out+to+Utilities+S%26H+in%3c%2fli%3e%0a%3cli%3eConnect+Utilities+out+to+offset+in%3c%2fli%3e%0a%3cli%3eConnect+offset+out+out+to+Quantizer+in%3c%2fli%3e%0a%3cli%3eConnect+1st+LFO+triangle+out+to+the+FM+in+of+the+clock+LFO%3c%2fli%3e%0a%3cli%3eTry+the+following+and+note+the+differences+in+the+sound+%3cul%3e%0a%3cli%3eAdjust+the+Offset+scale+to+a+small+number%2c+e.g.+.15+to+define+how+many+notes+are+in+the+sweep+of+the+sequencer+LFO%3c%2fli%3e%0a%3cli%3eAdjust+the+frequencies+of+the+clock+LFO.+The+higher+it+is%2c+the+more+notes+will+be+selected+from+the+sample+and+hold%3c%2fli%3e%0a%3cli%3eAdjust+the+frequencies+of+the+first+LFO+and+the+FM+attenuator+of+the+clock+LFO.+The+faster+the+first+LFO+is%2c+the+faster+the+note+durations+will+change.+The+stronger+the+attenuated+signal+is%2c+the+more+the+first+LFO+will+influence+the+speed+of+the+clock.+You+might+want+the+first+LFO+to+be+bipolar+for+this%3c%2fli%3e%0a%3c%2ful%3e%3c%2fli%3e%0a%3c%2ful%3e%0a) for creating an generative melody using sample and hold on noise through a quantizer. 

<!-- MODAL HTML BLOCK -->


<!-- CAPTION BLOCK -->
<div class="figure">
<img src="images/launch-virtual-modular-button.png" alt="(ref:sh-quantizer-generative)" width="100%" />
<p class="caption">(\#fig:sh-quantizer-generative)(ref:sh-quantizer-generative)</p>
</div>

## Check your understanding

1. For which kind of modulation is rectification useful?
- amplitude modulation
- phase modulation
- ring modulation
- frequency modulation
            
2. Which basic waveshape becomes offset voltage under full rectification?
- saw
- square
- triangle
- sine
            
3. Slew slows the rate of change of a signal like what kind of filter?
- all pass
- band pass
- high pass
- low pass
            
4. Which of the following can't be done with slew?
- quantization
- creating an envelope follower
- converting gates to envelopes
- portamento
            
5. When creating an arpeggio with a quantizer and an LFO, what other module is essential?
- sample and hold
- sequencer
- comparator
- slew
