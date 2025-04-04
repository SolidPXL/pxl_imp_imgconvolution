#ifndef POOLING_H
#define POOLING_H

void image_pooling_max(char* imgData, int width, int height, int channels, char* output);
void image_pooling_min(char* imgData, int width, int height, int channels, char* output);

#endif