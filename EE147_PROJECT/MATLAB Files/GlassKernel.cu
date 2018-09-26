#include <stdio.h>
#include <stdlib.h>


__global__ void VecAdd(float *color, unsigned int atoms)
 {
     int j = threadIdx.x +blockDim.x *blockIdx.x;
        
	if(j < atoms) //if index is less than 104014
          {
         	 if(color[j] < 0.45)  //if Array is less 45%
                  {
                  	color[j] = .000001; //then the glass is all shattered 
                  }
           } 
}

