function w = opt2ode_naive(z,f_grad,g,g_grad)
% opt2ode turns a contraint opt. problem to its ode evo. function
% to be put in ode solver, in a naive fasion
% z = [x,y]' where x is the p-var, y the d-var
% f_grad is the objective gradient
% g,g_grad is the constraint and constraint gradient
% f,f0_grad,f_grad are cells of function handle
% w = [-L_x;L_y]'

% n = len(x), m = len(y)
m = length(f);
n = length(z) - m;

% recover p & d variable from z
x = z(1:n); y = z(n+1:end);

% xi = L_x,eta = L_y 
xi = f_grad(x);
eta = zeros(m,1);
for i = 1:m
    xi = xi + y(i)*g_grad{i}(x);
    eta(i) = f{i}(x);
end
w = [-xi;eta];
    