#ifndef POOLING_H
#define POOLING_H

#include <stdint.h>

__global__ void image_pooling_max(uint8_t* dest, uint8_t* src, int width, int height,int channels, int N);
__global__ void image_pooling_average(uint8_t* dest, uint8_t* src, int width, int height,int channels, int N);

#endif