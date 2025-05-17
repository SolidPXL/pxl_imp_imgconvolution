#ifndef POOLING_H
#define POOLING_H

#include "ap_int.h"

#define WIDTH 256
#define HEIGHT 256
#define OUT_WIDTH (WIDTH / 2)
#define OUT_HEIGHT (HEIGHT / 2)

typedef ap_uint<8> pixel_t;

void image_pooling(pixel_t src[HEIGHT * WIDTH],
                   pixel_t dst_min[(HEIGHT / 2) * (WIDTH / 2)],
                   pixel_t dst_max[(HEIGHT / 2) * (WIDTH / 2)]) ;

#endif // POOLING_H
