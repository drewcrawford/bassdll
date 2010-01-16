/*
 *  debug.c
 *  
 *
 *  Created by Drew Crawford on 1/15/10.
 *  Copyright 2010 __MyCompanyName__. All rights reserved.
 *
 */

#include "debug.h"

void debug(uint64_t d)
{
	pinMode(13,OUTPUT);
	uint64_t old = d;
	
	
	while(true)
	{
		d = old;
		for(int i = 0; i < 10; i++)
		{
			digitalWrite(13,HIGH);
			delay(100);
			digitalWrite(13,LOW);
			delay(100);
			int a = 0;
		}
		const uint64_t LSB_Mask(1);
		for ( uint64_t v(d); v != 0; v >>= 1 )
		{
			boolean display = !(v & LSB_Mask);
			
			digitalWrite(13,display);
			delay(2000);
			if (display==HIGH)
				digitalWrite(13,LOW);
			else
				digitalWrite(13,HIGH);
			delay(50);
			if (d==0)
				break;
		}
	}
	
}