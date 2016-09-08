function w = expode(z,A,c,b,alpha)
[m,n] = size(A);
x = z(1:n);
y = z(n+1:m+n);
w = zeros(m+n,1);
w(1:n) = A'*(y+alpha*(b-A*x)) - c;
w(n+1:m+n) = b - A*(x+alpha*(A'*y-c));
end