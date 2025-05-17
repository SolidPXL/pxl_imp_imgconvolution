#ifndef CONV2D_EDGE_H
#define CONV2D_EDGE_H

#include "ap_int.h"

#define IMG_HEIGHT 256
#define IMG_WIDTH 256

typedef ap_uint<8> pixel_t;

void conv2d_edge(const pixel_t input[IMG_HEIGHT][IMG_WIDTH], pixel_t output[IMG_HEIGHT-2][IMG_WIDTH-2]) ;

#endif // CONV2D_EDGE_H
