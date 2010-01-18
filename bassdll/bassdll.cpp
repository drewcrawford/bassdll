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

#include "bassdll.h"

void channel::next()
{
  duration_sum += notes[current]->duration * 10;
  current++;
  if (current==insert_at) current = 0;
}

channel::channel(int apin, int how_many_notes)
{
  pinMode(apin,OUTPUT);
  halflife = 0;
  //next_invert_time = 0;
 // nextTime = 0;  
  pin = apin;
//  notes = NULL;
  realloc_notes();
  init();
  
 // debug(sizeof(note*) * how_many_notes);
}

void channel::init()
{
    nextTime = micros(); //YES, YOU NEED THIS HERE.  THINK ABOUT IT.
    position = LOW;
    duration_sum = 0;
    transpose = 0;
    supersolo = 0;
    notehack.i = 0;
    current = 0;
    ssinterval = UCHAR_MAX;
}

void channel::setupNote(unsigned long started_playing_time)
{

      note *solonote = notes[current];
 switch(notes[current]->tone)
 {
   //hacks for various notes
   case KICK:
     halflife = 500000/200;
     break;
   case SNARE:
     halflife = 500000/345;
     break;
     //otherwise (square halflife)
   case TRANSPOSEUP:
     halflife = INT_MAX;
     transpose++;
     break;
   case TRANSPOSEDOWN:
   /// debug(444);
     transpose--;
     halflife = INT_MAX;
     break;
   case SUPERSOLO: 

     supersolo = solonote->duration;
     solonote->duration = 0;
     next();
     solonote->duration = supersolo; //restore duration for the next loop
     setupNote(started_playing_time); //fake out everything
     return;
     break;
    default:
     halflife = 500000/fixTone(notes[current]->tone + transpose);
     break; 
 }
 if (halflife <0) halflife = INT_MAX; //we use negative number on occasion for things like rests...
 unsigned long old_nextTime = nextTime;
  nextTime = started_playing_time + ((unsigned long) //instruct the compiler that this is going to get BIG... otherwise things overflow here
 duration_sum + notes[current]->duration*10)*1000;
 next_invert_time = old_nextTime + halflife;

// if (notes[current]->tone==REST) debug (notes[current]->duration);
 //debug(nextTime);
// if (current->tone==4) if (current->next==NULL) debug(1);
}





void channel::realloc_notes()
{
    insert_at = 0;
}
channel::~channel()
{
  free(notes);
}

void channel::queue(note* n)
{
  notes[insert_at++]=n;
}

inline void channel::notehacks ()
{
  switch(notes[current]->tone)
  {
    case KICK:
      
      notehack.i++;

      if (notehack.i>=10)
      {
        
        notehack.i = 0;
        halflife *= 1.05;
      }
      break;
    case SNARE:
    
      notehack.i++;
      if(notehack.i==10)
      {
        notehack.i = 0;
        halflife *= 1.05;
      }
      break;
      default:
      break;
  }
  //supersolo hack
  if (supersolo!=0 && (ssinterval--)%supersolo==0)
  {
    char super = (notes[current+1]->tone > notes[current]->tone)?-1:1;
   // halflife *= ((1 + (.01*super)) * supersolo/10.);
   halflife += super;
  }
}
//MIXER////////////////////////
mixer::mixer()
{
  max_channel=0;
}
void mixer::play()
{
  unsigned long lastClock = micros();
  unsigned long wall_clock_time = micros();
  int a = 0;
  for(int i = 0; i < max_channel; i++)
  {
    channels[i]->init();
    channels[i]->setupNote(wall_clock_time);
  }
  while(true)
  {  
     //loop through each channel
     unsigned long minDelay  = ULONG_MAX;
     channel* active = NULL;
    
     for(int i = 0; i < max_channel; i++)
     {
       
      // debug(0);
      //note* current = channels[i]->notes[channels[i]->current];
     // if (channels[i]->notes[channels[i]->current]->tone==REST) continue; //not the minDelay
      if (channels[i]->notes[channels[i]->current]->tone==STOP) return;
       if (channels[i]->next_invert_time < minDelay)
       {
         minDelay = channels[i]->next_invert_time;
         active = channels[i];
       }
     }
     //minDelay = channels[2]->next_invert_time;
     //active = channels[2];
     if (active==NULL) debug(997);
    // if (channels[0]->current->now->tone==9 && minDelay != 1353 && minDelay != 676) debug(minDelay);
     //BLOCK
    // note* current = active->notes[active->current];
     if (active->notes[active->current]->tone!=REST)
         active->position = ! active->position;
 // if(active==channels[0])if(active->next_invert_time > channels[2]->next_invert_time) debug(1024);
  while (micros() < minDelay){}
     lastClock = micros();
	  
     digitalWrite(active->pin,active->position);
     active->notehacks();
     active->next_invert_time += active->halflife;

    for(int i = 0; i < max_channel; i++)
     {

       if (lastClock >= channels[i]->nextTime)
       {
                //   if (++a==2) debug(0);
         //debug(channels[i]->nextTime);
      //  debug(0);
        channels[i]->next();
         channels[i]->setupNote(wall_clock_time);
        // debug(channels[i]->nextTime);
        //a++;
       // channels[i]->setupNote(0); 

       } 
      // debug(sizeof(channels[0]->nextTime));
      // if (channels[0]->nextTime - lastClock > 50000) debug (channels[0]->duration_sum);
      // if (lastClock < 1000000 && channels[0]->current->now->tone==4) debug(lastClock)   ;    



     }  
  
     
     
     
a++;
  }
}
void mixer::add_channel(channel* x)
{
  channels[max_channel++]=x;
  
}

