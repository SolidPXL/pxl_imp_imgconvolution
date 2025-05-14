#include "pooling.h"
#include "tasklib.h"

#include <stdio.h>

__device__ int getMax(char* arr, int size){
    int max = *arr;
    for(int i=1;i<size;i++){
        if(arr[i]>max){
            max = arr[i];
        }
    }
    return max;
}

__device__ int getMin(char* arr, int size){
    int min = *arr;
    for(int i=1;i<size;i++){
        if(arr[i]<min){
            min = arr[i];
        }
    }
    return min;
}

__device__ int getAverage(char* arr, int size){
    int average = *arr;
    for(int i=1;i<size;i++){
        average += (arr[i] - average) / i;
    }
    return average;
}



__global__ void image_pooling_max(uint8_t* dest, uint8_t* src, int width, int height,int channels, int N){

    for (int i = (blockIdx.x * blockDim.x + threadIdx.x);i < N;i += blockDim.x * gridDim.x) 
    {
        char pool[4];
        int row = i/((width/2)*channels);
        int column = (i-(row*(width/2)*channels))/channels;
        int channel = i%channels;

        pool[0] = src[getPixel_gpu(clamp_gpu(2*row,0,height),clamp_gpu(2*column,0,width),width,channels)+channel];
        pool[1] = src[getPixel_gpu(clamp_gpu(2*row,0,height),clamp_gpu((2*column)+1,0,width),width,channels)+channel];
        pool[2] = src[getPixel_gpu(clamp_gpu((2*row)+1,0,height),clamp_gpu(2*column,0,width),width,channels)+channel];
        pool[3] = src[getPixel_gpu(clamp_gpu((2*row)+1,0,height),clamp_gpu((2*column)+1,0,width),width,channels)+channel];

        dest[getPixel_gpu(row,column,width/2,channels)+channel] = getMax(pool,4);
    }
    
}

__global__ void image_pooling_min(uint8_t* dest, uint8_t* src, int width, int height,int channels, int N){
    for (int i = (blockIdx.x * blockDim.x + threadIdx.x);i < N;i += blockDim.x * gridDim.x) 
    {
        char pool[4];
        int row = i/((width/2)*channels);
        int column = (i-(row*(width/2)*channels))/channels;
        int channel = i%channels;

        pool[0] = src[getPixel_gpu(clamp_gpu(2*row,0,height),clamp_gpu(2*column,0,width),width,channels)+channel];
        pool[1] = src[getPixel_gpu(clamp_gpu(2*row,0,height),clamp_gpu((2*column)+1,0,width),width,channels)+channel];
        pool[2] = src[getPixel_gpu(clamp_gpu((2*row)+1,0,height),clamp_gpu(2*column,0,width),width,channels)+channel];
        pool[3] = src[getPixel_gpu(clamp_gpu((2*row)+1,0,height),clamp_gpu((2*column)+1,0,width),width,channels)+channel];

        dest[getPixel_gpu(row,column,width/2,channels)+channel] = getMin(pool,4);
    }
    
}

__global__ void image_pooling_average(uint8_t* dest, uint8_t* src, int width, int height,int channels, int N){
    for (int i = (blockIdx.x * blockDim.x + threadIdx.x);i < N;i += blockDim.x * gridDim.x) 
    {
        char pool[4];
        int row = i/((width/2)*channels);
        int column = (i-(row*(width/2)*channels))/channels;
        int channel = i%channels;

        pool[0] = src[getPixel_gpu(clamp_gpu(2*row,0,height),clamp_gpu(2*column,0,width),width,channels)+channel];
        pool[1] = src[getPixel_gpu(clamp_gpu(2*row,0,height),clamp_gpu((2*column)+1,0,width),width,channels)+channel];
        pool[2] = src[getPixel_gpu(clamp_gpu((2*row)+1,0,height),clamp_gpu(2*column,0,width),width,channels)+channel];
        pool[3] = src[getPixel_gpu(clamp_gpu((2*row)+1,0,height),clamp_gpu((2*column)+1,0,width),width,channels)+channel];

        dest[getPixel_gpu(row,column,width/2,channels)+channel] = getAverage(pool,4);
    }
}