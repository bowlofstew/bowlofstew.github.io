---
layout: post
title: "C++ chrono"
comments: true
permalink: cpp-chrono
---
*Chrono high resolution dive*
-----

<!--adsense1-->

I have been toying with the C++ chrono functionality over the last few hours.  The high-resolution functionality is very welcomed compared to the non-portable equivalents (or boost) of 
times past.  Note there are 2 clocks available to you in this namespace, system_clock and
steady_clock.  

  * system_clock: wall clock

  * steady_clock: monotonically increasing clock.  Immune against NTP changes  

  In the below example, the code computes the latency on hitting the processor 
  cache.  The chrono class, high-resolution clock is used for this.  

  ```cpp
  	#include <iostream>
	#include <chrono>
	#include <ctime>
	#include <cmath>
	#include <cstdlib>
	#include <cstdio>

	typedef std::chrono::high_resolution_clock::time_point point;
	typedef std::chrono::high_resolution_clock Time;
	typedef std::chrono::milliseconds ms;
	typedef std::chrono::duration<float> fsec;

	std::chrono::high_resolution_clock::time_point get_now() {
	 	return Time::now();
	}

	ms get_delta(point pA, point pB) {
		return std::chrono::duration_cast<ms>(pB - pA);
	}

	void print_delta(point pA, point pB) {
		ms diff = get_delta(pA, pB);
		std::cout << diff.count() << std::endl;
	}

	int main(int argc, char * argv[]) {
	  for(int i = 0; i < 18; ++i) {
	  	int size = std::pow(2.0, i) * 1024;
	  	int * tab = new int[size];
	  	float average = 0.0;
	  	for(int j = 0; j < 4; ++j) {
	  		auto t0 = get_now();		
	  		for(int k = 0; k < (100*1024*1024); ++k) {
	  			tab[(k*16)%(size/4)]++;
	  		}
	  		average += get_delta(t0, get_now()).count();
	  	}
	  	printf("size=%d kB, time:%g ms\n", size/1024, average/4);
	  	free(tab);
	  }
	}
  ```

  In this example, the clock hasn't been checked to see if it is truly a
  steady state clock so time adjustments may yeild the measurement inaccurate.  In 
  order to correct for this, we should check to see that:

  ```cpp
  std::chrono::high_resolution_clock::is_steady == true
  ```

  Checking on my OSX system,

  CLOCK KIND 		 	| STEADY |
  ----------------------|--------|
  system_clock			|false   |
  high_resolution_clock |true    |
  steady_clock			|true	 |

[chrono reference](http://en.cppreference.com/w/cpp/chrono)

PS: So much better than in [assembly](http://www.jagregory.com/abrash-zen-of-asm/#the-zen-timer)

<!--adsense2-->
