// pooling.cpp

#include "pooling.h"
#include "hls_stream.h"
#include "ap_axi_sdata.h"

void shift_linebuf(pixel_t linebuf[2][WIDTH], int col, pixel_t new_pixel) {
#pragma HLS INLINE
    linebuf[0][col] = linebuf[1][col];
    linebuf[1][col] = new_pixel;
}

void fill_window(pixel_t window[2][2], pixel_t linebuf[2][WIDTH], int col) {
#pragma HLS INLINE
    window[0][0] = linebuf[0][col - 1];
    window[0][1] = linebuf[0][col];
    window[1][0] = linebuf[1][col - 1];
    window[1][1] = linebuf[1][col];
}

void calc_max(pixel_t window[2][2], pixel_t &max_val) {
    #pragma HLS INLINE
    pixel_t max1 = (window[0][0] > window[0][1]) ? window[0][0] : window[0][1];
    pixel_t max2 = (window[1][0] > window[1][1]) ? window[1][0] : window[1][1];
    max_val = (max1 > max2) ? max1 : max2;
}

void calc_min(pixel_t window[2][2], pixel_t &min_val) {
    #pragma HLS INLINE
    pixel_t min1 = (window[0][0] < window[0][1]) ? window[0][0] : window[0][1];
    pixel_t min2 = (window[1][0] < window[1][1]) ? window[1][0] : window[1][1];
    min_val = (min1 < min2) ? min1 : min2;
}

void pooling_2x2(pixel_t window[2][2], pixel_t &min_val, pixel_t &max_val) {
    //#pragma HLS INLINE
    #pragma HLS DATAFLOW

    // Calculate min and max concurrently
    calc_max(window, max_val);
    calc_min(window, min_val);
}




void image_pooling(pixel_t src[HEIGHT * WIDTH],
                   pixel_t dst_min[(HEIGHT / 2) * (WIDTH / 2)],
                   pixel_t dst_max[(HEIGHT / 2) * (WIDTH / 2)]) {
#pragma HLS INTERFACE m_axi port=src     offset=slave bundle=gmem
#pragma HLS INTERFACE m_axi port=dst_min offset=slave bundle=gmem
#pragma HLS INTERFACE m_axi port=dst_max offset=slave bundle=gmem
#pragma HLS INTERFACE s_axilite port=src     bundle=control
#pragma HLS INTERFACE s_axilite port=dst_min bundle=control
#pragma HLS INTERFACE s_axilite port=dst_max bundle=control
#pragma HLS INTERFACE s_axilite port=return  bundle=control

    pixel_t linebuf[2][WIDTH];
#pragma HLS ARRAY_PARTITION variable=linebuf block factor=2 dim=1

    pixel_t window[2][2];
#pragma HLS ARRAY_PARTITION variable=window complete dim=0

    int dst_row = 0;
    int dst_col = 0;

LOOP_ROW:
    for (int row = 0; row < HEIGHT; row++) {
    LOOP_COL:
        for (int col = 0; col < WIDTH; col++) {
#pragma HLS PIPELINE II=3

            pixel_t current = src[row * WIDTH + col];
            shift_linebuf(linebuf, col, current);


            if (row % 2 == 1 && col % 2 == 1) {
                fill_window(window, linebuf, col);

                pixel_t min_val, max_val;
                pooling_2x2(window, min_val, max_val);
                if (dst_row < OUT_HEIGHT && dst_col < OUT_WIDTH) {
					int out_idx = dst_row * (WIDTH / 2) + dst_col;
					dst_min[out_idx] = min_val;
					dst_max[out_idx] = max_val;

					dst_col++;
					if (dst_col == OUT_WIDTH) {
						dst_col = 0;
						dst_row++;
					}
                }
            }
        }
    }
}
