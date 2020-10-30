#include "dsk6713_aic23.h"
#include <dsk6713_dip.h>
#include "ringmod.h"
#include <math.h>


#define DSK6713_AIC23_MIC 0x0015
#define LEFT 0
#define RIGHT 1
#define PI 3.14159265

Uint32 fs=DSK6713_AIC23_FREQ_44KHZ;
Uint16 inputsource = DSK6713_AIC23_MIC;

union AIC_data{
	Uint32 uint;
	short channel[2];
} ;

int index=0; 							

union AIC_data RingMod(union AIC_data input){
int i;	
int j;
double sine;
for (j=0; j<2; j++)	{ 		 
    i = abs(input.channel[j]);             
                      
	if(input.channel[j] > 0)
  		input.channel[j] = diode[1][i];
	else 
		input.channel[j] = -diode[1][i];	
}
	sine = sine_matrix[index] * ((float)(input.channel[LEFT])/32768.0f);
  
  	if(input.channel[LEFT] != 0){
  		if(input.channel[LEFT] + sine > 32767){
    		input.channel[LEFT] = 32767;
		}
		else if(input.channel[LEFT] + sine < -32768){
			input.channel[LEFT] = -32768;
		}
		else{
			input.channel[LEFT] = input.channel[LEFT] + sine;
		}
	}
	if(input.channel[RIGHT] != 0){
    	if(input.channel[RIGHT] + sine > 32767){
        		input.channel[RIGHT] = 32767;
		}
		else if(input.channel[RIGHT] + sine < -32768){
				input.channel[RIGHT] = -32768;
		}
		else{
			input.channel[RIGHT] = input.channel[RIGHT] + sine;
		}
	}
return input;
}

void main ()
{
	union AIC_data aicSample;
	comm_poll();
	DSK6713_DIP_init();
	DSK6713_LED_init();
	while(1)
	{
		aicSample.uint = input_sample();   				
		if(DSK6713_DIP_get(1)==1)
		{
			index++;
			if(index >= 1470) index = 0;
		    aicSample = RingMod(aicSample);
			DSK6713_LED_on(1);
		}
		else 
		{
			DSK6713_LED_off(1);
		}
		output_sample(aicSample.uint);
	}
}

