function output = my_imfilter(image, filter)
% This function is intended to behave like the built in function imfilter()
% See 'help imfilter' or 'help conv2'. While terms like "filtering" and
% "convolution" might be used interchangeably, and they are indeed nearly
% the same thing, there is a difference:
% from 'help filter2'
%    2-D correlation is related to 2-D convolution by a 180 degree rotation
%    of the filter matrix.
% Your function should work for color images. Simply filter each color
% channel independently.
% Your function should work for filters of any width and height
% combination, as long as the width and height are odd (e.g. 1, 7, 9). This
% restriction makes it unambigious which pixel in the filter is the center
% pixel.
% Boundary handling can be tricky. The filter can't be centered on pixels
% at the image boundary without parts of the filter being out of bounds. If
% you look at 'help conv2' and 'help imfilter' you see that they have
% several options to deal with boundaries. You should simply recreate the
% default behavior of imfilter -- pad the input image with zeros, and
% return a filtered image which matches the input resolution. A better
% approach is to mirror the image content over the boundaries for padding.
% % Uncomment if you want to simply call imfilter so you can see the desired
% % behavior. When you write your actual solution, you can't use imfilter,
% % filter2, conv2, etc. Simply loop over all the pixels and do the actual
% % computation. It might be slow.
% output = imfilter(image, filter);
R = image(:,:,1);
G = image(:,:,2);
B = image(:,:,3);
%%%%%%%%%%%%%%%%
% Your code here
%%%%%%%%%%%%%%%%
[i_height,i_width,channel] = size(image);
[f_height,f_width,channel2] = size(filter);
big_R = zeros(i_width+f_width-1,i_height+f_height-1);
big_G = zeros(i_width+f_width-1,i_height+f_height-1);
big_B = zeros(i_width+f_width-1,i_height+f_height-1);
big_R((f_width+1)/2:i_width+((f_width-1)/2),(f_height+1)/2:i_height+((f_height-1)/2)) = R';
big_G((f_width+1)/2:i_width+((f_width-1)/2),(f_height+1)/2:i_height+((f_height-1)/2)) = G';
big_B((f_width+1)/2:i_width+((f_width-1)/2),(f_height+1)/2:i_height+((f_height-1)/2)) = B';
big_R = big_R';
big_G = big_G';
big_B = big_B';
%convolution
for j = 1:i_height
    for i = 1:i_width
        new_R(j,i) = sum(sum(filter.*big_R(j:j+f_height-1,i:i+f_width-1)));
        new_G(j,i) = sum(sum(filter.*big_G(j:j+f_height-1,i:i+f_width-1)));
        new_B(j,i) = sum(sum(filter.*big_B(j:j+f_height-1,i:i+f_width-1)));
    end
end
%%%%%%%%%%%%%%%%
% Your code end
%%%%%%%%%%%%%%%%
output(:,:,1) = new_R;
output(:,:,2) = new_G;
output(:,:,3) = new_B;
figure
imshow(output)
end