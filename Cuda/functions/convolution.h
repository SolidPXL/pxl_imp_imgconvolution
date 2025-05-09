#ifndef CONVOLUTION_H
#define CONVOLUTION_H

#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include "tasklib.h"

int getPixel(int row, int column,int width, int channels);

void black_borders(uint8_t* dest, uint8_t* src, int width, int height, int channels);
__global__ void convolution_2d(RGB* dest, RGB* src, int width, int height, int N);

#endif