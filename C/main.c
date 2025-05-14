
#include "functions/convolution.h"
#include "functions/pooling.h"
#include <math.h>

//compile using 
//gcc main.c -g -pg -O functions/tasklib.c functions/convolution.c functions/pooling.c -o main -lm

#define STB_IMAGE_IMPLEMENTATION
#include "tools/stb_image.h"
#define STB_IMAGE_WRITE_IMPLEMENTATION
#include "tools/stb_image_write.h"


// usage: main.exe path_to_img.jpg -c path_to_convolution_output.jpg -p path_to_pooling_output.jpg -a path_to_averagePool_output.jpg
// -c flag to perform convolution and provide a path to the output file
// -p flag to perform max pooling and provide a path to the output file
// -a flag to perform average pooling and provide a path to the output file

//./main img3.jpg -c img3_convolution.jpg -p img3_maxpooled.jpg -a img3_avgpooled.jpg -m img3_minpooled.jpg

//profiling
//gprof ./main gmon.out > report.txt

int main(int argc, char* argv[]){
    char* file;
    int convolution_selected = 0;
    char* convolution_output;
    int max_pooling_selected = 0;
    char* max_pooling_output;
    int min_pooling_selected = 0;
    char* min_pooling_output;
    int average_pooling_selected = 0;
    char* average_pooling_output;

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
        } else if(strcmp(argv[i],"-a")==0){
            average_pooling_selected = 1;
            average_pooling_output = argv[i+1];
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
            //printf("Image saved successfully.\n");
        } else {
            printf("Failed to save image.\n");
        }

        // Clean up
        free(imageDataCopy);
    }
    //perform pooling
    if(max_pooling_selected){
        unsigned char* imageDataCopy = malloc((width/2)*(height/2)*channels); //Basic size + borders(2px)
        image_pooling_max(imageDataCopy,imageData,width,height,channels);

        //write image
        int success = stbi_write_jpg(max_pooling_output, width/2, height/2, 3, imageDataCopy, 90); // 90 is the quality

        if (success) {
            //printf("Image saved successfully.\n");
        } else {
            printf("Failed to save image.\n");
        }

        // Clean up
        free(imageDataCopy);
    }
    if(min_pooling_selected){
        unsigned char* imageDataCopy = malloc((width/2)*(height/2)*channels); //Basic size + borders(2px)
        image_pooling_min(imageDataCopy,imageData,width,height,channels);

        //write image
        int success = stbi_write_jpg(min_pooling_output, width/2, height/2, 3, imageDataCopy, 90); // 90 is the quality

        if (success) {
            //printf("Image saved successfully.\n");
        } else {
            printf("Failed to save image.\n");
        }

        // Clean up
        free(imageDataCopy);
    }
    //perform pooling
    if(average_pooling_selected){
        unsigned char* imageDataCopy = malloc((width/2)*(height/2)*channels); //Basic size + borders(2px)
        image_pooling_average(imageDataCopy,imageData,width,height,channels);

        //write image
        int success = stbi_write_jpg(average_pooling_output, width/2, height/2, 3, imageDataCopy, 90); // 90 is the quality

        if (success) {
            //printf("Image saved successfully.\n");
        } else {
            printf("Failed to save image.\n");
        }
    }


    //cleanup
    stbi_image_free(imageData);

}