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

%%%%%%%%%%%%%%%%
% Your code here
%%%%%%%%%%%%%%%%
%decide size
f_size=size(filter);
img_size=size(image);
pad_w=(f_size(1)-mod(f_size(1),2))/2;
pad_l=(f_size(2)-mod(f_size(2),2))/2;

%zero padding
output=zeros(img_size(1),img_size(2),img_size(3));
exp_img=zeros(img_size(1)+pad_w*2,img_size(2)+pad_l*2,img_size(3));
exp_img((pad_w+1):(pad_w+img_size(1)),(pad_l+1):(pad_l+img_size(2)),:)=image;

%convolution
for i=(pad_w+1):(pad_w+img_size(1))
    for j=(pad_l+1):(pad_l+img_size(2))
        R = sum(sum(exp_img((i-pad_w):(i+pad_w),(j-pad_l):(j+pad_l),1).*filter));
        G = sum(sum(exp_img((i-pad_w):(i+pad_w),(j-pad_l):(j+pad_l),2).*filter));
        B = sum(sum(exp_img((i-pad_w):(i+pad_w),(j-pad_l):(j+pad_l),3).*filter));
        output(i-pad_w,j-pad_l,1)=R;
        output(i-pad_w,j-pad_l,2)=G;
        output(i-pad_w,j-pad_l,3)=B;
    end
end
