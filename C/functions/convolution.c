#include "convolution.h"



void black_borders(char* dest, char* src, int width, int height, int channels){
    //set buffer to black
    int new_width = width+4;
    int new_height = height + 4;

    memset(dest,0,new_height*new_width);

    //copy row per row
    for(int i=0;i<height;i++){
        memcpy(dest+((((i+2)*new_width)+2)*channels),src+((i*width)*channels),width*channels);
    }
}

void convolution_2d(char* imgData, int width, int height, int channels){
    
}