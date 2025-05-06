#include "convolution.h"
#include "tasklib.h"

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


__global__ void convolution_2d(uint8_t* imgData, int width, int height, int channels){
    uint8_t* result;
    cudaMalloc(&result,width*height*channels);
    for(int i=1;i<height-1;i++){
        //rows
        for(int j=1;j<width-1;j++){
            //columns
            for(int k=0;k<channels;k++){
                //channels

                result[getPixel_gpu(i,j,width,channels)+k] = 
                (imgData[getPixel_gpu(i-1,j-1,width,channels)+k]*convolution_matrix[0][0]) +
                (imgData[getPixel_gpu(i-1,j  ,width,channels)+k]*convolution_matrix[0][1]) +
                (imgData[getPixel_gpu(i-1,j+1,width,channels)+k]*convolution_matrix[0][2]) +
                (imgData[getPixel_gpu(i  ,j-1,width,channels)+k]*convolution_matrix[1][0]) +
                (imgData[getPixel_gpu(i  ,j  ,width,channels)+k]*convolution_matrix[1][1]) +
                (imgData[getPixel_gpu(i  ,j+1,width,channels)+k]*convolution_matrix[1][2]) +
                (imgData[getPixel_gpu(i+1,j-1,width,channels)+k]*convolution_matrix[2][0]) +
                (imgData[getPixel_gpu(i+1,j  ,width,channels)+k]*convolution_matrix[2][1]) +
                (imgData[getPixel_gpu(i+1,j+1,width,channels)+k]*convolution_matrix[2][2]);

            }
            

        }
    }
    memcpy(imgData,result,width*height*channels);
    free(result);
    
}