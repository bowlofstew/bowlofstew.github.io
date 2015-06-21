---
layout: post
title: "Modelling Instruments"
comments: true
permalink: monitoring-financial-instruments
tags: [cpp]
layout: post
---
*Listed financial instrument modelling*
-----

I was thinking about modeling exchange listed financial derivatives.  What do
you think the main actors are that we need to model for (exchange) listed
derivatives?  Let us think about the data structures.  I will neglect any
member functions for now below.

*An instrument*

```c++
class Instrument {
  private:
    std::string nameM;
}

```

But we need more information though!  What if Gold is traded on 2 exchanges?

*Let's add an....Exchange*

```c++
class Exchange {
  private std::string nameM;
}

```

This now leads us to:

```c++
class Instrument {
  private:
    std::string nameM;
    Exchange exchangeM;
}

```

But we now have yet another problem, what if the 2 changes trade the instrument
in difference currencies?  How shall we represent the currency here? A typical
representation in programming is [ISO 4217](http://www.iso.org/iso/home/standards/currency_codes.htm).
There is a C++ implementation of [this](https://github.com/castedo/isomon) standard available.
Lets use that:

```c++
class Instrument {
  private:
    std::string nameM;
    Exchange exchangeM;
    currency currencyM;
}

```

This is all good but we haven't covered the aspect of a derivative being listed,
expiring, and last traded on a particular date:

```c++
class Instrument {
  private:
    std::string nameM;
    Exchange exchangeM;
    currency currencyM;
    time_t listAtM;
    time_t expireAtM;
    time_t lastTradeDateM;
}

```

NOTE: I have shown time_t but really recommend using something like the Boost
date/time facilities for this.  

We haven't yet modeled the tick size yet though which is a very important item
for pricing!

```c++
class Instrument {
  private:
    std::string nameM;
    Exchange exchangeM;
    currency currencyM;
    time_t listAtM;
    time_t expireAtM;
    double tickSizeM;
}

```

Something still seems fishy though.....We still haven't modeled the underlying
instrument.  That being said, I will cover it next time but if you want to cover
the topics here in more detail check out [this](http://www.cmegroup.com/trading/interest-rates/stir/eurodollar_contract_specifications.html).

Next, we will review what kind of instrument (derivative) & the underlying instrument
for the derivative.