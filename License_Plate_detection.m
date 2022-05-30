close all;
clear all;
im = imread('Dataset/4.jpg'); % Reading the licance plate image.
figure
imshow(im), title("\color{red}Original Image")
imgray = rgb2gray(im); % Converting the RGB (color) image to gray (intensity).
figure
imshow(imgray), title("\color{red}Gray Level Conversion Process")
imbin = imbinarize(imgray);
figure
imshow(imbin) , title("\color{red}Binary Level Conversion Process")
imgraynew = medfilt2(imgray); % Median filtering to remove noise.
figure
imshow(imgraynew) , title("\color{red}Median Filter Process")
im = edge(imgraynew, 'sobel'); % Sobel filtering to finding the edges of the image.
figure
imshow(im) , title("\color{red}Sobel Filter Process")
im=imdilate(im,strel('diamond',2));
figure
imshow(im) , title("\color{red} Extending Edges")
im2=imfill(im,'holes'); % Filling all the regions of the image.
figure
imshow(im2) , title("\color{red}Fill Rectangle Areas")
im=imopen(im,strel('rectangle',[2 2]));

%Below steps are to find location of number plate.
Iprops=regionprops(im,'BoundingBox','Area', 'Image');
area = Iprops.Area;
count = numel(Iprops);
maxa= area;
boundingBox = Iprops.BoundingBox;
for i=1:count
   if maxa<Iprops(i).Area
       maxa=Iprops(i).Area;
       boundingBox=Iprops(i).BoundingBox;
   end
end    

im = imcrop(imbin, boundingBox);%crop the number plate area
figure
imshow(im) , title("\color{red}The Process of Locating the Plate")
im = bwareaopen(~im, 500); %remove some object if it width is too long or too small than 500
figure
imshow(im) , 

 [h, w] = size(im);%get width


Iprops=regionprops(im,'BoundingBox','Area', 'Image'); %read letter
count = numel(Iprops);
noPlate=[]; % Initializing the variable of number plate string.

for i=1:count
   ow = length(Iprops(i).Image(1,:));
   oh = length(Iprops(i).Image(:,1));
   if ow<(h/2) & oh>(h/3)
       letter=Letter_detection(Iprops(i).Image); % Reading the letter corresponding the binary image 'N'.
       noPlate=[noPlate letter] % Appending every subsequent character in noPlate variable.
   end
end