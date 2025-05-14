# 2D convolution application

This project was a school project commissioned by Vincent Claes for the class "Hardware accelerated computing" from the pxl. The goal is to write two application. A classic C application and a cuda accelerated program that does 2D convolution on images.

Eventually the program will be analyzed using tools like nvccprof and gprof to measure performance and identify the speed increase.

## Folder structure

There are two folders:

`cuda` contains the hardware accelerated code

`C` contains the regular code

## How to run

## Our results

The first set of tests were done on a laptop that has a RTX1000 laptop GPU. 

### Timings

This is section will be a pure speed that highlighting the increases of each iteration using different images.

### In depth analysis

Going from the C application to the accelerated one in Cuda was done in steps, after each step an analysis was done to see where performance gains could be made. An important consideration is that syscalls are not measured in gprof, since a lot of malloc is being used it is important to realize that the actual time to run is much higher, it is best to refer to the timing results below for a more accurate result.

![](C/img3.jpg)

For the in depth analysis we will take the biggest image in the collection, this to get the most detailed report. First we analyse the C implementation and profile it using gprof, a lot of these calls are from the stbi library, but since these won't be optimized and regarded as out of our control they have been removed from the list

```
Flat profile:

Each sample counts as 0.01 seconds.
  %   cumulative   self              self     total           
 time   seconds   seconds    calls  ms/call  ms/call  name    
 21.51      0.20     0.20        1   200.00   301.85  convolution_2d
 15.05      0.52     0.14 641081160     0.00     0.00  getPixel
  4.30      0.79     0.04        1    40.00    58.72  image_pooling_max
  2.15      0.81     0.02 11647296     0.00     0.00  getAverage
  1.08      0.88     0.01 19412160     0.00     0.00  getMax
  1.08      0.92     0.01        1    10.00    42.72  image_pooling_average
  1.08      0.93     0.01        1    10.00    26.72  image_pooling_min
  0.00      0.93     0.00  3882432     0.00     0.00  getMin
  0.00      0.93     0.00        1     0.00     0.00  black_borders
```

We initially expected that the biggest gain could be gained by speeding up the algorithms we had to implement, this does seem to be the case, I however did not expect that some of these pooling functions were already quite lightweight. I also noticed that the helper function getPixel is fairly heavy, while this function is used in every algorithms it still takes a lot of time. Usually looking into an accelerated math library could help or to rewrite the equations to gain speed benefits but this would go beyond the scope of this excersize so we will look into getting performance benefits by offloading compute to hardware.

We will be skipping over the direct 1to1 translation since this result holds no real insights. We skip to the grid-stride implementation where each kernel has been implemented without thread/block optimizations


Because the new version is built on cuda the profile tool has changed and instead of grpof we are now using `nsys` to profile the application

![](img/nsys_cuda1.png)

You will generate a report that looks like this, unfortunately symbol names for cpu functions are gone now, but it gives a very detailed overview of the GPU. One of the things that is immeatiatly clear is the speed increase of the convolutions, while it first took the longest is now is very short. I surprised me to see why the pooling functions haven't changes as much as compared to the convolution. My theory is that it is because the getmax/getmin/getaverage function calls are not performant on the GPU and slows down the kernel significantly. I have not been able to confirm this theory as even with rewriting the function the same result was appearant.

Eventually it was clear that I just forgot to assign more threads and blocks to the function, after increasing it the performance benefit was clearly seen. Currently these values are hard coded but a future improvement could be to dynamically assign threads as to fully optimize the GPU

![](img/nsys_cuda2.png)

The result already show a great improvement but the memory transfer is starting to become a significant portion of the workload. A potential optimization was to use different streams for each kernel so the cuda driver could be more creative to schedule the tasks and potentially speed up the process even more.

![](img/nsys_cuda3.png)

The streams were implemented nicely and there is a slight performance benefit, but it wasnt what I expected to happen. I thought that because the memory would be copied asynchronously that the red blocks would overlap with the blue, this would be a way bigger performance benefit. Another things that would be ideal is if it would work on callback basis, where the c function to save the image is called right after the memcopy is completed. But i think this would introduce multithreading which is also something that would go beyond the scope of the project.

So far this was the last improvement that was done

### Conclusion

The performance benefits are clear. While performance is a never ending battle with constant improvelents, it is clear that the first improvements are usually the biggest gain, the time spent compared to the reward is worth it most of the time.
