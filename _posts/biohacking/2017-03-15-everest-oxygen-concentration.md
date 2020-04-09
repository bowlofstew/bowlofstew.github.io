---
layout: post
title: "Oxygen Concentration on Mt. Everest"
permalink: everest-oxygen-concentration
layout: post
tags: [everest, altitude, chemistry]
categories: biohacking
---
*Computing the Oxygen Concentration on Mt. Everest*
-----

<style type="text/css">
  dummydeclaration { padding-left: 4em; } /* Firefox ignores first declaration for some reason */
  tab1 { padding-left: 4em; }
  tab2 { padding-left: 8em; }
  tab3 { padding-left: 12em; }
  tab4 { padding-left: 16em; }
  tab5 { padding-left: 20em; }
  tab6 { padding-left: 24em; }
  tab7 { padding-left: 28em; }
  tab8 { padding-left: 32em; }
  tab9 { padding-left: 36em; }
  tab10 { padding-left: 40em; }
  tab11 { padding-left: 44em; }
  tab12 { padding-left: 48em; }
  tab13 { padding-left: 52em; }
  tab14 { padding-left: 56em; }
  tab15 { padding-left: 60em; }
  tab16 { padding-left: 64em; }
</style>

My original goal for this post was to write describe the effects of training at altitude upon the human body.  This was going to across multiple altitudes, both physical and simulated.  It was all going well until I came across an image of Mt. Everest and then I headed down a rabbit hole to compute all things related.  What you will find below is part 1 of my original intent which will be to study the effects of altitude training upon the human body.  This post is related to how to compute all things altitude related.  Further down the series, I will also cover a special case of this computation which is diving.

So if we are going to speak about altitude computations then we are going to need to review some laws and formulas from our chemistry courses from years past.

* * *

### [Boyle's Law](https://en.wikipedia.org/wiki/Boyle's_law){:target="_blank"}

Boyle's law in layman's terms states that gas expands as altitude goes up.  The opposite is also true for our diver friends.  That is, gas contracts when altitude contracts.  This law is dynamic in nature and due to this function itself cause humans many issues, such as:

  * [Decompression Sickness](https://en.wikipedia.org/wiki/Decompression_sickness){:target="_blank"}

  * [Acute Mountain Sickness](https://en.wikipedia.org/wiki/Altitude_sickness){:target="_blank"}

In non-layman's terms, Boyle's law is as follows:

  <p><tab1>P<sub>1</sub>V<sub>1</sub> = P<sub>2</sub>V<sub>2</sub></tab1></p>

Where,

  <p><tab1>P<sub>1</sub> is the pressure of the first component</tab1></p>

  <p><tab1>V<sub>1</sub> is the volume of the first component</tab1></p>

  <p><tab1>P<sub>2</sub> is the pressure of the second component</tab1></p>

  <p><tab1>V<sub>2</sub> is the volume of the second component</tab1></p>

* * *

### [Dalton's Law](https://en.wikipedia.org/wiki/Dalton's_law){:target="_blank"}

This law states that in a mixture of non-reacting gases, the total pressure exerted is equal to the sum of the partial pressures of the individual gases.

This basically means that the sum of all of the constituent gas pressures equals the total pressure or more succinctly,

  <p><tab1>p<sub>total</sub> = p<sub>1</sub> + ... + p<sub>n</sub></tab1></p>

where p is the partial pressure of each component and n is the component.

* * *
 
### [Ideal Gas Law](https://en.wikipedia.org/wiki/Ideal_gas_law){:target="_blank"}

The ideal gas law is the equation of state of a hypothetical ideal gas. It is a good approximation of the behavior of many gases under many conditions, although it has several limitations.

In formula form, it looks like:

  <p><tab1>PV = nRT</tab1></p>

Where,

  <p><tab1>P is the pressure of the gas</tab1></p>

  <p><tab1>V is the volume of the gas</tab1></p>

  <p><tab1>n is the amount of the gas</tab1></p>

  <p><tab1>R is the <a href="https://en.wikipedia.org/wiki/Gas_constant" target="_blank">universal gas constant</a></tab1></p>

  <p><tab1>T is the absolute temperature</tab1></p>

### [Charle's Law](https://en.wikipedia.org/wiki/Charles's_law){:target="_blank"}

Charles's law is an experimental gas law that describes how gases tend to expand when heated.  We will need to break this out for concentration computation later on.

* * *

### [Barometric Formula](https://en.wikipedia.org/wiki/Barometric_formula)

We will need to compute the pressure at the top of Mt. Everest.  The barometric formula can be used for this:

  <p><tab1>P<sub>Everest</sub> = 101,325 x (1 - 2.25577 x 10 <sup>-5</sup> x h) <sup>5.25588</sup></tab1></p>

Where,
  
  <p><tab1>101,325 is what is known as <a href="https://en.wikipedia.org/wiki/Standard_conditions_for_temperature_and_pressure" target="_blank">standard temperature and pressure</a></tab1></p>

  <p><tab1>P = air pressure in Pascal</tab1></p>

  <p><tab1>h = altitude above sea level (meters)</tab1></p>

We know that the peak of Mt. Everest is [8,848 meters above sea level](https://en.wikipedia.org/wiki/Mount_Everest){:target="_blank"}.

This give us:

  <p><tab1>P<sub>Everest</sub> = 101,325 x (1 - 2.25577 x 10 <sup>-5</sup> x 8,848) <sup>5.25588</sup></tab1></p>

  <p><tab1>P<sub>Everest</sub> = 31,443 Pascal</tab1></p>

### What is the concentration of oxygen on Mount Everest?

What are the knowns values?

  The [composition of the atmosphere](https://en.wikipedia.org/wiki/Atmosphere_of_Earth){:target="_blank"} is:

<div>
  <ul>
    <li>78.084% N<sub>2</sub>, Nitrogen</li>
    <li>20.946% O<sub>2</sub>, Oxygen</li>
    <li>0.9349% Ar, Argon</li>
    <li>0.04% CO<sub>2</sub>, Carbon Dioxide</li>
    <li>0.001818% Ne, Neon</li>
    <li>0.000524% He, Helium</li>
    <li>0.000179%, CH<sub>4</sub>, Methane</li>
  </ul>
</div>
    
 *  The [average temperature at the top of Mt. Everest](https://www.quora.com/What-is-the-average-temperature-at-the-peak-of-the-Everest){:target="_blank"}:

    * -19 &deg;C in the Summer

    * -36 &deg;C in the Winter

    * Mt. Everest forecast available [here](http://meteoexploration.com/forecasts/Everest/index.php?lang=en&si=Metric){:target="_blank"}

 
 *Computing it*

  <p><tab1>P<sub>O<sub>2</sub>, Everest</sub> = 0.20946 x P<sub>Total, Everest</sub></tab1></p>

 But how do we compute P<sub>Total, Everest<sub>?

  <p><tab1>P<sub>Total, Everest</sub> = (Pressure on Mt. Everest)/(Pressure at Sea Level)</tab1></p>

  <p><tab1>P<sub>Total, Everest</sub> = 0.31</tab1></p>

 Now that we have that, 

  <p><tab1>P<sub>O<sub>2</sub>, Everest</sub> = 0.20946 x 0.31 x 1 atm</tab1></p>

  <p><tab1>P<sub>O<sub>2</sub>, Everest</sub> = 0.0652 atm</tab1></p>

  <p><tab1>P<sub>O<sub>2</sub>, Everest</sub> = 6,603 Pascal (SI units)</tab1></p>

 The pressure as a function of altitude is:

<iframe style="border: none;" src="https://docs.google.com/spreadsheets/d/1LiwoCfGrk_mEOKAlkN08BneTWs5pcQ4EyGPJS34r1go/pubchart?oid=1736399481&amp;format=interactive" width="100%" height="400px"></iframe>

Thats cool and all but how concentrated is that oxygen?  Breaking out our friend the [ideal gas law](https://en.wikipedia.org/wiki/Ideal_gas_law){:target="_blank"} and [Charle's Law](https://en.wikipedia.org/wiki/Charles's_law){:target="_blank"}:

  <p><tab1>Ideal Gas Law: PV = nRT</tab1></p>

Here is where it gets tricky.  

  <p><tab1>Boyle's Law: P = (nR/V) x T</tab1></p>

  Recall that:

  <p><tab1>n = the amount of gas</tab1></p>

  <p><tab1>V = volume of gas</tab1></p>

  therefore, (n/v) is the concentration of gas.  I will rewrite this with C or concentration = (n/v)

  <p><tab1>C = P/RT</tab1></p>

  <p><tab1>C = 6,603 Pascal / (8.314 J / (mol * K) x 253.15 K)</tab1></p>

  <p><tab1>C = 3.13 mol/m<sup>3</sup></tab1></p>

I have compressed this entire computation down into a spreadsheet [here](https://docs.google.com/spreadsheets/d/1LiwoCfGrk_mEOKAlkN08BneTWs5pcQ4EyGPJS34r1go/edit?usp=sharing){:target="_blank"}

<iframe style="border: none;" src="https://docs.google.com/spreadsheets/d/1LiwoCfGrk_mEOKAlkN08BneTWs5pcQ4EyGPJS34r1go/pubhtml?gid=0&amp;single=true&amp;widget=true&amp;headers=false" width="100%" height="400px"></iframe>

So we did some math here and that's cool but what does it all mean?  

It means that the concentration of oxygen on the world's tallest mountain is 31% of what you experience at sea level.  The percentage of oxygen that you get relative to sea level as a function of altitude can be seen as:

<iframe style="border: none;" src="https://docs.google.com/spreadsheets/d/1LiwoCfGrk_mEOKAlkN08BneTWs5pcQ4EyGPJS34r1go/pubchart?oid=962497840&amp;format=interactive" width="100%" height="400px"></iframe>

For a quick comparision, here is a map of the camps by altitude on Mt. Everest:

![Everest Site Altitudes]({{ site.url }}/assets/images/biohacking/everest-altitudes.jpg)

By the time you summit, your altitude will have changed by 3,748 meters, your oxygen concentration decreased by 21.6%, and your [bank account decreased by a considerable amount](http://www.adventureconsultants.com/adventure/Everest-DatesandPrices/){:target="_blank"}.