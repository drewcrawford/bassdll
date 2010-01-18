/* 
 * Copyright (c) 2010 Drew Crawford
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

#include <bassdll.h>
#include <debug.h>
 void pt3(channel &drums, channel &bassline, channel& sky);
  void pt2(channel &drums, channel &bassline, channel& sky);
   void pt1(channel &drums, channel &bassline, channel& sky);

mixer m;
note** memblk;
channel pin12(12,1);
channel pin11 (11,1);
channel pin10 (10,1);
void setup(){
memblk = (note**) calloc(290,sizeof(note*));
  if (memblk==NULL) debug(1111);

m.add_channel(&pin10);
m.add_channel(&pin11);
m.add_channel(&pin12); //LOUD PIN

  
}

void loop() {

  {pt1(pin10,pin11,pin12);}
    {pt2(pin12,pin11,pin10);}


    {pt3(pin12,pin11,pin10);}
}





#define EIGHTH 10
#define KICK_LEN 9
#define SNARE_LEN 7

//pt 3

inline void pt3(channel &drums, channel &bassline, channel& sky)
{
 ///OK HERES THE DRUM LOOP
  note kick;
  kick.tone = KICK;
  kick.duration = KICK_LEN;
  
  note kick_rest;
  kick_rest.tone = REST;
  kick_rest.duration = EIGHTH-KICK_LEN;
  
  note snare;
  snare.tone = SNARE;
  snare.duration = SNARE_LEN;
  
  note snare_rest;
  snare_rest.tone = REST;
  snare_rest.duration = EIGHTH-SNARE_LEN;
  
  note rest;
  rest.tone = REST;
  rest.duration = EIGHTH;
  
  //bassline notes
    note gsharp;
  gsharp.tone = -13;
  gsharp.duration = EIGHTH;
  
  note gsharp4;
  gsharp4.tone = -13;
  gsharp4.duration = 4 * EIGHTH;
  
  note gsharp2low;
  gsharp2low.tone = -25;
  gsharp2low.duration = 2 * EIGHTH;
  
  note gsharp2high;
  gsharp2high.tone = -13;
  gsharp2high.duration = 2*EIGHTH;
  
  note transpose;
  transpose.tone = TRANSPOSEUP;
  transpose.duration = 0;
  
  note transposed;
  transposed.tone = TRANSPOSEDOWN;
  transposed.duration = 0;
  
  note g2;
  g2.tone = -14;
  g2.duration = 2*EIGHTH;
  
  note c;
  c.tone = -9;
  c.duration = EIGHTH;
  
  note c4;
  c4.tone = -9;
  c4.duration = 4*EIGHTH;
  
  note c2;
  c2.tone = -9;
  c2.duration = 2*EIGHTH;
  
  note lowc;
  lowc.tone = -21;
  lowc.duration = EIGHTH;
  
  note lowc4;
  lowc4.tone = -21;
  lowc4.duration = 4*EIGHTH;
  
  //sky notes
      note sc;
  sc.tone = 3;
  sc.duration = EIGHTH;
  
  note  sgsharp;
  sgsharp.tone = -1;
  sgsharp.duration = EIGHTH;
  
  note sf;
  sf.tone = -4;
  sf.duration = EIGHTH;
    note sasharp;
  sasharp.tone = 1;
  sasharp.duration = EIGHTH;
    note sg;
  sg.tone = -2;
  sg.duration = EIGHTH;
  
  note se;
  se.tone = -5;
  se.duration = EIGHTH;
  
  note sdu;
  sdu.tone = 5;
  sdu.duration = EIGHTH;
  
  note seu;
  seu.tone = 7;
  seu.duration = EIGHTH;
  
  note sfu;
  sfu.tone = 8;
  sfu.duration = EIGHTH;
    note scd;
  scd.tone = -9;
  scd.duration = EIGHTH;
  
  note sgu;
  sgu.tone = 10;
  sgu.duration = EIGHTH;
  
  note scu;
  scu.tone = 15;
  scu.duration = EIGHTH;
  
  note sbu;
  sbu.tone = 14;
  sbu.duration = EIGHTH;
  
  note sd;
  sd.tone = -7;
  sd.duration = EIGHTH;
  
  note stop;
  stop.tone = STOP;
  stop.duration = 0;
  
   note sgsharpu;
  sgsharpu.tone = 11;
  sgsharpu.duration = EIGHTH;
  
    note sasharpu;
  sasharpu.tone = 13;
  sasharpu.duration = EIGHTH;
  note sduu;
  sduu.tone = 17;
  sduu.duration = EIGHTH;
   note seuu;
  seuu.tone = 19;
  seuu.duration = EIGHTH;
  note sguu;
  sguu.tone = 22;
  sguu.duration = EIGHTH;
    note nulln;
  nulln.tone = REST;
  nulln.duration = EIGHTH * 16;
    note scuu;
  scuu.tone = 27;
  scuu.duration = EIGHTH * 16;
  
  //do the allocs

  drums.notes = memblk; //needs 90
  bassline.notes = drums.notes + 90 ; //needs 44
  sky.notes = bassline.notes + 44 ; // needs 129
  drums.realloc_notes();
  bassline.realloc_notes();
  sky.realloc_notes();
  //drums
  for(int i = 0; i < 4; i++)
  {
    drums.queue(&kick);
    drums.queue(&kick_rest);
    drums.queue(&rest);
    drums.queue(&rest);
    drums.queue(&kick);
    drums.queue(&kick_rest);
    drums.queue(&rest);
    drums.queue(&rest);
    drums.queue(&kick);
    drums.queue(&kick_rest);
    drums.queue(&rest);
    drums.queue(&rest);
    drums.queue(&rest);
    drums.queue(&kick);
    drums.queue(&kick_rest);
    switch(i)
    {
      case 0: case 2:
        drums.queue(&rest);
        break;
      case 1: case 3:
        drums.queue(&kick);
        drums.queue(&kick_rest);
      break;
    }
    drums.queue(&snare);
    drums.queue(&snare_rest);
    drums.queue(&rest);
    switch(i)
    {
      case 0:case 1:case 2:
        drums.queue(&kick);
        drums.queue(&kick_rest);
        break;
      case 3:
        drums.queue(&snare);
        drums.queue(&snare_rest);

        break;
    }
    drums.queue(&rest); 
  }
 // debug(drums.insert_at);
  ///HERE'S THE BASSLINE

  for(int i = 0; i < 2; i++)
  {
    bassline.queue(&gsharp);
    bassline.queue(&rest);
    bassline.queue(&rest);
    bassline.queue(&gsharp);
    bassline.queue(&rest);
    bassline.queue(&rest);
    bassline.queue(&gsharp4);
    bassline.queue(&gsharp2low);
    bassline.queue(&gsharp2high);
    bassline.queue(&gsharp2low);
    if (i==0)
    {
      bassline.queue(&transpose);
      bassline.queue(&transpose);
    }
  }
    bassline.queue(&transposed);
    bassline.queue(&transposed);
    bassline.queue(&c);
    bassline.queue(&rest);
    bassline.queue(&rest);
    bassline.queue(&c);
    bassline.queue(&rest);
    bassline.queue(&rest);
    bassline.queue(&c4);
    bassline.queue(&g2);
    bassline.queue(&c2);
    bassline.queue(&g2);
    ///
    bassline.queue(&lowc);
    bassline.queue(&rest);
    bassline.queue(&rest);
    bassline.queue(&lowc);
    bassline.queue(&rest);
    bassline.queue(&rest);
    bassline.queue(&lowc4);
    bassline.queue(&g2);
    bassline.queue(&c2);
    bassline.queue(&g2);
    
  


  //HERE'S THE SKY
  //HERE WE GO

  
  for(int i = 0; i < 4; i++)
  {
    sky.queue(&sc);
    sky.queue(&sgsharp);
    sky.queue(&sf);
    sky.queue(&sgsharp);
  }

  for(int i = 0; i < 4; i++)
  {
    sky.queue(&sc);
    sky.queue(&sasharp);
    sky.queue(&sf);
    sky.queue(&sgsharp);
  }

  
  for(int i = 0; i < 8; i++)
  {
    switch(i)
    {
      case 3:
      case 7:
      sky.queue(&sdu);
      break;
      case 4:
      case 6:
      sky.queue(&seu);
      break;
      case 5:
      sky.queue(&sfu);
      break;
      default:
      sky.queue(&sc);
    }
    sky.queue(&sg);
    sky.queue(&se);
    sky.queue(&sg);
  }
  
  for(int i = 0; i < 8; i++)
  {
    switch(i)
    {
      case 2:
      case 6:
        sky.queue(&sdu);
        break;
      case 3:
      case 7:
        sky.queue(&seu);
        break;
      default:
      sky.queue(&sc);
    }
    if (i<4)
      sky.queue(&sgsharp);
    else
      sky.queue(&sasharp);
    sky.queue(&sf);
    sky.queue(&sgsharp);
  }
  //SLIDE TIME

  sky.queue(&seu);
  sky.queue(&sc);
  sky.queue(&sg);
  sky.queue(&se);
  sky.queue(&scd);
  sky.queue(&se);
  sky.queue(&sg);
  sky.queue(&sc);
  ///
  sky.queue(&seu);
  sky.queue(&sgu);
  sky.queue(&seu);
  sky.queue(&sc);
  sky.queue(&sg);
  sky.queue(&se);
  sky.queue(&sg);
  sky.queue(&sc);
  //
  
  sky.queue(&seu);
  sky.queue(&sc);
  sky.queue(&sgu);
  sky.queue(&sc);
  sky.queue(&scu);
  sky.queue(&sbu);
  sky.queue(&sgu);
  sky.queue(&seu);
  sky.queue(&sc);
  sky.queue(&sg);   
  sky.queue(&se);
  sky.queue(&sg);
  sky.queue(&sc);
  sky.queue(&sg);
  sky.queue(&sc);
  sky.queue(&sd);
  
  //out of memory here

  sky.queue(&stop);
 m.play();
  
  sky.realloc_notes(); //here we go...
  //more standard-like
  for(int i = 0; i < 2; i++) {
  sky.queue(&sc);
  sky.queue(&sgsharp);
  sky.queue(&sf);
  sky.queue(&sgsharp);
  }
  sky.queue(&sc);
  sky.queue(&sdu);
  sky.queue(&sc);
  sky.queue(&sgsharp);
  sky.queue(&sf);
  sky.queue(&sgsharp);
  sky.queue(&sc);
  sky.queue(&sg);
  ///
 
  sky.queue(&sc);
  sky.queue(&sasharp);
  sky.queue(&sf);
  sky.queue(&sasharp);
  sky.queue(&sc);
  sky.queue(&sfu);
  sky.queue(&sc);
  sky.queue(&sasharp);
  sky.queue(&sf);
  sky.queue(&sasharp);
  sky.queue(&sc);
  sky.queue(&sfu);
  sky.queue(&sgsharpu);
  sky.queue(&sfu);
  sky.queue(&sc);
  sky.queue(&sfu); 
  //now measure 35
  sky.queue(&sc);
  sky.queue(&sg);
  sky.queue(&se);
  sky.queue(&sg);
  sky.queue(&sc);
  sky.queue(&seu);
  sky.queue(&sgu);
  sky.queue(&scu);
  sky.queue(&sgu);
  sky.queue(&seu);
  sky.queue(&sc);
  sky.queue(&sg);
  sky.queue(&se);
  sky.queue(&scd);
  sky.queue(&se);
  sky.queue(&sg);
  //36
  sky.queue(&sc);
  sky.queue(&seu);
  sky.queue(&sgu);
  sky.queue(&scu);
  sky.queue(&sgu);
  sky.queue(&seu);
  sky.queue(&sc);
  sky.queue(&sg);
  sky.queue(&sc);
  sky.queue(&sgu);
  sky.queue(&sc);
  sky.queue(&scu);
  sky.queue(&sgu);
  sky.queue(&sc);
  sky.queue(&scu);
  sky.queue(&sc);
  //37
  for(int i = 0; i < 4; i++)
  {
    sky.queue(&scu);
    sky.queue(&sgsharpu);
    sky.queue(&sfu);
    sky.queue(&sgsharpu);
  }
  //38

  for(int i = 0; i < 4; i++)
  {
    sky.queue(&sduu);
    sky.queue(&sasharpu);
    sky.queue(&sfu);
    sky.queue(&sasharpu);
  }
  
 
  sky.queue(&seuu);
  sky.queue(&scu);
  sky.queue(&sgu);
  sky.queue(&seu);
  sky.queue(&sc);
  sky.queue(&seu);
  sky.queue(&sgu);
  sky.queue(&scu);
  sky.queue(&seuu);
  sky.queue(&sguu);
  sky.queue(&seuu);
  sky.queue(&scu);
  sky.queue(&sgu);
  sky.queue(&scu);
  sky.queue(&seuu);
  sky.queue(&scu);

  sky.queue(&stop);
  m.play();
  
  sky.notes = memblk; //needs 3
  bassline.notes = sky.notes + 3 + 1; //needs 2
  drums.notes = bassline.notes + 2 + 1; //needs 2
  sky.realloc_notes();
  bassline.realloc_notes();
  drums.realloc_notes();
  //null notes

  drums.queue(&nulln);
  bassline.queue(&nulln);

  sky.queue(&scuu);
  sky.queue(&stop);
 m.play();
}
inline void pt1(channel& melody, channel& harmony, channel& skyline)
{

  

note transposed;
transposed.tone = TRANSPOSEDOWN;
transposed.duration = 0;


  note sc;
  sc.tone = 27;
  sc.duration = EIGHTH;
  
  note sg;
  sg.tone = 22;
  sg.duration = EIGHTH;
  
  note se;
  se.tone = 19;
  se.duration = EIGHTH;
  
  note sgsharp;
  sgsharp.tone = 23;
  sgsharp.duration = EIGHTH;
  note sf;
  sf.tone = 20;
  sf.duration = EIGHTH;
  
  note sd;
  sd.tone = 29;
  sd.duration = EIGHTH;
  
  
    note sasharp;
    sasharp.tone = 25;
    sasharp.duration = EIGHTH;
    
    ////////MELODY
note mclong;
mclong.tone = 3;
mclong.duration = EIGHTH * 10;

note melong;
melong.tone = 7;
melong.duration = EIGHTH * 10;

note mg;
mg.tone = -2;
mg.duration = EIGHTH * 2;

note hg;
hg.tone = 10;
hg.duration = EIGHTH*2;

note mc;
mc.tone = 3;
mc.duration = EIGHTH * 2;

note me;
me.tone = 7;
me.duration = EIGHTH * 2;

note mf;
mf.tone = 8;
mf.duration = EIGHTH * 4;


note md4;
md4.tone = 5;
md4.duration = EIGHTH * 4;

note me4;
me4.tone = 7;
me4.duration = EIGHTH * 4;

note mc4;
mc4.tone = 3;
mc4.duration = EIGHTH * 4;

note mchold;
mchold.tone = 3;
mchold.duration = EIGHTH * 24;
note mchold2;
mchold2.tone = 3;
mchold2.duration = EIGHTH*10;

note mghold;
mghold.tone = 10;
mghold.duration = EIGHTH * 24;
note mghold2;
mghold2.tone = 10;
mghold2.duration = EIGHTH*10;

note ma4;
ma4.tone = 12;
ma4.duration = EIGHTH * 4;

note mg4;
mg4.tone = 10;
mg4.duration = EIGHTH * 4;

note mgsharphold;
mgsharphold.tone = 11;
mgsharphold.duration = EIGHTH * 18; 

note masharphold;
masharphold.tone = 13;
masharphold.duration = EIGHTH * 16;

note mfhold;
mfhold.tone = 8;
mfhold.duration = EIGHTH * 16; 


//memblk =  (note**) malloc(sizeof(note*) * 265);
  melody.notes = memblk ;
  harmony.notes = melody.notes + 50 ; //melody needs 50 notes? round numbers
  skyline.notes = harmony.notes + 50 ; //harmony needs 50 note? round numbers
                                      //skyline needs 128 notes exact
                                      
     melody.realloc_notes();
  harmony.realloc_notes();
  skyline.realloc_notes();
for(int i = 0; i < 12; i++)
{
   harmony.queue(&transposed);
}
  for(int k = 0; k < 2; k++)
  {
    for(int i = 0; i < 8; i++)
    {
      skyline.queue(&sc);
      skyline.queue(&sg);
      skyline.queue(&se);
      skyline.queue(&sg);
    }

  

    for(int i = 0; i < 4; i++)
    {
      skyline.queue(&sc);
      skyline.queue(&sgsharp);
      skyline.queue(&sf);
      skyline.queue(&sgsharp);
    }
    for(int i = 0; i < 4; i++)
    {
      switch(k){
        case 0:
        skyline.queue(&sc);
        break;
        case 1:
        skyline.queue(&sd);
        break;
      }
      skyline.queue(&sasharp);
      skyline.queue(&sf);
      skyline.queue(&sasharp);
    }
  
  }


for(int i = 0; i < 2; i++)
{
  melody.queue(&mclong);
  harmony.queue(&melong);
  melody.queue(&mg);
  harmony.queue(&mc);
  melody.queue(&mc);
  harmony.queue(&me);
  melody.queue(&me);
  harmony.queue(&hg);
  melody.queue(&mf);
  harmony.queue(&ma4);
  melody.queue(&me);
  harmony.queue(&hg);
  melody.queue(&md4);
  harmony.queue(&mf);
  switch(i){
    case 0:
      melody.queue(&me4);
      harmony.queue(&mg4);
      melody.queue(&mchold);
      harmony.queue(&mgsharphold);
      harmony.queue(&mfhold);
      melody.queue(&mchold2);
      skyline.queue(&sc);
      break;
    case 1:
      melody.queue(&mc4);
      harmony.queue(&me4);
      melody.queue(&mghold);
      harmony.queue(&mgsharphold);
      melody.queue(&mghold2);
      harmony.queue(&masharphold);
      break; 
  }
}
note stop;
stop.tone = STOP;
stop.duration = 0;
  melody.queue(&stop);

  m.play();
  
}
inline void pt2(channel& melody, channel& bassline, channel& drums)
{
   ///OK HERES THE DRUM LOOP
  note kick;
  kick.tone = KICK;
  kick.duration = KICK_LEN;
  
  note kick_rest;
  kick_rest.tone = REST;
  kick_rest.duration = EIGHTH-KICK_LEN;
  
  note snare;
  snare.tone = SNARE;
  snare.duration = SNARE_LEN;
  
  note snare_rest;
  snare_rest.tone = REST;
  snare_rest.duration = EIGHTH-SNARE_LEN;
  
  note rest;
  rest.tone = REST;
  rest.duration = EIGHTH;
  
   drums.notes = memblk; //needs 90
   bassline.notes = drums.notes + 90; //needs 58
   melody.notes = bassline.notes + 58;

   drums.realloc_notes();
   bassline.realloc_notes();
   melody.realloc_notes();
    for(int i = 0; i < 4; i++)
  {
    drums.queue(&kick);
    drums.queue(&kick_rest);
    drums.queue(&rest);
    drums.queue(&rest);
    drums.queue(&kick);
    drums.queue(&kick_rest);
    drums.queue(&rest);
    drums.queue(&rest);
    drums.queue(&kick);
    drums.queue(&kick_rest);
    drums.queue(&rest);
    drums.queue(&rest);
    drums.queue(&rest);
    drums.queue(&kick);
    drums.queue(&kick_rest);
    switch(i)
    {
      case 0: case 2:
        drums.queue(&rest);
        break;
      case 1: case 3:
        drums.queue(&kick);
        drums.queue(&kick_rest);
      break;
    }
    drums.queue(&snare);
    drums.queue(&snare_rest);
    drums.queue(&rest);
    switch(i)
    {
      case 0:case 1:case 2:
        drums.queue(&kick);
        drums.queue(&kick_rest);
        break;
      case 3:
        drums.queue(&snare);
        drums.queue(&snare_rest);

        break;
    }
    drums.queue(&rest); 
  }
  //bassline
  ////
  ///
  note bc;
  bc.tone = -21;
  bc.duration = EIGHTH;
  
  note bc2;
  bc2.tone = -21;
  bc2.duration = EIGHTH * 2;
  
  note bchigh;
  bchigh.tone = -9;
  bchigh.duration = EIGHTH * 2;
  
  note bgsharp;
  bgsharp.tone = -13;
  bgsharp.duration = EIGHTH * 2;
  
  note basharp;
  basharp.tone = -11;
  basharp.duration = EIGHTH * 2;
    
for(int i = 0; i < 4; i++)
{
  for(int k = 0; k < 3; k++)
  {
    switch(i)
    {
      case 0:
      case 1:
      bassline.queue(&bc2);
      break;
      case 2:
      bassline.queue(&bgsharp);
      break;
      case 3:
      bassline.queue(&basharp);
      break;
      
    }
    bassline.queue(&rest); 

  }
    bassline.queue(&rest);
    switch(i)
    {
      case 0:
      case 1:
      bassline.queue(&bc2);
      break;
      case 2:
      bassline.queue(&bgsharp);

      break;
      case 3:
      bassline.queue(&basharp);

      break;
      
    }

bassline.queue(&bchigh);
    switch(i)
    {
      case 0:
      case 1:
      bassline.queue(&bc2);
      break;
      case 2:
      bassline.queue(&bgsharp);
      break;
      case 3:
      bassline.queue(&basharp);
      break;
      
    }
}
    
/*   bassline.queue(&bc2);
  bassline.queue(&bchigh);
 bassline.queue(&bc2);*/
    
  

//melody
note mch;
mch.tone=-9;
mch.duration = EIGHTH*10;
note mg;
mg.tone = -14;
mg.duration = EIGHTH*2;

note mg4;
mg4.tone = -14;
mg4.duration = EIGHTH*4;

note mg1;
mg1.tone = -14;
mg1.duration = EIGHTH*1;

note mgold;
mgold.tone = -2;
mgold.duration = EIGHTH * 12;

note mc;
mc.tone = -9;
mc.duration = EIGHTH * 2;

note mcsharp1;
mcsharp1.tone = -8;
mcsharp1.duration = EIGHTH;

note mc1;
mc1.tone = -9;
mc1.duration = EIGHTH * 1;

note mcl;
mcl.tone = -21;
mcl.duration = EIGHTH * 2;

note mc4;
mc4.tone = -9;
mc4.duration = EIGHTH * 4;

note me;
me.tone = -5;
me.duration = EIGHTH * 2;

note me1;
me1.tone = -5;
me1.duration = EIGHTH * 1;

note mel8;
mel8.tone = -17;
mel8.duration = EIGHTH * 8;

note mf4;
mf4.tone = -4;
mf4.duration = EIGHTH * 4;

note mfl1;
mfl1.tone = -16;
mfl1.duration = EIGHTH;

note mf;
mf.tone = -4;
mf.duration = EIGHTH * 2;

note mf1;
mf1.tone = -4;
mf1.duration = EIGHTH;


note md1;
md1.tone = -7;
md1.duration = EIGHTH;

note mdl;
mdl.tone = -19;
mdl.duration = EIGHTH * 2;
note md4;
md4.tone = -7;
md4.duration = EIGHTH * 4;

note me4;
me4.tone = -5;
me4.duration = EIGHTH * 4;

note mchh;
mchh.tone = -9;
mchh.duration = EIGHTH * 14;

note mcsecondhh;
mcsecondhh.tone = -9;
mcsecondhh.duration = EIGHTH * 8;

note soloON;
soloON.tone = SUPERSOLO;
soloON.duration = 1;

note soloOFF;
soloOFF.tone = SUPERSOLO;
soloOFF.duration = 0;

note mgsharp;
mgsharp.tone = -13;
mgsharp.duration = 2 * EIGHTH;

note mgsharp10;
mgsharp10.tone = -13;
mgsharp10.duration = 10 * EIGHTH;

note frest;
frest.tone = REST;
frest.duration = EIGHTH / 2;

note moreSOLO;
moreSOLO.tone = SUPERSOLO;
moreSOLO.duration = 1;

note stop;
stop.tone = STOP;
stop.duration = 0;


melody.queue(&mch);
melody.queue(&mg);
melody.queue(&mc);
melody.queue(&me);
melody.queue(&mf4);
melody.queue(&me);
melody.queue(&md4);

melody.queue(&me);
melody.queue(&soloON);
melody.queue(&me);
melody.queue(&soloOFF);
melody.queue(&mchh);
melody.queue(&rest);
melody.queue(&rest);
melody.queue(&rest);
melody.queue(&rest);
//m12

melody.queue(&mc4);
melody.queue(&mgsharp);
melody.queue(&mc4);
melody.queue(&md4);
melody.queue(&mc);

melody.queue(&mch);
melody.queue(&mg);
melody.queue(&mc);
melody.queue(&me);
//m13
melody.queue(&mf4);
melody.queue(&me);
melody.queue(&md4);
melody.queue(&mc4);
melody.queue(&mc);
//m14
melody.queue(&mgold);
melody.queue(&mf);
melody.queue(&me);
//m15
melody.queue(&mf1);
melody.queue(&me1);
melody.queue(&mc1);
melody.queue(&mg1);
melody.queue(&mg4);
melody.queue(&mg4);
///
melody.queue(&mf1);
melody.queue(&me1);
melody.queue(&moreSOLO);
melody.queue(&mc1);
melody.queue(&mg1);
melody.queue(&soloOFF);

//again
melody.queue(&mch);
melody.queue(&mg);
melody.queue(&mc);
melody.queue(&me);
melody.queue(&mf4);
melody.queue(&me);
melody.queue(&md4);

melody.queue(&me);

melody.queue(&moreSOLO);
melody.queue(&me1);
melody.queue(&me1);
melody.queue(&md1);
melody.queue(&mcsharp1);
melody.queue(&soloOFF);

melody.queue(&mcsecondhh);


melody.queue(&mc);
melody.queue(&mg);
melody.queue(&mc);
melody.queue(&mg);
melody.queue(&mgsharp10);
melody.queue(&mfl1);
melody.queue(&mfl1);
melody.queue(&mgsharp);
melody.queue(&mc);

melody.queue(&mg4);
melody.queue(&mg);
melody.queue(&mc4);

melody.queue(&mg);
melody.queue(&mc);
melody.queue(&me);
melody.queue(&mf4);
melody.queue(&me);
melody.queue(&md4);
melody.queue(&mc4);
melody.queue(&rest);
melody.queue(&mc1);

melody.queue(&mgold);
melody.queue(&mf);
melody.queue(&me);

melody.queue(&mf1);
melody.queue(&me1);
melody.queue(&mc1);
melody.queue(&mfl1);
melody.queue(&mel8);
melody.queue(&mdl);
melody.queue(&mcl);


melody.queue(&stop);
  m.play();
}
