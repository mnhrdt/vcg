# read input
f = imread("image.png");
g = imread("boundary.png");
[w,h] = size(g);
f = double(f(:));
g = double(g(:));

# build mask operator
M = spdiags(g==0, 0, w*h, w*h);

# build laplacian operator on the whole image
px = sparse(1:w-1, 2:w, 1, w, w);
py = sparse(1:h-1, 2:h, 1, h, h);
G = kron(py,speye(w)) + kron(speye(h),px);
L = G + G' - diag(sum(G + G'));

# state the problem
I = speye(w*h);
A =  I - M    - M*L  ;
b = (I - M)*g - M*L*f;

# solve the problem
x = A\b;

# write output
imwrite(uint8(reshape(x,w,h)), "out_seamless.png");
