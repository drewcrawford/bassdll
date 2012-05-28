/* 
 * Copyright (c) 2009 Drew Crawford
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
 * IN THE SOFTWARE.
 */

#ifndef BASSDILL_LIB
#define BASSDILL_LIB
//BASS.DLL
#if defined(ARDUINO) && ARDUINO >= 100
#include "Arduino.h"
#else
#include "WProgram.h"
#endif
#include <debug.h>
#include <limits.h>
#include <math.h>




#define MAGIC 1.0594631
inline int fixTone(signed char tone)
{
  return 440*pow(MAGIC,tone);
}
///NOTE
#define TRANSPOSEUP  -124
#define TRANSPOSEDOWN -123

#define REST -127

#define KICK -126
#define SNARE -125

#define STOP -122

#define SUPERSOLO -121
 struct note {
  signed char tone;
  unsigned char duration;
};
///CHANNEL
class channel
{
  
  //note array
  
  unsigned long duration_sum;
  signed char transpose; //channel-wide transpose (implemented in setupNote)

  public:
      int insert_at;
      void init();
void setupNote(unsigned long started_playing_time);
    void next();
    void queue(note* n);
    void fixHigh();
    void fixLow();
    inline void notehacks();
    void realloc_notes();
    channel(int pin, int how_many_notes);
    ~channel();
    int halflife; //time from rising edge at which we invert the pin
    unsigned long next_invert_time;
    unsigned long nextTime; //wall-clock-time at which we go to the next note
    int pin; //pin the channel writes on
    char position; //is the pin up or down?
    union q //used for various purposes by the notehack
    {
      int i;
    } notehack;
    unsigned char supersolo; //supersolo value
    unsigned char ssinterval; //supersolo interval
    
    note **notes;
    int current;
    

};
//////MIXER
#define MIXER_CHANNELS 4 //if you need more than that
class mixer
{

   int max_channel;
    public:
       channel *channels[MIXER_CHANNELS];
    mixer();
    void add_channel(channel*x);
    void play();
   
};
#endif
