function w = naive(z,A,c,b)

% z = [x,y]'
% w = [xi,eta]'

[m,n] = size(A);
w = zeros(m+n,1);
w(1:n) = A'*z(n+1:m+n) - c;
w(n+1:m+n) = b - A*z(1:n);
end