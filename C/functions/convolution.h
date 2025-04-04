#ifndef CONVOLUTION_H
#define CONVOLUTION_H

#include <stdlib.h>
#include <string.h>

int getPixel(int row, int column,int width, int channels);

void black_borders(char* dest, char* src, int width, int height, int channels);
void convolution_2d(char* imgData, int width, int height, int channels);

#endif