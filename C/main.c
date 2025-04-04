
#include "functions/convolution.h"
#include "functions/pooling.h"
#include <math.h>

#define STB_IMAGE_IMPLEMENTATION
#include "tools/stb_image.h"
#define STB_IMAGE_WRITE_IMPLEMENTATION
#include "tools/stb_image_write.h"


// usage: main.exe path_to_img.jpg -c path_to_convolution_output.jpg -p path_to_pooling_output.jpg
// -c flag to perform convolution and provide a path to the output file
// -p flag to perform max pooling and provide a path to the output file
// -m flag to perform min pooling and provide a path to the output file

int main(int argc, char* argv[]){
    char* file;
    int convolution_selected = 0;
    char* convolution_output;
    int max_pooling_selected = 0;
    char* max_pooling_output;
    int min_pooling_selected = 0;
    char* min_pooling_output;

    //argument parsing
    if(argc<2){
        //not enough arguments provided
    }
    file = argv[1];

    //load arguments
    for(int i=2;i<argc;i++){
        if(strcmp(argv[i],"-c")==0){
            convolution_selected = 1;
            convolution_output = argv[i+1];
            //printf("selected convolution and saving to %s\n",argv[i+1]);
        } else if(strcmp(argv[i],"-p")==0){
            max_pooling_selected = 1;
            max_pooling_output = argv[i+1];
        } else if(strcmp(argv[i],"-m")==0){
            min_pooling_selected = 1;
            min_pooling_output = argv[i+1];
        }
    }

    
    int width, height, channels;
    // Load the image into a buffer
    unsigned char* imageData = stbi_load(file, &width, &height, &channels, 0);
    //printf("loaded img\n");

    //perform convolution
    if(convolution_selected){
        unsigned char* imageDataCopy = malloc((width+4)*(height+4)*channels); //Basic size + borders(2px)
        //create black edges around image
        black_borders(imageDataCopy,imageData,width,height,channels);

        //perform convolution
        convolution_2d(imageDataCopy,(width+4),(height+4),channels);

        //write image
        int success = stbi_write_jpg(convolution_output, width+4, height+4, 3, imageDataCopy, 90); // 90 is the quality

        if (success) {
            printf("Image saved successfully.\n");
        } else {
            printf("Failed to save image.\n");
        }

        // Clean up
        free(imageDataCopy);
    }
    //perform pooling
    if(max_pooling_selected){
        image_pooling_max(imageData,width,height,channels,max_pooling_output);
    }
    //perform pooling
    if(min_pooling_selected){
        image_pooling_min(imageData,width,height,channels,max_pooling_output);
    }


    //cleanup
    stbi_image_free(imageData);

}