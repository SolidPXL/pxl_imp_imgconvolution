#include <iostream>
#include <cstdlib>
#include "ap_int.h"
#include "pooling.h"

#define STB_IMAGE_IMPLEMENTATION
#include "stb_image.h"

#define STB_IMAGE_WRITE_IMPLEMENTATION
#include "stb_image_write.h"

void print_image(pixel_t* img, int width, int height, const char* title) {
    std::cout << "=== " << title << " ===\n";
    for (int r = 0; r < height; r++) {
        for (int c = 0; c < width; c++) {
            std::cout << "[" << (int)img[r * width + c] << "] ";
        }
        std::cout << "\n";
    }
}

int main() {
    int width, height, channels;

    // Load image as grayscale (force_channels = 1)
    unsigned char* img_data = stbi_load("test1.png", &width, &height, &channels, 1);
    if (!img_data) {
        std::cerr << "Error loading image.\n";
        return 1;
    }

    // Check image dimensions
    if (width != WIDTH || height != HEIGHT) {
        std::cerr << "Image must be exactly " << WIDTH << "x" << HEIGHT << " (got " << width << "x" << height << ").\n";
        stbi_image_free(img_data);
        return 1;
    }

    std::cout << "Image loaded: " << width << "x" << height << ", channels: " << channels << "\n";

    // HLS arrays
    pixel_t input[HEIGHT * WIDTH] = {0};
    pixel_t output_min[OUT_HEIGHT * OUT_WIDTH] = {0};
    pixel_t output_max[OUT_HEIGHT * OUT_WIDTH] = {0};

    // Copy image data to input array
    for (int i = 0; i < HEIGHT * WIDTH; i++) {
        input[i] = static_cast<pixel_t>(img_data[i]);
    }

    // Run pooling function
    image_pooling(input, output_min, output_max);

    // Print debug output
    print_image(output_min, OUT_WIDTH, OUT_HEIGHT, "Min pooling");
    print_image(output_max, OUT_WIDTH, OUT_HEIGHT, "Max pooling");

    // Save output images
    unsigned char* out_img = new unsigned char[OUT_WIDTH * OUT_HEIGHT];

    for (int i = 0; i < OUT_WIDTH * OUT_HEIGHT; i++) {
        out_img[i] = static_cast<unsigned char>(output_min[i]);
    }
    stbi_write_png("out_min.png", OUT_WIDTH, OUT_HEIGHT, 1, out_img, OUT_WIDTH);

    for (int i = 0; i < OUT_WIDTH * OUT_HEIGHT; i++) {
        out_img[i] = static_cast<unsigned char>(output_max[i]);
    }
    stbi_write_png("out_max.png", OUT_WIDTH, OUT_HEIGHT, 1, out_img, OUT_WIDTH);

    std::cout << " Results saved as out_min.png and out_max.png\n";

    // Clean up
    delete[] out_img;
    stbi_image_free(img_data);

    return 0;
}
