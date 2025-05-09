#ifndef TASKLIB_H
#define TASKLIB_H

inline int getPixel(int row, int column,int width, int channels);
__device__ inline int getPixel_gpu(int row, int column,int width, int channels){
    return (row*width*channels)+(column*channels);
}

#endif