function [xi,eta] = opt2ode_exp(z,alpha,f,f0_grad,f_grad)
% opt2ode turns a contraint opt. problem to its ode evo. function
% to be put in ode solver, in an explicit anticipatory fasion
% z = [x,y]' where x is the p-var, y the d-var
% alpha controls how much to anticipate
% f0_grad is the objective gradient
% f,f_grad is the constraint and constraint gradient
% f,f0_grad,f_grad are cells of function handle
% w = [-L_x(x,y+alpha*L_y);L_y(x-alpha*L_x,y)]'

% n = len(x), m = len(y)
m = length(f);
n = length(z) - m;

% recover p & d variable from z
x = z(1:n); y = z(n+1:end);

% xi = L_x,eta = L_y
L_x = f0_grad(x);
xi = zeros(n,1);
eta = zeros(m,1);
for i = 1:m
    L_x = L_x + y(i)*f_grad{i}(x);
    xi = xi + f{i}(x)*f_grad{i}(x);
end
xi = L_x + alpha*xi;
for i = 1:m
    eta(i) = f{i}(x-alpha*L_x);
end
w = [-xi;eta];     