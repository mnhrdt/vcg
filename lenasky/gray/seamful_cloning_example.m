f = imread("image.png");
g = imread("boundary.png");
x = (g==0).*f + g;
imwrite(x, "out_seamful.png");
