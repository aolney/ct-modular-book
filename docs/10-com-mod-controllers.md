# (PART) Complex Modules {-}

# Controllers {#complex-controllers}

This chapter extends Chapter \@ref(controllers) by introducing more advanced approaches to sequencing.
Sequencing can be considered a kind of memory for musical events where the events can be stored and played back later.
Obviously there are gaps between events because not all notes (or beats) play at once.
This leads to the idea that sequencing involves both [positive space and negative space](https://en.wikipedia.org/wiki/Figure%E2%80%93ground_(perception)): positive space where musical events occur and negative space elsewhere.

This idea of positive and negative space can be seen clearly in step based sequencers that allow steps without events, such as the trigger sequencers discussed in Chapter \@ref(controllers).
However, a step-based conceptualization of sequencing leads to a limitation that a step should represent the smallest duration event, and such fine granularity naturally leads to more steps being empty.
An event-based conceptualization that flexibly represents the start and end of each event, in contrast,  has less need to explicitly define negative space.
For example, consider a sequence with two notes, the first lasting 2 units, followed by 4 units of silence, followed by the second note lasting 1 unit.
A step-based representation would use 7 steps and four of them would be empty.
An event-based representation would use two events, one starting at time 1 and lasting 2 units and one starting at time 6 and lasting 1 unit.

In practice, modular sequencing often combines both step-based and event-based elements.
The reason for combining both is that each has different strengths.
To better appreciate these strengths, let's define three ideal properties of a sequencing approach and use it to evaluate alternatives.
An ideal sequencing approach should allow:

- Compact representation of variations, i.e. in a minimal amount of space
- Ease of changes between variations
- Precise control of variations

It turns out that sometimes these properties are at odds with each other, such that different combinations of modules can outperform on some and underperform on others.
As we examine different options in this chapter, we'll keep this properties in mind.

## Modifying gates

One of the limitations of pure clock-based sequencing is that every gate starts [on the beat](https://en.wikipedia.org/wiki/Beat_(music)#On-beat_and_off-beat).
Unfortunately, [syncopation](https://en.wikipedia.org/wiki/Syncopation), which emphasizes off beats, is widespread in modern music.
The on-beat property of clock divisions is illustrated in Figure \@ref(fig:clock-div2-div4).
If we consider the clock to represent quarter notes, then the gaps between clock gates are eighth note off beats, i.e. if we count 1-and 2-and 3-and 4-and, the off beats are 'and'.

(ref:clock-div2-div4) Four gates from a clock (small) overlaid with two gates from a /2 clock division (medium) and further overlaid by one gate from a /4 clock division (large). If we consider each clock gate as defining a quarter note, then all three gates occur on the first quarter note and the first two occur on the third quarter note, so the three gates are aligning only on beats.  

<div class="figure">
<img src="images/clock-div2-div4.png" alt="(ref:clock-div2-div4)" width="100%" />
<p class="caption">(\#fig:clock-div2-div4)(ref:clock-div2-div4)</p>
</div>

Let's build a basic patch with clock divisions that illustrates this on beat property both in sound and visually on the scope.
To keep things simple throughout this chapter, we will modify this percussion-oriented patch and note differences with sequencing pitches.
All the modules and concepts in this patch were introduced in previous chapters, except for a new three-voice percussion module that can produce various sounds.
Try patching up this basic percussion patch with clock divisions using the button in Figure \@ref(fig:clock-division-drums-mschack).

(ref:clock-division-drums-mschack) [Virtual modular](https://cardinal.olney.ai) for a basic percussion patch using clock divisions.

<!-- MODAL HTML BLOCK -->


<!-- CAPTION BLOCK -->
<div class="figure">
<img src="images/launch-virtual-modular-button.png" alt="(ref:clock-division-drums-mschack)" width="100%" />
<p class="caption">(\#fig:clock-division-drums-mschack)(ref:clock-division-drums-mschack)</p>
</div>

In light of the ideal properties for sequencing, the basic clock division approach allows both compact representation in terms of divisions and ease of changing between variations by changing divisions.
However it lacks precise control because off beats are inaccessible.
Other related complications include increasing the number of hits on a particular beat, sometimes called a [roll](https://en.wikipedia.org/wiki/Drum_rudiment#Roll_rudiments) and skipping a beat.
All three of these variations can be approached by modifying existing gates, a concept that was first introduced in Section \@ref(sequencing-note-duration) for sequencing note duration.
Since sequencing note duration is identical to sequencing gate duration, we'll look at only the other two techniques here.

Hitting an off beat can be accomplished using a gate delay module.
A gate delay module receives an incoming gate (sometimes a trigger) and then create another gate at some time delay.
If the time delay corresponds to the length of a beat, then the delayed gate will appear on the off beat.
Try extending the last patch with a gate delay to move the open hat to the off beat using the button in Figure \@ref(fig:clock-division-drums-mschack-offbeat-gate-delay).

(ref:clock-division-drums-mschack-offbeat-gate-delay) [Virtual modular](https://cardinal.olney.ai) for a percussion patch using clock divisions and a gate delay to hit an off beat.

<!-- MODAL HTML BLOCK -->


<!-- CAPTION BLOCK -->
<div class="figure">
<img src="images/launch-virtual-modular-button.png" alt="(ref:clock-division-drums-mschack-offbeat-gate-delay)" width="100%" />
<p class="caption">(\#fig:clock-division-drums-mschack-offbeat-gate-delay)(ref:clock-division-drums-mschack-offbeat-gate-delay)</p>
</div>

With respect to the three ideal properties, the delayed gate approach (combined with clock divisions) is still compact, a bit less easy (because setting the delay is a bit fiddly), and more flexible, though the offset is the same for each clock or clock division.
Thus if we want variations of off beat or rolls, we need additional tools.

Drum rolls can be accomplished using a gate multiplier.
Gate multipliers will generally need a control voltage telling them how many gates to make, which correspond to the number of hits in the roll.
Thus an additional sequencer is needed to supply this control voltage.
Try extending the last patch with a gate multiplier and associate sequencer to give the kick a double hit on the first beat using the button in Figure \@ref(fig:clock-division-mshack-drums-offbeat-gate-delay-roll-seq-gate-mult).
Because the kick time is 4:4, the sequencer only needs four steps.

(ref:clock-division-mshack-drums-offbeat-gate-delay-roll-seq-gate-mult) [Virtual modular](https://cardinal.olney.ai) for a percussion patch using clock divisions, a delayed gate for an off beat hit, and a sequenced gate multiplier for multiple hits on the beat.

<!-- MODAL HTML BLOCK -->


<!-- CAPTION BLOCK -->
<div class="figure">
<img src="images/launch-virtual-modular-button.png" alt="(ref:clock-division-mshack-drums-offbeat-gate-delay-roll-seq-gate-mult)" width="100%" />
<p class="caption">(\#fig:clock-division-mshack-drums-offbeat-gate-delay-roll-seq-gate-mult)(ref:clock-division-mshack-drums-offbeat-gate-delay-roll-seq-gate-mult)</p>
</div>

Returning to the three ideal properties, the gate multiplier approach (again combined with clock divisions) is a bit compact because it relies on another sequencer, a bit less easy (because setting the multiplier voltage is a bit fiddly), and more flexible because it allows different drum rolls on each step.
Just as a sequencer was used for this patch, a sequencer could be used to control the gate delay offset of the previous patch or drop a step by sequencing the length parameter, as shown [here](images/patch-solutions/clock-division-mshack-drums-offbeat-gate-delay-roll-seq-gate-mult-skip-seq-gate-length.png).

It's clear that adding more sequencers to control these parameters increases flexibility but also makes the overall control less compact and changing between variations less easy.
For example, if one wanted to replace a skipped step with a triple beat, one would have to adjust the length sequencer for a non-zero gate length, then adjust the multiplier sequencer to create multiple hits on that step.
Is this suboptimal?
Let's compare against other solutions before making judgment.
One obvious alternative is to create the same pattern using standard step sequencers without any clock divisions.
Try updating the last patch with a step sequencer for the off beat hat and the double beat kick using the button in Figure \@ref(fig:trg-mshack-drums-offbeat-roll).
Because the kick time is 4:4, the sequencer only needs four steps.

(ref:trg-mshack-drums-offbeat-roll) [Virtual modular](https://cardinal.olney.ai) for a percussion patch using step sequencers for an off beat hit and multiple hits on the beat.

<!-- MODAL HTML BLOCK -->


<!-- CAPTION BLOCK -->
<div class="figure">
<img src="images/launch-virtual-modular-button.png" alt="(ref:trg-mshack-drums-offbeat-roll)" width="100%" />
<p class="caption">(\#fig:trg-mshack-drums-offbeat-roll)(ref:trg-mshack-drums-offbeat-roll)</p>
</div>

Contrast this approach with what we've done so far.
The step sequencers are somewhat compact if the pattern can be decomposed into the smallest repeating loops, though not as compact as a clock divider.
They are easy to change in some ways but not others. 
For example, if we decide we want a triple hit on a beat rather than a double, we need to increase the step resolution from two steps per quarter note to three steps per quarter note, which requires changing the entire kick pattern.
Conversely, step sequencers have a high level of precision *if* one accepts increasing the number of steps arbitrarily to account for off beats, [swing](https://en.wikipedia.org/wiki/Swing_(jazz_performance_style)), or [dilla](https://en.wikipedia.org/wiki/J_Dilla#Musical_style), but this then sacrifices compactness.
Note that the previous approaches with gate delays and multiplications achieved these results to an arbitrary degree without additional loss of compactness, i.e. we could have a 10 hits instead of 2 with the same gate multiplier patch.

## Making gates with logic

Suppose we wanted to select the offbeats in our current pattern.
Looking at Figure \@ref(fig:clock-div2-div4), the ofbeats are simply where the the beats are *not*.
So if we had a way of specifying "not beat," then we'd be able make a gate for the off beats.
[Boolean logic](https://en.wikipedia.org/wiki/Boolean_algebra) provides a way of specifying "not beat" and can further be used for more complex beat specifications.

Although it may seem intimidating at first, Boolean logic has just three basic operators, AND, OR, and NOT.
AND means two things happen together, OR means at least one thing happens, and NOT means something didn't happen.
If we represent something happening (like a gate) as 1 and not happening as 0, then these basic operators are summarized in Table \@ref(tab:logic).


Table: (\#tab:logic) Basic boolean logic operators on signals S1 and S2. Note that AND and OR consider both signals but NOT considers only one or the other.



| S1 | S2 | AND(S1,S2) | OR(S1,S2)| NOT(S1) | NOT(S2) |
|:---:|:----:|:----:|:----:|:--------:|:--------:|
| 1  | 1  | 1 | 1  | 0      | 0      |
| 1  | 0  | 0 | 1  | 0      | 1      |
| 0  | 1  | 0 | 1  | 1      | 0      |
| 0  | 0  | 0 | 0  | 1      | 1      |

Try updating the basic percussion patch with a NOT module to put the open hat on every off beat using the button in Figure \@ref(fig:trg-mshack-drums-offbeat-roll).
We'll build on this logic in the following patches.

(ref:clock-division-drums-mschack-offbeat-logic-every-offbeat) [Virtual modular](https://cardinal.olney.ai) for a percussion patch using clock divisions and the NOT operator to create gates for all off beat hits.

<!-- MODAL HTML BLOCK -->


<!-- CAPTION BLOCK -->
<div class="figure">
<img src="images/launch-virtual-modular-button.png" alt="(ref:clock-division-drums-mschack-offbeat-logic-every-offbeat)" width="100%" />
<p class="caption">(\#fig:clock-division-drums-mschack-offbeat-logic-every-offbeat)(ref:clock-division-drums-mschack-offbeat-logic-every-offbeat)</p>
</div>

We can use logic to create other gates using combinations of the basic operators.
For example, consider every other offbeat in Figure \@ref(fig:clock-div2-div4).
These offbeats occur when the clock is not present and the /2 division is present.
Try updating the last patch with an AND module to implement this logic using the button in Figure \@ref(fig:clock-division-drums-mschack-offbeat-logic-every-other-offbeat).

(ref:clock-division-drums-mschack-offbeat-logic-every-other-offbeat) [Virtual modular](https://cardinal.olney.ai) for a percussion patch using clock divisions and combining the NOT and AND operators to create gates for every other off beat hits.

<!-- MODAL HTML BLOCK -->


<!-- CAPTION BLOCK -->
<div class="figure">
<img src="images/launch-virtual-modular-button.png" alt="(ref:clock-division-drums-mschack-offbeat-logic-every-other-offbeat)" width="100%" />
<p class="caption">(\#fig:clock-division-drums-mschack-offbeat-logic-every-other-offbeat)(ref:clock-division-drums-mschack-offbeat-logic-every-other-offbeat)</p>
</div>

Let's get even more specific with logic to match what we did previously with the gate delay, which was a single off beat.
Since the last patch used every other off beat, we can use an additional operator to select just one of those beats.
Again looking at Figure \@ref(fig:clock-div2-div4), we see that we can achieve this by using AND with our existing logic and next larger clock division.
Try updating the last patch to implement this logic using the button in Figure \@ref(fig:clock-division-drums-mschack-offbeat-logic-matching-gate-delay).

(ref:clock-division-drums-mschack-offbeat-logic-matching-gate-delay) [Virtual modular](https://cardinal.olney.ai) for a percussion patch using clock divisions and combining the NOT and AND operators to create a single gate per bar, matching the previous delayed gate behavior.

<!-- MODAL HTML BLOCK -->


<!-- CAPTION BLOCK -->
<div class="figure">
<img src="images/launch-virtual-modular-button.png" alt="(ref:clock-division-drums-mschack-offbeat-logic-matching-gate-delay)" width="100%" />
<p class="caption">(\#fig:clock-division-drums-mschack-offbeat-logic-matching-gate-delay)(ref:clock-division-drums-mschack-offbeat-logic-matching-gate-delay)</p>
</div>

Let's consider the three ideal sequencer properties, in terms of logic.
The first application of NOT was quite compact, ease to change, and precise.
However, as the logic became more complex, the sequencing became less easy.
Contrast the last logic patch that needed three or four logical operators to what was previously accomplished by using a single gate delay.
It appears that clock divisions with logic are most suited to regular repeating patterns, and that when patterns become less regular, other options may be easier.

## Adding/removing gates with probability

Generally speaking, the more complex sequencing we want (i.e. irreducible to a simple pattern), the less compact our control will be.
We can get around this limitation if we give up precise control of the sequencing by turning to probability.
A [probability](https://en.wikipedia.org/wiki/Probability) specifies of the likelihood of an event, like a gate.
In our current approaches, a gate either happens or it doesn't.
However, if we assign some probability to a gate happening, more complex patterns emerge because sometimes the gate will happen and sometimes it won't.

Perhaps the easiest way to think about probabilistic gates is to think of them like coin flips.
If we flip a coin and get a head, then the gate will be produced, otherwise no gate will be produced.
How can we simulate a coin flip in modular?
One way is to generate a random voltage and then compare it to a reference value.
If the voltage is above the reference value, we count it as a head and produce a gate.
We've already seen how to create random voltages with noise generators.
The new idea here is a comparator, which is a module that accepts an incoming voltage $V$, compares it to a reference voltage $R$, and produces a high signal if $V > R$.^[This approach is chosen for pedagogical reasons. Various modules offer built-in random number generation that is more flexible than combining noise sources with comparators.]
Because different noise spectra have different distributions of frequencies (and thus voltages), different noise spectra will give us different probabilities for the same reference voltage.

We can use the probabilistic gate idea to sequence all the percussion voices in our ongoing example.
Since probabilistic gates would be completely random by definition, we'll structure them a bit using logic: a NOT to make two different voices alternate and an AND to combine two different noise signals for a lower probability.
Try updating the last patch to drive all gates with probability and logic using the button in Figure \@ref(fig:noise-comparator-logic-mshack-drums).

(ref:noise-comparator-logic-mshack-drums) [Virtual modular](https://cardinal.olney.ai) for a percussion patch using probabilistic gates slightly structured with NOT and AND operators.

<!-- MODAL HTML BLOCK -->


<!-- CAPTION BLOCK -->
<div class="figure">
<img src="images/launch-virtual-modular-button.png" alt="(ref:noise-comparator-logic-mshack-drums)" width="100%" />
<p class="caption">(\#fig:noise-comparator-logic-mshack-drums)(ref:noise-comparator-logic-mshack-drums)</p>
</div>

The output of this patch is much more complex than we could reasonably achieve using other sequencing methods, but it is also uncontrolled and not very musical, even when shaped a bit by logic.
An alternative to randomly creating gates is to take an existing pattern but randomly drop gates.
This can be implemented as simply as using noise source, a comparator, and an AND module that receives the output as well as the output for the normal gate.
However, to get the random gates to align with the standard clock, we'll use a new module, a sample and hold module.
A sample and hold module, when triggered, stores whatever voltage is present at its input and outputs that voltage until a new trigger is received, ignoring whatever input voltages occur in the meantime.
By connecting a random gate to a sample and hold and triggering it with a clock, we can synchronize the random gate with our clock and have a clean signal for deciding to drop a gate or not.
Note that if we wanted to produce V/Oct control voltage for random notes, we could similarly use sample and hold module directly connected to our random source, i.e. without a comparator.
Try updating the previous logic patch that selected every other off beat to further consider a random gate using the button in Figure \@ref(fig:noise-comparator-clock-division-drums-mschack-offbeat-logic-every-other-offbeat).

(ref:noise-comparator-clock-division-drums-mschack-offbeat-logic-every-other-offbeat) [Virtual modular](https://cardinal.olney.ai) for a percussion patch using a probabilistic gate and logic to decide when to drop a gate from an otherwise non-probabilistic sequence.

<!-- MODAL HTML BLOCK -->


<!-- CAPTION BLOCK -->
<div class="figure">
<img src="images/launch-virtual-modular-button.png" alt="(ref:noise-comparator-clock-division-drums-mschack-offbeat-logic-every-other-offbeat)" width="100%" />
<p class="caption">(\#fig:noise-comparator-clock-division-drums-mschack-offbeat-logic-every-other-offbeat)(ref:noise-comparator-clock-division-drums-mschack-offbeat-logic-every-other-offbeat)</p>
</div>

As shown by these patches, probability can be used to create interesting variations in several ways.
These methods are fairly compact and can switch between variations easily, however, there is a loss of control.
Modules specifically designed for randomness typically have additional parameters that allow the user to define how random events should be, which can help mitigate this loss of control.

## Speed variable clocks using LFOs

Recall one of the earlier challenges raised was to increasing the number of hits on a particular beat, skipping a beat, and accessing all possible beats (including off beats).
We've tried to solve this problem using gate delays, logic, or an increased step resolution to access off beats and gate multipliers and increased step resolution to increase the number of hits on a particular beat.
In each case, one technique would solve some problems but not others, with the exception of step resolution which has the problems previously discussed.

It turns out that we can achieve all three of these goals by running speed variable clocks, one for each percussion voice where we want to have multiple beats, skipping, or offbeats at different times.
The idea is that when we want multiple beats, we speed the clock up; when we want to skip a beat, we slow the clock down almost zero, and that when we want to access an offbeat, we use the same sequencer we're using the speed up and slow down the clock.
Because a clock is just unipolar rectangular waves, an LFO can be used as a speed variable clock.
One of the additional benefits of this approach is that skipping a beat and doubling a beat are controlled by the same parameter, frequency.
Contrast this with the previous approach using gate multiplication, where skipping a beat required an additional sequencer to shrink gate length to zero.
We still need a master clock however to keep the LFOs in sync, which can be done by sending clock to their reset inputs, which resets them to the beginning of their waveforms.

Let's recreate the off beat open hat with a double kick on the first beat that we've used as a running example.
Both of these voices will require their own LFO to serve as a clock, where each LFO has its frequency controlled by a sequencer.
Try updating the previous patch with gate delay and gate multiplier to use sequenced LFOs instead using the button in Figure \@ref(fig:lfo-mshack-drums-offbeat-roll).

(ref:lfo-mshack-drums-offbeat-roll) [Virtual modular](https://cardinal.olney.ai) for a percussion patch using LFOs as speed variable clocks to achieve gate delays, skipped steps, and off beats using a single parameter.

<!-- MODAL HTML BLOCK -->


<!-- CAPTION BLOCK -->
<div class="figure">
<img src="images/launch-virtual-modular-button.png" alt="(ref:lfo-mshack-drums-offbeat-roll)" width="100%" />
<p class="caption">(\#fig:lfo-mshack-drums-offbeat-roll)(ref:lfo-mshack-drums-offbeat-roll)</p>
</div>

As you can see, this approach is fairly compact but not as compact as using a gate delay and gate multiplier.
However it is easier to change between variations, e.g. adding rolls on different beats or silencing different beats would not require changing the patch, and these can be controlled by a single parameter.

A variation of this approach, though perhaps a somewhat distant one, can be used to generate gate patterns without a clock.
Simply mix LFOs at different frequencies to produce an irregular interference pattern that can then be run through a comparator to generate gates.
If these need to be synced to a clock for uniform gate lengths, then the sample and hold method discussed in the previous section can be used.
A clock can also be used to periodically trigger the reset of the LFOs, forcing the pattern to repeat.


## Euclidean sequencing

## Sequential switches

<!-- Remaining plan -->


<!-- Complex modules and Compositions		 -->
<!-- 	Controllers	 -->
<!-- 		Clock, sequencing, arpeggiators -->
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



