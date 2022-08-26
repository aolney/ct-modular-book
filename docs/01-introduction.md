# Introduction

## Why this book?

Let's start with why I'm writing it -- that may help justify why you might want to read it. 
I got into electronic music in the 90's when I lived in London but never transitioned from DJing to making music, though several of my friends did. 
A few years ago, they started talking about modular, and in talking to them and trying to find out more about it, I realized a few things:

- The best books (to me) were from the 70's and 80's^[Old books that I like are @Crombie1982 and @Strange1983. Newer books of note are @Bjoern2018, which gives a great overview of module hardware and history, @Eliraz2022, which gives a broader overview of issues related to musical equipment and production, and @Dusha2020, which gives a modern but briefer introduction to modular than the older books. There are also some online courses (paid), but since I haven't taken them, I'm not listing them here.]
- Modular synthesis is really well aligned with *computational thinking* 

If you've never heard of computational thinking and don't know much about modular, that last point won't make a lot of sense, so let's break it down.

Modular sound synthesis (modular) creates sound by connecting modules that each perform some function on sound.
Different sounds are created by combining modules in different ways.

Computational thinking creates runnable models to solve a problem or answer a question. 
Models can be simulation models (e.g. meteorology), data models (e.g. statistics/data science), computation models (computer science), and perhaps other kinds of models.

How are they connected? Modular involves computational thinking when we:

- Simulate an instrument by reverse engineering its sound
- Create new sounds based on models of signal processing

So this book is about modular, but it approaches modular in a way that highlights computational thinking. 
I believe this deeper approach to modular will help you do more with it and also help you with other synthesizers or studio production tools.
The computational thinking approach should help accelerate your learning of computational-thinking domains in the future.

Since computational thinking involves problem solving, this book is full of interactive activities that will let you hone your modular skills.

## Computational thinking

@Tedre2016 present a nice overview of the history of computational thinking.
Here's a brief summary.

When the field of computing was taking off in the 1950s, there was interest and discussion about how it was different from other fields (e.g. math).
One argument was that computing involved *algorithmic thinking*, which is designing algorithms to solve problems (cf. programming), and this kind of thinking was unique to computing.
Some even thought that this kind of thinking could improve thinking generally.

*Computational thinking* appears to have been coined in the 1980's by Seymour Papert and popularized in his book *Mindstorms* [@Papert1980].
Papert was a mathematician by training, and his approach was much broader than the algorithmic thinking folks that came before.
Instead, his approach was empirical and embraced model building, with an emphasis on simulated microworlds containing robots (LEGO Mindstorms takes its name from this work).

Unfortunately today it's very hard to get agreement on what computational thinking is, so definitions tend to be squishy.
Some want to reduce it to computer literacy, others to basic programming, and yet others to discovery learning with computers, etc.

I take a more unified view based on model building and problem solving. 
I define computational thinking as building a *runnable* model to solve a problem:

- For an algorithmic problem, this is a model of computation (the original computer science view)
- For data science/statistics, this is a model of data
- For general scientific fields, this is a model of a phenomenon or process

The model doesn't need to run on a computer, but to be a runnable model, it needs to be mechanistic.
If you think it's crazy to talk about computational thinking without computers, consider that teaching computer science without computers has been part of the model curriculum for almost 20 years [@Tucker2003;@Bell2021].

So how do we learn to build runnable models to solve problems (i.e., how do we learn computational thinking)?
Well, models are made of interacting elements, so we need to learn those elements, and we need to learn how the elements interact.

Once we know those things, we can customize general problem solving, which has the same basic steps [@Polya2004]:

- Understand the problem
- Make a plan
- Implement the plan
- Evaluate the solution

For any new domain, the big things to learn are the elements, how they interact, and the "make a plan" step of problem solving.

## Modular synthesis

<!-- <iframe width="560" height="315" src="https://www.youtube.com/embed/aseMAEctM1s?start=21" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" ></iframe> -->

While we can pinpoint the invention of modular synthesis with some precision, it is useful to consider it in a broader context.
It seems man has long been interested in instruments that incorporate automation or somehow play themselves.
Wind chimes, which play a series of notes when disturbed by wind, can be found in the historical record thousands of years ago. 
Even before the complete electrification of instruments (synthesizers are electric by definition), there were numerous attempts to partially automate or model sounds using mechanical means, such as barrel organs, player pianos, or speech synthesis using bellows [@Dudley1950] as shown in Figure \@ref(fig:kemplen-machine).

(ref:kemplen-machine) [YouTube video](https://youtu.be/k_YUB_S6Gpo?start=21) of Wolfgang von Kempelen's speaking machine circa 1780.

<div class="figure">
<img src="downloadFigs4latex/kemplen-machine.jpg" alt="(ref:kemplen-machine)"  />
<p class="caption">(\#fig:kemplen-machine)(ref:kemplen-machine)</p>
</div>

Consider the difference between wind chimes or a player piano and this speaking machine.
Neither of the former is a model of the sound but rather uses mechanical means to trigger the sound (later we will refer to this as sequencing).
In contrast, the speaking machine is a well-considered model of the human speech mechanism.

Synthesizers using electricity appeared in the late 19th century. 
Patents were awarded just a few years apart to Elisha Gray, whose synthesizer comprised simple single note oscillators and transmitted over the telegraph, and Thaddeus Cahill (1879), whose larger Telharmonium could sound like an organ or various wood instruments but weighed 210 tons!

The modular synthesizer was developed by Harald Bode from 1959-1960 [@Bode1984], and this innovation quickly spread to others like Moog and Buchla.
The key idea of modular is flexibility. 
This is achieved by refactoring aspects of synthesis (i.e. functions on sound) into a collection of modules.
These modules may then be combined to create a certain sound by patching them together and adjusting module parameters (e.g. by turning knobs or adjusting sliders).


Tcherepnin); modules combined with patch cables to make sounds; a Moog modular then in today’s cost is about $96K.
1970s –
Semi-modular synthesizers developed; can be patched like modular but are invisibly pre-patched, which patching overrides; a Minimoog then in today’s cost is about $10K.

1980s –
Digital makes low-cost devices powerful; a Yamaha DX7 then in today’s cost is about $6K.
1990s – 
Computers become powerful enough that making/recording music is possible, reducing costs further; a Gateway computer with Cubase then in today’s cost is about $8K.
2010s –
Modular synthesizers resurge with lower costs connected to widespread electronics manufacturing, smartphones, and the open-source movement; an ALM System Coupe modular system costs $2.4K and VCVRack (virtual modular) is free.

**Table here showing cost reductions over time**

link to this somewhere
https://120years.net/wordpress/

Reducing cost for wider adoption

Simplifying use for wider adoption
Semi-modular
Special purpose modules vs. general purpose modules

Diversification of uses
A complete composition
A single voice
An effects box
