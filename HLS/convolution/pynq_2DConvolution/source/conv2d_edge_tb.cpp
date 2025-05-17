#include <iostream>

#include "conv2d_edge.h"
#define STB_IMAGE_IMPLEMENTATION
#include "stb_image.h"

#define STB_IMAGE_WRITE_IMPLEMENTATION
#include "stb_image_write.h"

int main() {
    // Load image
    int width, height, channels;
    unsigned char* img_data = stbi_load("test1.PNG", &width, &height, &channels, 1); // force grayscale

    if (!img_data) {
        std::cerr << "Failed to load image\n";
        return 1;
    }

    std::cout << "Image loaded: " << width << "x" << height << "\n";

    // Sanity check
    if (width < IMG_WIDTH || height < IMG_HEIGHT) {
        std::cerr << "Loaded image is smaller than expected IMG_WIDTH/IMG_HEIGHT\n";
        stbi_image_free(img_data);
        return 1;
    }

    // Fill input array
    pixel_t input[IMG_HEIGHT][IMG_WIDTH] = {0};
    pixel_t output[IMG_HEIGHT - 2][IMG_WIDTH - 2] = {0};

    for (int i = 0; i < IMG_HEIGHT; i++) {
        for (int j = 0; j < IMG_WIDTH; j++) {
            input[i][j] = img_data[i * width + j];
        }
    }

    stbi_image_free(img_data);

    // Run your edge detection
    conv2d_edge(input, output);

    // Print sample output for verification
    std::cout << "Output check (center 10x10):\n";
    for (int i = IMG_HEIGHT / 2 - 5; i < IMG_HEIGHT / 2 + 5; i++) {
        for (int j = IMG_WIDTH / 2 - 5; j < IMG_WIDTH / 2 + 5; j++) {
            std::cout << (int)output[i][j] << " ";
        }
        std::cout << "\n";
    }

    stbi_write_png("output.png", IMG_WIDTH - 2, IMG_HEIGHT - 2, 1, output, IMG_WIDTH - 2);
    std::cout << "Output image saved as output.png\n";

    return 0;
}
