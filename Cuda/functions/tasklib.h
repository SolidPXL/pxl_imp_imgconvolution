#ifndef TASKLIB_H
#define TASKLIB_H

#include <stdint.h>

typedef struct {
    unsigned char r;
    unsigned char g;
    unsigned char b;
} RGB;

inline int getPixel(int row, int column,int width, int channels);

__device__ inline int32_t getPixel_gpu(int32_t row, int32_t column,int32_t width,uint32_t channels){
    return (row*width*channels)+(column*channels);
}

__device__ inline int32_t clamp_gpu(int32_t i, int32_t min,int32_t max){
    if(i<min) return min;
    if(i>max) return max;
    return i;
}

#endif