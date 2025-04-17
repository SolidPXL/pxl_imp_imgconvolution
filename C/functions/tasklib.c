#include "tasklib.h"

int getPixel(int row, int column,int width, int channels){
    return (row*width*channels)+(column*channels);
}