# (PART) Advanced Techniques {-}

# Modulating Controllers {#complex-controllers}

This chapter extends Chapter \@ref(controllers) by introducing more advanced approaches to sequencing.
Sequencing can be considered a kind of memory for musical events where the events can be stored and played back later.
Obviously there are gaps between events because not all notes (or beats) play at once.
This leads to the idea that sequencing involves both [positive space and negative space](https://en.wikipedia.org/wiki/Figure%E2%80%93ground_(perception)): positive space where musical events occur and negative space elsewhere.

This idea of positive and negative space can be seen clearly in step based sequencers that allow steps without events, such as the trigger sequencers discussed in Chapter \@ref(controllers).
However, a step-based conceptualization of sequencing leads to the limitation that a step should represent the smallest duration event, and such fine granularity naturally leads to more steps being empty.
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

(ref:clock-division-drums-mschack) [Virtual modular](https://olney.ai/ct-modular-book/modular-for-pdf.html?starter=empty.vcv&solution=%3cimg+class%3d%27rack-image%27+src%3d%27images%2fpatch-solutions%2fclock-division-drums-mschack.png%27%3e&instructions=%3cul%3e%0a%3cli%3eAdd+BPM+Clock%2c+Dividah%2c+Synth+Drums%2c+Scope%2c+QuadVCA%2fMixer%2c+and+Host+audio%3c%2fli%3e%0a%3cli%3eConnect+Dividah+by+2+out+to+Synth+Drums+top+LVL+and+TRIG.+This+will+be+the+kick+drum%3c%2fli%3e%0a%3cli%3eConnect+Clock+out+to+Synth+Drums+middle+LVL+and+TRIG.+This+will+be+the+closed+hat%3c%2fli%3e%0a%3cli%3eConnect+Dividah+by+8+out+to+Synth+Drums+bottom+LVL+and+TRIG.+This+will+be+the+open+hat%3c%2fli%3e%0a%3cli%3eConnect+the+kick+out+to+Scope+in+1+and+QuadVCA%2fMixer+input+1%2c+snare+out+to+QuadVCA%2fMixer+input+2%2c+and+hat+out+to+Scope+in+2+and+QuadVCA%2fMixer+input+3%3c%2fli%3e%0a%3cli%3eConnect+QuadVCA%2fMixer+mix+out+to+Host+audio+L%3c%2fli%3e%0a%3cli%3eTry+the+following+and+note+the+differences+in+the+sound+and+scope+waveshape%3cul%3e%0a%3cli%3eAdjust+the+sound+type+%28checkbox%29%2c+freq%2c+hit%2c+and+release+time+for+kick%2c+closed+hat%2c+and+open+hat.+These+correspond+to+the+module+parameters+you%27d+use+if+you%27d+made+these+voices+with+multiple+modules+like+VCO%2c+noise%2c+and+ADSR%3c%2fli%3e%0a%3cli%3eAdjust+the+QuadVCA%2fMixer+levels%3c%2fli%3e%0a%3cli%3eAdjust+the+BPM+so+that+kick+is+at+about+120+%28and+the+closed+hat+is+twice+that%29+%3c%2fli%3e%0a%3c%2ful%3e%3c%2fli%3e%0a%3c%2ful%3e%0a%3cdiv+class%3d%27d-flex+flex-row+justify-content-around%27%3e%0a%3cimg+class%3d%27rack-image%27+src%3d%27images%2fsolo-modules%2fsynthdrums-solo.png%27%3e%0a%3c%2fdiv%3e%0a) for a basic percussion patch using clock divisions.

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

(ref:clock-division-drums-mschack-offbeat-gate-delay) [Virtual modular](https://olney.ai/ct-modular-book/modular-for-pdf.html?starter=clock-division-drums-mschack.vcv&solution=%3cimg+class%3d%27rack-image%27+src%3d%27images%2fpatch-solutions%2fclock-division-drums-mschack-offbeat-gate-delay.png%27%3e&instructions=%3cul%3e%0a%3cli%3eAdd+DGATE+between+Dividah+and+Synth+Drums%3c%2fli%3e%0a%3cli%3eConnect+Dividah+by+8+out+to+DGATE+trig+in+and+connect+DGATE+gate+out+to+both+LVL+and+Trig+inputs+for+the+open+hat%3c%2fli%3e%0a%3cli%3eTry+the+following+and+note+the+differences+in+the+sound+and+scope+waveshape%3cul%3e%0a%3cli%3eAdjust+the+DGATE+delay+to+get+the+open+hat+on+a+kick+offbeat%3c%2fli%3e%0a%3cli%3eAdjust+the+DGATE+Gate%2c+a+length+parameter%2c+so+see+the+effect+of+choking+the+hat%3c%2fli%3e%0a%3c%2ful%3e%3c%2fli%3e%0a%3c%2ful%3e%0a%3cdiv+class%3d%27d-flex+flex-row+justify-content-around%27%3e%0a%3cimg+class%3d%27rack-image%27+src%3d%27images%2fsolo-modules%2fdgate-solo.png%27%3e%0a%3c%2fdiv%3e%0a) for a percussion patch using clock divisions and a gate delay to hit an off beat.

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

(ref:clock-division-mshack-drums-offbeat-gate-delay-roll-seq-gate-mult) [Virtual modular](https://olney.ai/ct-modular-book/modular-for-pdf.html?starter=clock-division-drums-mschack-offbeat-gate-delay.vcv&solution=%3cimg+class%3d%27rack-image-6u%27+src%3d%27images%2fpatch-solutions%2fclock-division-mshack-drums-offbeat-gate-delay-roll-seq-gate-mult.png%27%3e&instructions=%3cul%3e%0a%3cli%3eAdd+RGATE+and+ADDR-SEQ+to+the+bottom+row%3c%2fli%3e%0a%3cli%3eConnect+Dividah+by+2+out+to+both+RGATE+clock+in+and+ADDR-SEQ+clock+in%3c%2fli%3e%0a%3cli%3eConnect+ADDR-SEQ+out+to+RGATE+mult+in%3c%2fli%3e%0a%3cli%3eConnect+RGATE+gate+out+to+both+LVL+and+Trig+inputs+for+the+kick%3c%2fli%3e%0a%3cli%3eTry+the+following+and+note+the+differences+in+the+sound+and+scope+waveshape%3cul%3e%0a%3cli%3eAdjust+the+RGATE+clock+multiplication+and+ADDR-SEQ+step+voltage+to+get+2+kicks+on+a+beat+%28strategy%3a+start+with+the+max+value+of+one+and+then+adjust+the+other%29%3c%2fli%3e%0a%3cli%3eUse+your+ears+and+the+Scope+to+make+sure+it%27s+correct%3c%2fli%3e%0a%3c%2ful%3e%3c%2fli%3e%0a%3c%2ful%3e%0a%3cdiv+class%3d%27d-flex+flex-row+justify-content-around%27%3e%0a%3cimg+class%3d%27rack-image%27+src%3d%27images%2fsolo-modules%2frgate-solo.png%27%3e%0a%3c%2fdiv%3e%0a) for a percussion patch using clock divisions, a delayed gate for an off beat hit, and a sequenced gate multiplier for multiple hits on the beat.

<!-- MODAL HTML BLOCK -->


<!-- CAPTION BLOCK -->
<div class="figure">
<img src="images/launch-virtual-modular-button.png" alt="(ref:clock-division-mshack-drums-offbeat-gate-delay-roll-seq-gate-mult)" width="100%" />
<p class="caption">(\#fig:clock-division-mshack-drums-offbeat-gate-delay-roll-seq-gate-mult)(ref:clock-division-mshack-drums-offbeat-gate-delay-roll-seq-gate-mult)</p>
</div>

Returning to the three ideal properties, the gate multiplier approach (again combined with clock divisions) is a bit compact because it relies on another sequencer, a bit less easy (because setting the multiplier voltage is a bit fiddly), and more flexible because it allows different drum rolls on each step.
Just as a sequencer was used to control the gate multiplier, a sequencer could be used to control the gate delay offset of the previous patch or drop a step by controlling the length parameter, as shown [here](images/patch-solutions/clock-division-mshack-drums-offbeat-gate-delay-roll-seq-gate-mult-skip-seq-gate-length.png).

It's clear that adding more sequencers to control these parameters increases flexibility but also makes the overall control less compact and changing between variations less easy.
For example, if one wanted to replace a skipped step with a triple beat, one would have to adjust the length sequencer for a non-zero gate length, then adjust the multiplier sequencer to create multiple hits on that step, i.e. one would have to adjust multiple parameters for that step, and these parameters are spread across different sequencers.
Is this suboptimal?
Let's compare against other solutions before making judgment.
One obvious alternative is to create the same pattern using standard step sequencers without any clock divisions.
Try updating the last patch with a step sequencer for the off beat hat and the double beat kick using the button in Figure \@ref(fig:trg-mshack-drums-offbeat-roll).
Because the kick time is 4:4, the sequencer only needs four steps.

(ref:trg-mshack-drums-offbeat-roll) [Virtual modular](https://olney.ai/ct-modular-book/modular-for-pdf.html?starter=clock-division-mshack-drums-offbeat-gate-delay-roll-seq-gate-mult.vcv&solution=%3cimg+class%3d%27rack-image-6u%27+src%3d%27images%2fpatch-solutions%2ftrg-mshack-drums-offbeat-roll.png%27%3e&instructions=%3cul%3e%0a%3cli%3eAdd+two+TRG+step+sequencers+to+the+bottom+row+and+move+the+DGATE+next+to+the+one+on+the+left.+This+will+be+the+open+hat+TRG%3c%2fli%3e%0a%3cli%3eConnect+Clock+beat+out+to+both+TRG+clock+ins%3c%2fli%3e%0a%3cli%3eConnect+the+open+hat+TRG+to+the+DGATE+trig+in.+The+DGATE+gate+outs+should+already+be+connected+to+the+Synth+Drums+open+hat+LVL+and+TRIG%3c%2fli%3e%0a%3cli%3e%3cem%3eTip%3a+You+need+DGATE+here+not+for+delay%2c+but+for+a+nonzero+gate+length+for+LVL.+Alternatively+you+could+use+an+ADSR+for+this%3c%2fem%3e%3c%2fli%3e%0a%3cli%3eConnect+the+kick+TRG+gate+out+to+the+kick+LVL+and+TRIG+in%3c%2fli%3e%0a%3cli%3eYou+may+wish+to+connect+the+Clock+reset+out+to+both+TRGs+to+align+their+sequences%3c%2fli%3e%0a%3cli%3eTry+the+following+and+note+the+differences+in+the+sound+and+scope+waveshape%3cul%3e%0a%3cli%3eAdjust+the+TRGs+to+8+steps.+You+need+8+in+order+to+have+two+kick+hits+on+the+first+beat%2c+keeping+Clock+BPM+at+around+240%3c%2fli%3e%0a%3cli%3eStep+sequence+in+4%3a4+for+the+kick+with+a+double+hit+on+the+first+beat%3c%2fli%3e%0a%3cli%3eStep+sequence+in+the+off+beat+open+hat+%28Hint%3a+this+occurs+on+2-and%29%3c%2fli%3e%0a%3c%2ful%3e%3c%2fli%3e%0a%3c%2ful%3e%0a) for a percussion patch using step sequencers for an off beat hit and multiple hits on the beat.

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
Looking at Figure \@ref(fig:clock-div2-div4), the offbeats are simply where the the beats are *not*.
So if we had a way of specifying "not beat," then we'd be able make a gate for the off beats.
[Boolean logic](https://en.wikipedia.org/wiki/Boolean_algebra) provides a way of specifying "not beat" and can further be used for more complex beat specifications.

Although it may seem intimidating at first, Boolean logic has just three basic operators, AND, OR, and NOT.
AND means two things happen together, OR means at least one thing happens, and NOT means something didn't happen.
If we represent something happening (like a gate) as 1 and not happening as 0, then these basic operators are summarized in Table \@ref(tab:logic).


Table: (\#tab:logic) Basic Boolean logic operators on signals S1 and S2. Note that AND and OR consider both signals but NOT considers only one or the other.



| S1 | S2 | AND(S1,S2) | OR(S1,S2)| NOT(S1) | NOT(S2) |
|:---:|:----:|:----:|:----:|:--------:|:--------:|
| 1  | 1  | 1 | 1  | 0      | 0      |
| 1  | 0  | 0 | 1  | 0      | 1      |
| 0  | 1  | 0 | 1  | 1      | 0      |
| 0  | 0  | 0 | 0  | 1      | 1      |

Try updating the basic percussion patch with a NOT module to put the open hat on every off beat using the button in Figure \@ref(fig:trg-mshack-drums-offbeat-roll).
We'll build on this logic in the following patches.

(ref:clock-division-drums-mschack-offbeat-logic-every-offbeat) [Virtual modular](https://olney.ai/ct-modular-book/modular-for-pdf.html?starter=clock-division-drums-mschack.vcv&solution=%3cimg+class%3d%27rack-image-6u%27+src%3d%27images%2fpatch-solutions%2fclock-division-drums-mschack-offbeat-logic-every-offbeat.png%27%3e&instructions=%3cul%3e%0a%3cli%3eAdd+dualNOT+to+the+bottom+row%3c%2fli%3e%0a%3cli%3eConnect+Clock+beat+out+to+both+TRG+clock+ins%3c%2fli%3e%0a%3cli%3eConnect+Dividah+by+2+out+to+dualNOT+top+input%3c%2fli%3e%0a%3cli%3eConnect+dualNOT+top+output+to+the+open+hat+LVL+and+TRIG+in%3c%2fli%3e%0a%3cli%3eRun+the+patch+and+observe+the+following%3cul%3e%0a%3cli%3eThe+open+hats+are+now+exactly+on+the+off+beat%2c+with+no+fine+adjustment+needed%3c%2fli%3e%0a%3cli%3eThe+lights+on+dualNOT+show+the+logic+of+what+is+happening%3a+when+input+is+high%2c+output+is+low+and+when+input+is+low%2c+output+is+high+-+exactly+what+is+needed+for+the+off+beats%3c%2fli%3e%0a%3c%2ful%3e%3c%2fli%3e%0a%3c%2ful%3e%0a%3cdiv+class%3d%27d-flex+flex-row+justify-content-around%27%3e%0a%3cimg+class%3d%27rack-image%27+src%3d%27images%2fsolo-modules%2fdualnot-solo.png%27%3e%0a%3c%2fdiv%3e%0a) for a percussion patch using clock divisions and the NOT operator to create gates for all off beat hits.

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

(ref:clock-division-drums-mschack-offbeat-logic-every-other-offbeat) [Virtual modular](https://olney.ai/ct-modular-book/modular-for-pdf.html?starter=clock-division-drums-mschack-offbeat-logic-every-offbeat.vcv&solution=%3cimg+class%3d%27rack-image-6u%27+src%3d%27images%2fpatch-solutions%2fclock-division-drums-mschack-offbeat-logic-every-other-offbeat.png%27%3e&instructions=%3cul%3e%0a%3cli%3eAdd+dualAND+to+the+bottom+row%3c%2fli%3e%0a%3cli%3eConnect+dualNOT+output+to+dualAND+top+input%3c%2fli%3e%0a%3cli%3eConnect+Dividah+by+4+out+to+dualAND+bottom+input%3c%2fli%3e%0a%3cli%3eConnect+dualAND+top+output+to+the+open+hat+LVL+and+TRIG+in%3c%2fli%3e%0a%3cli%3eRun+the+patch+and+observe+the+following%3cul%3e%0a%3cli%3eThe+open+hats+are+now+exactly+on+every+other+the+off+beat%2c+courtesy+of+the+%2f4+division%3c%2fli%3e%0a%3cli%3e%3cem%3eTip%3a+Because+we+are+running+the+Clock+at+double+speed%2c+the+divisions+here+are+twice+what+they+are+in+the+text.+If+the+dualNOT+took+clock+directly%2c+then+dualAND+would+take+the+%2f2+clock+division%3c%2fem%3e%3c%2fli%3e%0a%3cli%3eThe+lights+on+dualAND+show+the+logic+of+what+is+happening%3a+when+both+inputs+are+high%2c+output+is+high+and+otherwise+low+-+meaning+we+get+a+gate+only+when+a+%2f4+gate+occurs+and+a+%2f2+gate+does+not+occur+at+the+same+time%3c%2fli%3e%0a%3c%2ful%3e%3c%2fli%3e%0a%3c%2ful%3e%0a%3cdiv+class%3d%27d-flex+flex-row+justify-content-around%27%3e%0a%3cimg+class%3d%27rack-image%27+src%3d%27images%2fsolo-modules%2fdualand-solo.png%27%3e%0a%3c%2fdiv%3e%0a) for a percussion patch using clock divisions and combining the NOT and AND operators to create gates for every other off beat hits.

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

(ref:clock-division-drums-mschack-offbeat-logic-matching-gate-delay) [Virtual modular](https://olney.ai/ct-modular-book/modular-for-pdf.html?starter=clock-division-drums-mschack-offbeat-logic-every-other-offbeat.vcv&solution=%3cimg+class%3d%27rack-image-6u%27+src%3d%27images%2fpatch-solutions%2fclock-division-drums-mschack-offbeat-logic-matching-gate-delay.png%27%3e&instructions=%3cul%3e%0a%3cli%3eConnect+Dividah+by+4+out+to+dualNOT+bottom+input+%28don%27t+change+top+input%29%3c%2fli%3e%0a%3cli%3eConnect+dualNOT+bottom+output+to+dualAND+bottom+input+%28don%27t+change+top+input%29%3c%2fli%3e%0a%3cli%3eConnect+dualAND+top+output+to+the+dualAND+bottom+input+left+over%3c%2fli%3e%0a%3cli%3eConnect+dualAND+bottom+output+to+the+open+hat+LVL+and+TRIG+in%3c%2fli%3e%0a%3cli%3eRun+the+patch+and+observe+the+following%3cul%3e%0a%3cli%3eThe+open+hats+are+now+exactly+one+off+beat+every+4+beats%2c+courtesy+of+the+%2f4+division%3c%2fli%3e%0a%3cli%3e%3cem%3eTip%3a+Because+we+are+running+the+Clock+at+double+speed%2c+the+divisions+here+are+twice+what+they+are+in+the+text.+If+the+dualNOT+took+clock+directly%2c+then+dualAND+would+take+the+%2f2+clock+division%3c%2fem%3e%3c%2fli%3e%0a%3cli%3eThe+lights+on+bottom+dualAND+show+the+logic+of+what+is+happening%3a+the+original+logic+was+selecting+two+offbeats%2c+but+we+select+only+one+of+them+by+using+NOT+on+%2f4+and+combining+that+with+AND+on+the+existing+logic%3c%2fli%3e%0a%3c%2ful%3e%3c%2fli%3e%0a%3c%2ful%3e%0a) for a percussion patch using clock divisions and combining the NOT and AND operators to create a single gate per bar, matching the previous delayed gate behavior.

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

(ref:noise-comparator-logic-mshack-drums) [Virtual modular](https://olney.ai/ct-modular-book/modular-for-pdf.html?starter=clock-division-drums-mschack-offbeat-logic-matching-gate-delay.vcv&solution=%3cimg+class%3d%27rack-image-6u%27+src%3d%27images%2fpatch-solutions%2fnoise-comparator-logic-mshack-drums.png%27%3e&instructions=%3cul%3e%0a%3cli%3eDelete+the+Clock+and+Dividah+modules%2c+and+add+Noiz+and+two+Edge+modules+to+the+bottom+row%3c%2fli%3e%0a%3cli%3eDisconnect+all+cables+from+dualAND+and+dualNOT%3c%2fli%3e%0a%3cli%3eConnect+Noiz+red+out+to+the+first+Edge+in%2c+and+connect+the+first+Edge+high+out+to+the+dualAND+top+input.+The+high+out+is+active+when+the+input+value+goes+above+the+threshold+set+by+the+rise+knob%3c%2fli%3e%0a%3cli%3e+Connect+the+Noiz+white+out+to+the+second+Edge+in%2c+and+connect+the+second+Edge+high+out+to+the+second+top+input+of+the+dual+AND.+Also+connect+the+high+out+to+the+closed+hat+LVL+and+TRIG+in%3c%2fli%3e%0a%3cli%3eEven+if+you+turn+up+the+rise+knob+all+the+way%2c+you+should+hear+almost+constant+closed+hats+at+this+point.+This+is+why+we+need+the+AND+to+lower+the+probability+of+gates%3c%2fli%3e%0a%3cli%3eConnect+dualAND+top+output+to+the+open+hat+LVL+and+TRIG+in.+Because+the+AND+is+only+high+when+both+red+and+white+noise+are+over+threshold+at+the+same+time%2c+this+gate+will+occur+less+often+than+the+closed+hat+gate%3c%2fli%3e%0a%3cli%3eConnect+dualAND+top+output+to+the+dualNOT+top+input%3c%2fli%3e%0a%3cli%3eConnect+dualNOT+top+output+to+the+kick+LVL+and+TRIG+in.+The+NOT+ensures+that+the+open+hat+and+the+kick+will+be+gated+in+alternation%3c%2fli%3e%0a%3cli%3eTry+the+following+and+note+the+differences+in+the+sound+and+scope+waveshape%3cul%3e%0a%3cli%3eChange+the+hold+knob+on+both+Edge+modules.+This+controls+how+long+the+comparator+will+hold+an+output+value+before+testing+the+input+again.+Low+values+will+make+shorter+gates+and+vice+versa%3c%2fli%3e%0a%3cli%3eChange+the+rise+knob+on+both+Edge+modules.+This+controls+the+reference+voltage+for+the+comparator%2c+so+making+it+higher+makes+the+comparator+less+likely+to+be+active%2c+and+vice+versa%3c%2fli%3e%0a%3cli%3eLook+at+the+lights+on+the+logic+modules.+When+we+were+working+with+clock+divisions%2c+they+were+more+orderly+because+they+were+synced+to+the+clock.+Now+they+are+not+orderly+because+there+is+no+clock.%3c%2fli%3e%0a%3c%2ful%3e%3c%2fli%3e%0a%3c%2ful%3e%0a%3cdiv+class%3d%27d-flex+flex-row+justify-content-around%27%3e%0a%3cimg+class%3d%27rack-image%27+src%3d%27images%2fsolo-modules%2fedge-solo.png%27%3e%0a%3c%2fdiv%3e%0a) for a percussion patch using probabilistic gates slightly structured with NOT and AND operators.

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

(ref:noise-comparator-clock-division-drums-mschack-offbeat-logic-every-other-offbeat) [Virtual modular](https://olney.ai/ct-modular-book/modular-for-pdf.html?starter=clock-division-drums-mschack-offbeat-logic-every-other-offbeat.vcv&solution=%3cimg+class%3d%27rack-image-6u%27+src%3d%27images%2fpatch-solutions%2fnoise-comparator-clock-division-drums-mschack-offbeat-logic-every-other-offbeat.png%27%3e&instructions=%3cul%3e%0a%3cli%3eAdd+Noiz%2c+Comparator%2c+and+Holdah+to+the+bottom+row%3c%2fli%3e%0a%3cli%3e%3cem%3eTip%3a+We+are+using+a+different+comparator+because+Edge+outputs+5+V+and+we+need+10+V+for+a+consistent+gate+across+percussion+voices.+We+also+want+to+use+the+clock+as+the+threshold+to+the+comparator%2c+which+Edge+can%27t+do%3c%2fem%3e%3c%2fli%3e%0a%3cli%3eConnect+Dividah+by+4+to+Comparator+input+a+and+Noiz+red+out+to+Comparator+input+b%3c%2fli%3e%0a%3cli%3eConnect+Comparator+a+%3e+b+out+%28so+Clock+is+greater+than+red+noise%29+to+Holdah+input+and+connect+Dividah+by+4+to+Holdah+trigger%3c%2fli%3e%0a%3cli%3eConnect+dualAND+top+output+to+dualAND+bottom+input+a+and+connect+Holdah+output+to+dualAND+bottom+input+b%3c%2fli%3e%0a%3cli%3eConnect+dualAND+bottom+output+to+the+open+hat+LVL+and+TRIG+in.+This+gate+will+only+be+active+if+it+was+part+of+the+original+sequence+AND+the+random+gate+is+active+at+the+same+time%3c%2fli%3e%0a%3cli%3eRun+the+patch+and+observe+the+following%3cul%3e%0a%3cli%3eAlthough+the+comparator+output+is+blinking+wildly%2c+the+sample+and+hold+output+changes+only+when+triggered+by+the+clock.+This+prevents+our+hat+from+being+shortened+like+the+last+patch%3c%2fli%3e%0a%3cli%3eIf+you+switch+the+noise+type%2c+you+should+have+a+change+in+the+number+of+random+gates%2c+e.g.+white+has+a+greater+tendency+towards+higher+frequencies+so+would+cause+more+random+gates+%3c%2fli%3e%0a%3cli%3eSome+comparator+outputs+will+never+result+in+a+random+gate+%28like+%3d%29+and+others+will+always+result+in+a+random+gate+%28like+not+equals%2c+!%3d%29.+This+is+because+a+random+number+exactly+equalling+a+specific+value+is+rare%2c+but+not+equally+a+specific+value+is+common+%3c%2fli%3e%0a%3c%2ful%3e%3c%2fli%3e%0a%3c%2ful%3e%0a%3cdiv+class%3d%27d-flex+flex-row+justify-content-around%27%3e%0a%3cimg+class%3d%27rack-image%27+src%3d%27images%2fsolo-modules%2fcomparator-solo.png%27%3e%0a%3cimg+class%3d%27rack-image%27+src%3d%27images%2fsolo-modules%2fholdah-solo.png%27%3e%0a%3c%2fdiv%3e%0a) for a percussion patch using a probabilistic gate and logic to decide when to drop a gate from an otherwise non-probabilistic sequence.

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
Contrast this with the previous approach using gate multiplication, where skipping a beat required an additional sequencer.
We still need a master clock however to keep the LFOs in sync, which can be done by sending clock to their reset inputs, which resets them to the beginning of their waveforms.

Let's recreate the off beat open hat with a double kick on the first beat that we've used as a running example.
Both of these voices will require their own LFO to serve as a clock, where each LFO has its frequency controlled by a sequencer.
Try updating the previous patch with gate delay and gate multiplier to use sequenced LFOs instead using the button in Figure \@ref(fig:lfo-mshack-drums-offbeat-roll).

(ref:lfo-mshack-drums-offbeat-roll) [Virtual modular](https://olney.ai/ct-modular-book/modular-for-pdf.html?starter=clock-division-mshack-drums-offbeat-gate-delay-roll-seq-gate-mult.vcv&solution=%3cimg+class%3d%27rack-image-6u%27+src%3d%27images%2fpatch-solutions%2flfo-mshack-drums-offbeat-roll.png%27%3e&instructions=%3cul%3e%0a%3cli%3eRemove+Dividah%2c+DGATE%2c+and+RGATE%3c%2fli%3e%0a%3cli%3eOn+the+bottom+row%2c+add+LFOs+and+ADDR-SEQ+so+you+have+two+of+each+side+by+side%3c%2fli%3e%0a%3cli%3eStarting+with+the+open+hat+LFO%2fADDR-SEQ%2c+connect+Clock+8ths+out+to+ADDR-SEQ+clock+in+and+set+the+sequencer+to+8+steps%3c%2fli%3e%0a%3cli%3eConnect+ADDR-SEQ+out+to+LFO+FM+in+and+turn+attenuator+for+FM+all+the+way+positive%3c%2fli%3e%0a%3cli%3eConnect+the+LFO+square+out+to+the+open+hat+LVL+and+TRIG+in%3c%2fli%3e%0a%3cli%3eRepeat+the+above+for+the+kick+LFO%2fADDR-SEQ+but+use+the+Clock+beat+out+and+only+4+steps%3c%2fli%3e%0a%3cli%3eConnect+Clock+beat+out+to+the+reset+of+both+LFOs+to+keep+them+in+sync+with+the+clock%2c+and+connect+Clock+reset+out+to+both+sequencers+to+get+them+synchronized%0a%3cli%3eTry+the+following+and+note+the+differences+in+the+sound+and+scope+waveshape%3cul%3e%0a%3cli%3eChange+the+step+voltage+for+open+hat+sequencer.+Turning+all+the+way+to+the+left+should+skip+the+step.+Remember+you+only+need+one+open+hat+in+the+sequence%2c+on+4-and%3c%2fli%3e%0a%3cli%3eChange+the+step+voltage+for+the+kick+sequencer.+Turning+to+the+right+will+increase+the+number+of+beats+per+step.+If+you+turn+it+too+high%2c+it+will+appear+as+a+continuous+sound%2c+so+make+small+changes.+You+need+two+beats+on+the+first+step+to+match+the+previous+pattern%3c%2fli%3e%0a%3c%2ful%3e%3c%2fli%3e%0a%3c%2ful%3e%0a) for a percussion patch using LFOs as speed variable clocks to achieve gate delays, skipped steps, and off beats using a single parameter.

<!-- MODAL HTML BLOCK -->


<!-- CAPTION BLOCK -->
<div class="figure">
<img src="images/launch-virtual-modular-button.png" alt="(ref:lfo-mshack-drums-offbeat-roll)" width="100%" />
<p class="caption">(\#fig:lfo-mshack-drums-offbeat-roll)(ref:lfo-mshack-drums-offbeat-roll)</p>
</div>

As you can see, this approach is fairly compact but not as compact as using a gate delay and gate multiplier because we've explicitly represented a number of skipped steps.
However it is now easier to change between variations, e.g. adding rolls on different beats or skipping different beats would not require changing the patch, and these can be controlled by a single parameter.

A variation of this approach, though perhaps a somewhat distant one, can be used to generate gate patterns without a clock.
Simply mix LFOs at different frequencies to produce an irregular interference pattern that can then be run through a comparator to generate gates.
If these need to be synced to a clock for uniform gate lengths, then the sample and hold method discussed in the previous section can be used.
A clock can also be used to periodically trigger the reset of the LFOs, forcing the pattern to repeat.


## Euclidean rhythms

We've mostly discussed sequencing where the patterns have been designed by hand, with the exception of probabilistic gate sequences and the recently mentioned sequenced generated by frequency-mismatched LFOs.
What if there was a more predictable, more rule-like way of generating patterns?
Euclidean rhythm is a recently discovered method that generates patterns in a rule-like way [@Toussaint2005].
This approach gets its name from the [Euclidean algorithm](https://en.wikipedia.org/wiki/Euclidean_algorithm) for finding the greatest common divisor, which is the largest natural number that divides two numbers, $a$ and $b$  without a remainder.
Here's how it works.
Suppose $a > b$.
Then the algorithm divides $a$ by $b$ to get a remainder $c$, e.g. $8/5$ has remainder 3.
If $c=0$, then $b$ is the greatest common divisor.
Otherwise repeat by substituting b and c for a and b, e.g. 5/3 has remainder 2.^[This is the division variant of Euclid's algorithm. The original used subtraction and so is slower and slightly more complicated because in subtraction, the difference isn't guaranteed to be smaller than the subtrahend.]

To map the Euclidean algorithm to beats, suppose that we want to evenly distribute $b$ beats over $p$ positions, which we will call $E( b, p )$. 
Positions with no beat are silent ($s$). 
Then we parallel the structure of the Euclidean algorithm and define division as pairing up the $b$ and $s$, with the unpaired $s$ forming the remainder. 
The pairs substitute for $b$, the remainder substitutes for $s$, and the process repeats until the remainder is a single element or there are no $s$.
An example of this process is shown in Table \@ref(tab:euclid) for $E(5,13)$.


Table: (\#tab:euclid) Steps of the Euclidean algorithm for the greatest common divisor of $8$ and $5$ (left) and corresponding pattern of beats ($x$) and silences ($.$) in the Euclidean rhythm for $E(5,13)$ (right). Note that the number of groups in the pattern, marked by vertical bars, match the numbers $a$ and $b$. These bars are removed in final result, x..x.x..x.x..


| a | b | c |   | Pattern                     |
|---|---|---|---|-------------------------------------------|
| 8 | 5 | 3 |   | \|x\|x\|x\|x\|x\|.\|.\|.\|.\|.\|.\|.\|.\| |
| 5 | 3 | 2 |   | \|x.\|x.\|x.\|x.\|x.\|.\|.\|.\|           |
| 3 | 2 | 1 |   | \|x..\|x..\|x..\|x.\|x.\|                 |
| 2 | 1 | 0 |   | \|x..x.\|x..x.\|x..\|                     |

As shown in Table \@ref(tab:euclid), Euclidean rhythms divide the number of beats across positions as evenly as possible.
If $b$ divides $p$ without remainder, then there will be an equal number of silences between beats.
It turns out that there is an even easier way to calculate Euclidean rhythms by using [Bresenham's line algorithm](https://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm): using the equation for a line, at each natural number $x$, take the floor^[A floor operation truncates the decimal portion of a number, e.g. 3.28 becomes 3.] of $y$.
In this approach, $x$ is equivalent to $p$, each increase in $y$ is equivalent to $b$, and each lack of increase in $y$ is equivalent to $s$.
The result of the algorithm is shown in shown in Figure \@ref(fig:bresenham-line).
Note that the colored regions mark the closest fitting line with slope $5/13$ where the line is constrained to move in square units - this is equivalent to distributing beats as evenly as possible across positions.

(ref:bresenham-line) Example of Bresenham's line algorithm for the example $E(5,13)$. 

<div class="figure">
<img src="images/bresenham-line.png" alt="(ref:bresenham-line)" width="100%" />
<p class="caption">(\#fig:bresenham-line)(ref:bresenham-line)</p>
</div>

Euclidean rhythms can start at an offset into the sequence such that the skipped early portion is then added to the end. 
This is sometimes called a rotation, and different rotations are sometimes described as belonging to the same necklace.
Let's apply Euclidean rhythms to the basic percussion patch from the beginning of the chapter.
We'll use a special model that generates a Euclidean rhythm for each percussion voice, along with a trigger to gate module.
Try updating that patch using the button in Figure \@ref(fig:euclidean-drums-mschack).

(ref:euclidean-drums-mschack) [Virtual modular](https://olney.ai/ct-modular-book/modular-for-pdf.html?starter=clock-division-drums-mschack.vcv&solution=%3cimg+class%3d%27rack-image-6u%27+src%3d%27images%2fpatch-solutions%2feuclidean-drums-mschack.png%27%3e&instructions=%3cul%3e%0a%3cli%3eRemove+Dividah+and+add+three+pairs+of+Eugene+and+DGATE+to+the+bottom+row%2c+one+per+voice.+The+first+pair+will+be+for+the+open+hat%2c+the+second+for+the+closed+hat%2c+and+the+third+for+the+kick+%3c%2fli%3e%0a%3cli%3eConnect+the+Clock+8ths+out+the+Eugene+for+the+closed+and+open+hats%2c+and+connect+the+Clock+beat+out+to+the+Eugene+for+the+kick%3c%2fli%3e%0a%3cli%3eConnect+each+Eugene+out+to+its+corresponding+voice+trig+input+and+its+paired+DGATE+trig+input+%3c%2fli%3e%0a%3cli%3eConnect+each+DGATE+gate+out+to+its+corresponding+voice+level%3c%2fli%3e%0a%3cli%3eTry+the+following+and+note+the+differences+in+the+sound+and+scope+waveshape%3cul%3e%0a%3cli%3eChange+the+length%2c+hits%2c+and+shift+for+each+Eugene+to+create+a+pattern.+Length+is+the+pattern+length%2c+hits+is+the+*percentage*+of+patterns+steps+that+have+a+beat%2c+and+shift+rotates+the+start+position+of+the+pattern.+The+effects+of+these+are+shown+on+the+Eugene+display%3c%2fli%3e%0a%3cli%3eIf+you+choose+1%2f8%2c+8%2f8%2c+and+4%2f4%2c+you+are+close+to+the+original+delayed+gate+pattern%3c%2fli%3e%0a%3c%2ful%3e%3c%2fli%3e%0a%3c%2ful%3e%0a%3cdiv+class%3d%27d-flex+flex-row+justify-content-around%27%3e%0a%3cimg+class%3d%27rack-image%27+src%3d%27images%2fsolo-modules%2feugene-solo.png%27%3e%0a%3c%2fdiv%3e%0a) for a percussion patch using Euclidean rhythms for each voice.

<!-- MODAL HTML BLOCK -->


<!-- CAPTION BLOCK -->
<div class="figure">
<img src="images/launch-virtual-modular-button.png" alt="(ref:euclidean-drums-mschack)" width="100%" />
<p class="caption">(\#fig:euclidean-drums-mschack)(ref:euclidean-drums-mschack)</p>
</div>

As you can see from the patch, Euclidean rhythms is very compact and flexible, since we can easily change the length of patterns without affecting the proportion of hits and vice versa, just by turning a knob.
However, we also lose some precision.
For example, it isn't possible to make a double hit on the first beat because Euclidean rhythms by definition evenly distribute beats.
So again, we trade precision for compactness and flexibility.
It's worth noting that Euclidean rhythms can also define scales. 
For example, $E(5,12)$ selects notes in the major pentatonic scale, and $E(7,12)$ selects notes in the diatonic scale C major.

## Sequential switches

The focus up to this point has been on creating patterns, but music typically involves chains of patterns.
While it would be possible to have repetitions of a pattern in a sequencer, this is less compact because any change to a step in the pattern would require changing that step everywhere the pattern was repeated.
Instead it makes sense to consider each pattern as a chunk sequence these chunks.
Sequential switches are type of module that makes it easy to switch between different patterns in a sequence.

Sequential switches are also known as [multiplexers and demultiplexers](https://en.wikipedia.org/wiki/Multiplexer).
A multiplexer is used to send $N$ different signals to 1 place (N:1), and a demultiplexer is used to send 1 thing to $N$ different places (1:N).
The signal can be anything, including audio, and the destination is selected either by a clock  or control voltage.
When the selection is done by clock, each clock advances the switch just like a clock advances a sequencer.
When the selection is done by control voltage, different voltage ranges select different destinations so that the selection can go out of order.

As a concrete example, supposed you have a kick drum and you want to send it a pattern, and when that pattern finishes, send it another pattern.
That is multiplexing because you have $N$ patterns you are sending to 1 place, the kick drum.
On the other hand, suppose you have a pattern that you'd first like to send to flute voice, and when that pattern finishes, send the same pattern to a violin voice, and so on.
That is demultiplexing because you have 1 pattern that you are sending $N$ different places.
If this is confusing, it's best to assume multiplexing (N:1) as this seems to be the more common operation.

Let's look at a simple example of using a sequential switch.
In the previous patch with a gate delay and gate multiplier, the kick had a double hit on the first beat, and this was repeated every four beats.
Suppose we wanted to repeat every eight beats instead.
One option is to fill up the sequencer with empty steps, but another option is to divide the eight steps into two sequences of four steps each.
The first four step sequence is our original sequence, and the second four step sequence is just the kick clock division.
A clock division matching the length of the patterns is sent to the switch to advance to the next pattern.
Try implementing this patch using the button in Figure \@ref(fig:clock-division-mshack-drums-offbeat-gate-delay-roll-seq-gate-mult-pattern-change-sequential-switch).

(ref:clock-division-mshack-drums-offbeat-gate-delay-roll-seq-gate-mult-pattern-change-sequential-switch) [Virtual modular](https://olney.ai/ct-modular-book/modular-for-pdf.html?starter=clock-division-mshack-drums-offbeat-gate-delay-roll-seq-gate-mult.vcv&solution=%3cimg+class%3d%27rack-image-6u%27+src%3d%27images%2fpatch-solutions%2fclock-division-mshack-drums-offbeat-gate-delay-roll-seq-gate-mult-pattern-change-sequential-switch.png%27%3e&instructions=%3cul%3e%0a%3cli%3eAdd+8%3a1+to+the+bottom+row+to+the+left+of+ADDR-SEQ+%3c%2fli%3e%0a%3cli%3eConnect+Dividah+by+2+out+to+8%3a1+input+1%3c%2fli%3e%0a%3cli%3eConnect+RGATE+gate+out+to+8%3a1+input+2%3c%2fli%3e%0a%3cli%3eConnect+Dividah+by+8+out+to+8%3a1+clock+input+and+Clock+reset+to+8%3a1+reset%3c%2fli%3e%0a%3cli%3eSet+the+8%3a1+steps+to+2+and+connect+8%3a1+out+to+kick+LVL+and+TRIG+in%3c%2fli%3e%0a%3cli%3eRun+the+patch+and+observe+the+following%3cul%3e%0a%3cli%3eThe+switch+is+changing+every+4+beats+%28see+the+light+moving+between+inputs%29%3c%2fli%3e%0a%3cli%3eBoth+inputs+are+always+going%2c+but+the+switch+is+choosing+which+to+let+through+at+any+moment%3c%2fli%3e%0a%3c%2ful%3e%3c%2fli%3e%0a%3c%2ful%3e%0a%3cdiv+class%3d%27d-flex+flex-row+justify-content-around%27%3e%0a%3cimg+class%3d%27rack-image%27+src%3d%27images%2fsolo-modules%2f81-solo.png%27%3e%0a%3c%2fdiv%3e%0a) for a percussion patch using a sequential switch to alternate between patterns.

<!-- MODAL HTML BLOCK -->


<!-- CAPTION BLOCK -->
<div class="figure">
<img src="images/launch-virtual-modular-button.png" alt="(ref:clock-division-mshack-drums-offbeat-gate-delay-roll-seq-gate-mult-pattern-change-sequential-switch)" width="100%" />
<p class="caption">(\#fig:clock-division-mshack-drums-offbeat-gate-delay-roll-seq-gate-mult-pattern-change-sequential-switch)(ref:clock-division-mshack-drums-offbeat-gate-delay-roll-seq-gate-mult-pattern-change-sequential-switch)</p>
</div>

Using a switch in this way suggests a general strategy for sequencing.
Since each of the techniques discussed in this chapter has its strengths and weaknesses with respect to compactness, flexibility, and precision, it makes sense to alternate between them depending on the needs of the sequencing problem at hand and use sequential switches to combine them into larger patterns.

## Check your understanding

1. Which of the following is suitable for combining sequences into larger patterns?
- logic gates
- sequential switches
- speed variable clocks
- Euclidean rhythms

2. Which of the following is not a problem for sequencing using clock divisions alone?
- offbeats
- rests
- regular beats
- rolls
            
3. How many Boolean logic operators are there?
- 2
- 4
- 3
- 5
            
4. Which of the following is not a parameter of Euclidean rhythms?
- beats
- rotation
- positions
- probability
