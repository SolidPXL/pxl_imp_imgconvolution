#ifndef POOLING_H
#define POOLING_H

void image_pooling_max(char* dest, char* imgData, int width, int height, int channels);
void image_pooling_average(char* dest, char* imgData, int width, int height, int channels);

#endif