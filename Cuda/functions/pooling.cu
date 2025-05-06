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

__device__ int getAverage(char* arr, int size){
    int average = *arr;
    for(int i=1;i<size;i++){
        average += (arr[i] - average) / i;
    }
    return average;
}



__global__ void image_pooling_max(uint8_t* dest, uint8_t* imgData, int width, int height, int channels){
    for (int i=0;i<height/2;i++){
        for(int j=0;j<width/2;j++){
            //printf("on i %d j %d\n",i,j);
            //Red channel
            char pool[4];
            pool[0] = imgData[getPixel_gpu(i*2,j*2,width,channels)];
            pool[1] = imgData[getPixel_gpu((i*2)+1,j*2,width,channels)];
            pool[2] = imgData[getPixel_gpu(i*2,(j*2)+1,width,channels)];
            pool[3] = imgData[getPixel_gpu((i*2)+1,(j*2)+1,width,channels)];

            dest[getPixel_gpu(i,j,width/2,channels)] = getMax(pool,4);

            //Green channel
            pool[0] = imgData[getPixel_gpu(i*2,j*2,width,channels)+1];
            pool[1] = imgData[getPixel_gpu((i*2)+1,j*2,width,channels)+1];
            pool[2] = imgData[getPixel_gpu(i*2,(j*2)+1,width,channels)+1];
            pool[3] = imgData[getPixel_gpu((i*2)+1,(j*2)+1,width,channels)+1];

            dest[getPixel_gpu(i,j,width/2,channels)+1] = getMax(pool,4);

            //Blue channel
            pool[0] = imgData[getPixel_gpu(i*2,j*2,width,channels)+2];
            pool[1] = imgData[getPixel_gpu((i*2)+1,j*2,width,channels)+2];
            pool[2] = imgData[getPixel_gpu(i*2,(j*2)+1,width,channels)+2];
            pool[3] = imgData[getPixel_gpu((i*2)+1,(j*2)+1,width,channels)+2];

            dest[getPixel_gpu(i,j,width/2,channels)+2] = getMax(pool,4);

        }
    }
    
}

__global__ void image_pooling_average(uint8_t* dest, uint8_t* imgData, int width, int height, int channels){
    for (int i=0;i<height/2;i++){
        for(int j=0;j<width/2;j++){
            //printf("on i %d j %d\n",i,j);
            //Red channel
            char pool[4];
            pool[0] = imgData[getPixel_gpu(i*2,j*2,width,channels)];
            pool[1] = imgData[getPixel_gpu((i*2)+1,j*2,width,channels)];
            pool[2] = imgData[getPixel_gpu(i*2,(j*2)+1,width,channels)];
            pool[3] = imgData[getPixel_gpu((i*2)+1,(j*2)+1,width,channels)];

            dest[getPixel_gpu(i,j,width/2,channels)] = getAverage(pool,4);

            //Green channel
            pool[0] = imgData[getPixel_gpu(i*2,j*2,width,channels)+1];
            pool[1] = imgData[getPixel_gpu((i*2)+1,j*2,width,channels)+1];
            pool[2] = imgData[getPixel_gpu(i*2,(j*2)+1,width,channels)+1];
            pool[3] = imgData[getPixel_gpu((i*2)+1,(j*2)+1,width,channels)+1];

            dest[getPixel_gpu(i,j,width/2,channels)+1] = getAverage(pool,4);

            //Blue channel
            pool[0] = imgData[getPixel_gpu(i*2,j*2,width,channels)+2];
            pool[1] = imgData[getPixel_gpu((i*2)+1,j*2,width,channels)+2];
            pool[2] = imgData[getPixel_gpu(i*2,(j*2)+1,width,channels)+2];
            pool[3] = imgData[getPixel_gpu((i*2)+1,(j*2)+1,width,channels)+2];

            dest[getPixel_gpu(i,j,width/2,channels)+2] = getAverage(pool,4);

        }
    }
}