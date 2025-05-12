#include "conv2d_edge.h"
#include "hls_stream.h"



void conv2d_edge(const pixel_t input[IMG_HEIGHT][IMG_WIDTH],
                 pixel_t output[IMG_HEIGHT - 2][IMG_WIDTH - 2]) {
#pragma HLS INTERFACE m_axi port=input offset=slave bundle=gmem0
#pragma HLS INTERFACE m_axi port=output offset=slave bundle=gmem1
#pragma HLS INTERFACE s_axilite port=input bundle=control
#pragma HLS INTERFACE s_axilite port=output bundle=control
#pragma HLS INTERFACE s_axilite port=return bundle=control


	// fixed kernel for edge detection
	const int kernel [3][3] = {
	        {1, 0, -1},
	        {1, 0, -1},
	        {1, 0, -1}
	};

	// line buffers for streaming optimalisation
	pixel_t linebuf[3][IMG_WIDTH];
#pragma HLS ARRAY_PARTITION variable=kernel type=complete dim=0
#pragma HLS ARRAY_PARTITION variable=linebuf type=complete dim=1

	// Convolution sliding window
	pixel_t window[3][3];
#pragma HLS ARRAY_PARTITION variable=window type=complete dim=0

	// start convolution
    for (int row = 0; row < IMG_HEIGHT; row++) {
        for (int col = 0; col < IMG_WIDTH; col++) {
#pragma HLS PIPELINE II=1

        	// shift row inside the linebuffer
            linebuf[0][col] = linebuf[1][col];
            linebuf[1][col] = linebuf[2][col];
            linebuf[2][col] = input[row][col];

            // wait for valid window[3][3]
            if (row >= 2 && col >= 2) {
            	// built 3*3 window
                for (int i = 0; i < 3; i++) {
#pragma HLS UNROLL
                    for (int j = 0; j < 3; j++) {
#pragma HLS UNROLL
                        window[i][j] = linebuf[i][col - 2 + j];
                    }
                }
                // Execute convolution
                int sum = 0;
                for (int i = 0; i < 3; i++) {
#pragma HLS UNROLL
                    for (int j = 0; j < 3; j++) {
#pragma HLS UNROLL
                        sum += (int)window[i][j] * kernel[i][j];
                    }
                }
                // amplify(test)
                sum = sum*8;
                // Clip to 0-255
                if (sum < 0) sum = 0;
                if (sum > 255) sum = 255;

                output[row - 2][col - 2] = (pixel_t)sum;
            }
        }
    }
}

/*
void conv2d_edge(const pixel_t input[IMG_HEIGHT][IMG_WIDTH],
                 pixel_t output[IMG_HEIGHT - 2][IMG_WIDTH - 2]) {
    // Fixed kernel for edge detection
    const int kernel[3][3] = {
        {-1, -1, -1},
        {-1,  8, -1},
        {-1, -1, -1}
    };

    for (int row = 1; row < IMG_HEIGHT - 1; row++) {
        for (int col = 1; col < IMG_WIDTH - 1; col++) {
            int sum = 0;
            for (int i = -1; i <= 1; i++) {
                for (int j = -1; j <= 1; j++) {
                    sum += input[row + i][col + j] * kernel[i + 1][j + 1];
                }
            }

            // Amplify (optional for testing)
            sum *= 2;

            // Clamp
            if (sum < 0) sum = 0;
            if (sum > 255) sum = 255;

            output[row - 1][col - 1] = (pixel_t)sum;
        }
    }
}
*/

