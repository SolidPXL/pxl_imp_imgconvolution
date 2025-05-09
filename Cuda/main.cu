
#include "functions/convolution.h"
#include "functions/pooling.h"
#include "cuda_runtime.h"
#include <math.h>

//compile command
// nvcc -G main.cu functions/convolution.cu functions/tasklib.cu functions/tasklib.cu -o main

#define STB_IMAGE_IMPLEMENTATION
#include "tools/stb_image.h"
#define STB_IMAGE_WRITE_IMPLEMENTATION
#include "tools/stb_image_write.h"


// usage: main.exe path_to_img.jpg -c path_to_convolution_output.jpg -p path_to_pooling_output.jpg
// -c flag to perform convolution and provide a path to the output file
// -p flag to perform max pooling and provide a path to the output file
// -a flag to perform average pooling and provide a path to the output file

int deviceIdx = 0;
cudaDeviceProp deviceProp;
	

int main(int argc, char* argv[]){
    char* file;
    int convolution_selected = 0;
    char* convolution_output;
    int max_pooling_selected = 0;
    char* max_pooling_output;
    int average_pooling_selected = 0;
    char* average_pooling_output;

    //cuda related tasks
	cudaSetDevice(deviceIdx);
	cudaGetDeviceProperties(&deviceProp, deviceIdx);
	printf("GPU is %s, index set is %d\n",deviceProp.name, deviceIdx);
    printf("Device has max %d threads per block\n",deviceProp.maxThreadsPerBlock);

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
        }
    }

    
    int width, height, channels;
    // Load the image into a buffer
    unsigned char* imageData = stbi_load(file, &width, &height, &channels, 0);

    //Gpu memory pointer used only if a function has to execute kernels on the original image, which is not every function
    uint8_t* imageData_gpu = NULL;
    if(max_pooling_selected||average_pooling_selected){
        cudaMalloc(&imageData_gpu,width*height*channels);
        cudaMemcpy(imageData_gpu, imageData, width * height * channels, cudaMemcpyHostToDevice);
    }

    

    //perform convolution
    if(convolution_selected){
        uint8_t* imageDataCopy; 
        cudaMallocManaged(&imageDataCopy,(width+4)*(height+4)*channels); //Basic size + borders(2px)

        //create black edges around image on CPU since it doesnt take as much compute time
        black_borders(imageDataCopy,imageData,width,height,channels);

        //perform convolution on GPU
        convolution_2d<<<8,16>>>(imageDataCopy,(width+4),(height+4),channels);

        //write image
        int success = stbi_write_jpg(convolution_output, width+4, height+4, 3, imageDataCopy, 90); // 90 is the quality

        if (success) {
            printf("Image saved successfully.\n");
        } else {
            printf("Failed to save image.\n");
        }

        // Clean up
        cudaFree(imageDataCopy);
    }
    //perform pooling
    if(max_pooling_selected){
        uint8_t* imageDataCopy;
        cudaMalloc(&imageDataCopy,(width/2)*(height/2)*channels); //half the original size
        image_pooling_max<<<8,16>>>(imageDataCopy,imageData,width,height,channels);

        //write image
        void* imageDataResult = malloc((width/2)*(height/2)*channels);
        cudaMemcpy(imageDataResult,imageDataCopy,(width/2)*(height/2)*channels,cudaMemcpyDeviceToHost);
        int success = stbi_write_jpg(max_pooling_output, width/2, height/2, 3, imageDataResult, 90); // 90 is the quality

        if (success) {
            printf("Image saved successfully.\n");
        } else {
            printf("Failed to save image.\n");
        }

        // Clean up
        free(imageDataResult);
        cudaFree(imageDataCopy);
    }
    if(average_pooling_selected){
        uint8_t* imageDataCopy;
        cudaMalloc(&imageDataCopy,(width/2)*(height/2)*channels); //Half the original size


        image_pooling_average<<<8,16>>>(imageDataCopy,imageData,width,height,channels);

        //write image
        void* imageDataResult = malloc((width/2)*(height/2)*channels);
        cudaMemcpy(imageDataResult,imageDataCopy,(width/2)*(height/2)*channels,cudaMemcpyDeviceToHost);
        int success = stbi_write_jpg(average_pooling_output, width/2, height/2, 3, imageDataResult, 90); // 90 is the quality

        if (success) {
            printf("Image saved successfully.\n");
        } else {
            printf("Failed to save image.\n");
        }
        // Clean up
        free(imageDataResult);
        cudaFree(imageDataCopy);
    }

    //write images



    //cleanup
    stbi_image_free(imageData);
    if(imageData_gpu!=NULL)cudaFree(imageData_gpu);

}