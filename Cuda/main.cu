
#include "functions/convolution.h"
#include "functions/pooling.h"
#include "cuda_runtime.h"
#include <math.h>

//compile command
// nvcc -G main.cu functions/convolution.cu functions/pooling.cu functions/tasklib.cu functions/tasklib.cu -o main

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
    int min_pooling_selected = 0;
    char* min_pooling_output;
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
        } else if(strcmp(argv[i],"-m")==0){
            min_pooling_selected = 1;
            min_pooling_output = argv[i+1];
        }
    }

    
    int width, height, channels;
    // Load the image into a buffer
    unsigned char* imageData = stbi_load(file, &width, &height, &channels, 0);

    //Gpu memory pointer used only if a function has to execute kernels on the original image, which is not every function
    uint8_t* imageData_gpu = NULL;
    cudaMalloc(&imageData_gpu,width*height*channels);
    cudaMemcpy(imageData_gpu, imageData, width * height * channels, cudaMemcpyHostToDevice);

    
    //Schedule all operations
    void* convolution_outbuffer = NULL;
    void* maxpool_outbuffer = NULL;
    void* minpool_outbuffer = NULL;
    void* avgpool_outbuffer = NULL;

    void* convolution_imgout = NULL;
    void* maxpool_imgout = NULL;
    void* minpool_imgout = NULL;
    void* avgpool_imgout = NULL;

    cudaStream_t stream_convolution;
    cudaStream_t stream_maxpool;
    cudaStream_t stream_minpool;
    cudaStream_t stream_avgpool;
    

    //perform convolution
    if(convolution_selected){
        cudaStreamCreate(&stream_convolution);
        cudaMalloc(&convolution_outbuffer,width*height*channels);
        convolution_imgout = malloc(width*height*channels);

        //perform convolution on GPU
        convolution_2d<<<16,32,0,stream_convolution>>>((uint8_t*)convolution_outbuffer,(uint8_t*)imageData_gpu,width,height,channels,width*height*channels);

        cudaMemcpyAsync(convolution_imgout, convolution_outbuffer, width * height * channels, cudaMemcpyDeviceToHost, stream_convolution);
    }
    //perform pooling
    if(max_pooling_selected){
        cudaStreamCreate(&stream_maxpool);
        cudaMalloc(&maxpool_outbuffer,(width/2)*(height/2)*channels); //half the original size
        maxpool_imgout = malloc((width/2)*(height/2)*channels);

        image_pooling_max<<<16,32,0,stream_maxpool>>>((uint8_t*)maxpool_outbuffer,(uint8_t*)imageData_gpu,width,height,channels,(width/2)*(height/2)*channels);

        cudaMemcpyAsync(maxpool_imgout, maxpool_outbuffer, (width/2)*(height/2)*channels, cudaMemcpyDeviceToHost, stream_maxpool);
    }
    if(min_pooling_selected){
        cudaStreamCreate(&stream_minpool);
        cudaMalloc(&minpool_outbuffer,(width/2)*(height/2)*channels); //half the original size
        minpool_imgout = malloc((width/2)*(height/2)*channels);

        image_pooling_min<<<16,32,0,stream_minpool>>>((uint8_t*)minpool_outbuffer,(uint8_t*)imageData_gpu,width,height,channels,(width/2)*(height/2)*channels);
        cudaMemcpyAsync(minpool_imgout, minpool_outbuffer, (width/2)*(height/2)*channels, cudaMemcpyDeviceToHost, stream_minpool);
    }
    if(average_pooling_selected){
        cudaStreamCreate(&stream_avgpool);
        cudaMalloc(&avgpool_outbuffer,(width/2)*(height/2)*channels); //half the original size
        avgpool_imgout = malloc((width/2)*(height/2)*channels);

        image_pooling_average<<<16,32,0,stream_avgpool>>>((uint8_t*)avgpool_outbuffer,(uint8_t*)imageData_gpu,width,height,channels,(width/2)*(height/2)*channels);
        cudaMemcpyAsync(avgpool_imgout, avgpool_outbuffer, (width/2)*(height/2)*channels, cudaMemcpyDeviceToHost, stream_avgpool);
    }

    //write images
    if(convolution_selected){
        cudaStreamSynchronize(stream_convolution);
        int success = stbi_write_jpg(convolution_output, width, height, 3, convolution_imgout, 90); // 90 is the quality

        if (success) {
            //printf("Image saved successfully.\n");
        } else {
            printf("Failed to save image.\n");
        }
        
        // Clean up
        free(convolution_imgout);
        cudaStreamDestroy(stream_convolution);
        cudaFree(convolution_outbuffer);
    }

    if(max_pooling_selected){
        //write image
        cudaStreamSynchronize(stream_maxpool);
        int success = stbi_write_jpg(max_pooling_output, width/2, height/2, 3, maxpool_imgout, 90); // 90 is the quality

        if (success) {
            //printf("Image saved successfully.\n");
        } else {
            printf("Failed to save image.\n");
        }

        // Clean up
        free(maxpool_imgout);
        cudaStreamDestroy(stream_maxpool);
        cudaFree(maxpool_outbuffer);
    }

    if(min_pooling_selected){
        //write image
        cudaStreamSynchronize(stream_minpool);
        int success = stbi_write_jpg(min_pooling_output, width/2, height/2, 3, minpool_imgout, 90); // 90 is the quality

        if (success) {
            //printf("Image saved successfully.\n");
        } else {
            printf("Failed to save image.\n");
        }

        // Clean up
        free(minpool_imgout);
        cudaStreamDestroy(stream_minpool);
        cudaFree(minpool_outbuffer);
    }

    if(average_pooling_selected){
        //write image
        cudaStreamSynchronize(stream_avgpool);
        int success = stbi_write_jpg(average_pooling_output, width/2, height/2, 3, avgpool_imgout, 90); // 90 is the quality

        if (success) {
            //printf("Image saved successfully.\n");
        } else {
            printf("Failed to save image.\n");
        }
        // Clean up
        free(avgpool_imgout);
        cudaStreamDestroy(stream_avgpool);
        cudaFree(avgpool_outbuffer);

    }



    //cleanup
    stbi_image_free(imageData);
    if(imageData_gpu!=NULL)cudaFree(imageData_gpu);

}