#include "convolution.h"
#include "tasklib.h"
#include <stdio.h>

__device__ float convolution_matrix[3][3]={{-1.0f,1.0f,-1.0f},{1.0f,0.0f,1.0f},{-1.0f,1.0f,-1.0f}};

void black_borders(uint8_t* dest, uint8_t* src, int width, int height, int channels){
    //set buffer to black
    int new_width = width+4;
    int new_height = height + 4;

    memset(dest,0,new_height*new_width);

    //copy row per row
    for(int i=0;i<height;i++){
        uint8_t* destStartAddr = dest + ((i+2)*new_width*channels) + 6;
        uint8_t* sourceStartAddr = src + (i*width*channels);
        memcpy(destStartAddr,sourceStartAddr,width*channels);
    }
}


__global__ void convolution_2d(uint8_t* dest, uint8_t* src, int width, int height,int channels, int N){

    for (int i = (blockIdx.x * blockDim.x + threadIdx.x);i < N;i += blockDim.x * gridDim.x) 
    {
        int row = i/(width*channels);
        int column = (i-(row*width*channels))/channels;
        int channel = i%channels;

        dest[i] = 
        convolution_matrix[0][0]*src[getPixel_gpu(clamp_gpu(row-1,0,height),clamp_gpu(column-1,0,width),width,channels)+channel] +
        convolution_matrix[0][1]*src[getPixel_gpu(clamp_gpu(row-1,0,height),clamp_gpu(column  ,0,width),width,channels)+channel] +
        convolution_matrix[0][2]*src[getPixel_gpu(clamp_gpu(row-1,0,height),clamp_gpu(column+1,0,width),width,channels)+channel] +
        convolution_matrix[1][0]*src[getPixel_gpu(clamp_gpu(row  ,0,height),clamp_gpu(column-1,0,width),width,channels)+channel] +
        convolution_matrix[1][1]*src[getPixel_gpu(clamp_gpu(row  ,0,height),clamp_gpu(column  ,0,width),width,channels)+channel] +
        convolution_matrix[1][2]*src[getPixel_gpu(clamp_gpu(row  ,0,height),clamp_gpu(column+1,0,width),width,channels)+channel] +
        convolution_matrix[2][0]*src[getPixel_gpu(clamp_gpu(row+1,0,height),clamp_gpu(column-1,0,width),width,channels)+channel] +
        convolution_matrix[2][1]*src[getPixel_gpu(clamp_gpu(row+1,0,height),clamp_gpu(column  ,0,width),width,channels)+channel] +
        convolution_matrix[2][2]*src[getPixel_gpu(clamp_gpu(row+1,0,height),clamp_gpu(column+1,0,width),width,channels)+channel];
    }
    
}