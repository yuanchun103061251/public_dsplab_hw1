# Your Name <span style="color:red">(yout cs id)</span>

# Project 1 / Image Filtering and Hybrid Images

## Overview
The project is related to 
> integration of two images by combining one's low frequency part with the other's high frequency part


## Implementation
1. proj1.m
	1. load images
		```
		image1 = im2single(imread('../data/dog.bmp'));
		image2 = im2single(imread('../data/cat.bmp'));
		```
	2. set a low-pass filter and call my_imfilter()
		```
		cutoff_frequency = 7;
		filter1 = fspecial('Gaussian', cutoff_frequency*4+1, cutoff_frequency);
		low_frequencies=my_imfilter(image1, filter1);
		```
	3. use same low-pass filter, call my_imfilter(), and use image2 to minus the outcome.(the high_frequency part remains)
		```
		cutoff_frequency = 7;
		filter2 = fspecial('Gaussian', cutoff_frequency*4+1, cutoff_frequency);
		high_frequencies = image2 - my_imfilter(image2, filter2);
		```
	4. hybrid image
		```
		hybrid_image=low_frequencies+high_frequencies;
		```
	5. save those images
		high_frequency needs to add 0.5 to become all positive because its values are between -0.5 ~ 0.5 
2. my_imfilter.m
	1. divide the image into R, G, and B(only show R related codes later)
		```
		R = image(:,:,1);
		```
	2. save the size of the image and the filter
		```
		[i_height,i_width,channel] = size(image);
		[f_height,f_width,channel2] = size(filter);
		```
	3. set a larger image to take care of the edge-filtering problem
		```
		big_R = zeros(i_width+f_width-1,i_height+f_height-1);
		big_R((f_width+1)/2:i_width+((f_width-1)/2),(f_height+1)/2:i_height+((f_height-1)/2)) = R';
		```
	4. do 2D convolution with the filter
		```
		for j = 1:i_height
			for i = 1:i_width
				new_R(j,i) = sum(sum(filter.*big_R(j:j+f_height-1,i:i+f_width-1)));
			end
		end
		```
	5. combine RGB
		```
		output(:,:,1) = new_R;
		```

## Results
from left to right   <br />
dog_origin,    dog_low_frequency,    cat_origin,    cat_high_frequency
<table border=1>
<tr>
<td>
<img src="/data/dog.bmp" width="24%"/>
<img src="/low_frequencies.jpg" width="24%"/>
<img src="/data/cat.bmp"  width="24%"/>
<img src="/high_frequencies.jpg" width="24%"/>
</td>
</tr>
</table>
vis_hybrid
<img src="/hybrid_image_scales.jpg" width="33%"/>    <br />

from left to right   <br />
cat_origin,    cat_low_frequency, dog_origin,    dog_high_frequency, 
<table border=1>
<tr>
<td>
<img src="/data/fish.bmp" width="24%"/>
<img src="/fish_low_frequencies.jpg" width="24%"/>
<img src="/data/submarine.bmp"  width="24%"/>
<img src="/submarine_high_frequencies.jpg" width="24%"/>
</td>
</tr>
</table>
vis_hybrid
<img src="/fish_submarine_image_scales.jpg" width="33%"/>    <br />
