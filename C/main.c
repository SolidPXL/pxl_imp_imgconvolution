
#include "functions/convolution.h"
#include "functions/pooling.h"

#define STB_IMAGE_IMPLEMENTATION
#include "tools/stb_image.h"
#define STB_IMAGE_WRITE_IMPLEMENTATION
#include "tools/stb_image_write.h"


// usage: main.exe path_to_img.jpg -c path_to_convolution_output.jpg -p path_to_pooling_output.jpg
// -c flag to perform convolution and provide a path to the output file
// -p flag to perform pooling and provide a path to the output file

int main(int argc, char* argv[]){
    char* file;
    int convolution_selected = 0;
    char* convolution_output;
    int pooling_selected = 0;
    char* pooling_output;

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
        } else if(strcmp(argv[i],"-p")==0){
            pooling_selected = 1;
            pooling_output = argv[i+1];
        }
    }

    
    int width, height, channels;
    // Load the image into a buffer
    unsigned char* imageData = stbi_load("image.jpg", &width, &height, &channels, 0);

    //perform convolution
    if(convolution_selected){
        convolution_2d(imageData,width,height,channels,convolution_output);
    }
    //perform pooling
    if(pooling_selected){
        image_pooling(imageData,width,height,channels,pooling_output);
    }

    //cleanup
    stbi_image_free(imageData);

}