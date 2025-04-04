#ifndef CONVOLUTION_H
#define CONVOLUTION_H

#include <stdlib.h>
#include <string.h>

int convolution_matrix[3][3]={};

void black_borders(char* dest, char* src, int width, int height, int channels);
void convolution_2d(char* imgData, int width, int height, int channels);

#endif