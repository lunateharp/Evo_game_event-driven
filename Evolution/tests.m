clc; clear; close all
%% problem set up
n = 1; % length of the variable x
m = 1; % number of constraints
a = 1; % non-linearization parameter
%  f is the objective function
f = @(x) x + .5*a*x.^2;
f_grad = @(x) 1 + a*x;
% g is the set of constraint functions
g = cell(m,1); g_grad = g;
g{1} = @(x) 1-x;
g_grad{1} = @(x) -1;
% L_x = @(x,y) f_grad(x) - y;
% L_y = @(x,y) g(x);
% Lya = @(x,y,y_act) L_x(x,y).^2 + y_act*L_y(x,y).^2;
x0 = 2; y0 = 1;
% y_act = y0>0;
% Lya_val = Lya(x0,y0,y_act);
% [xi,eta] = dis_exp([x0;y0],1,g,f_grad,g_grad);

%% continuous ode

iter = 0; maxit = 10;
x = zeros(maxit,1); y = zeros(maxit,1);
while iter < maxit
    iter = iter + 1;
    % decide direction
    [xi,eta] = dis_exp([x0;y0],1,g,f_grad,g_grad);
    dt = 1.5; % default step size
    x1 = x0 - dt*xi;
    y1 = y0 + dt*eta;
%     if y1 < 0
%         y1 = 0;
%     end
%     y_act = y1>0;
    % checking decreasing Lya value
%     while Lya(x1,y1,y_act) > Lya_val*1.1
%         dt = dt/2;
%         x1 = x0 - dt*xi;
%         y1 = y0 + dt*eta;
%         if y1 < 0
%             y1 = 0;            
%         end
%         y_act = y1>0;
%     end
    % accept the step
    x(iter) = x1;
    y(iter) = y1;
    x0 = x(iter);
    y0 = y(iter);
%     if Lya(x1,y1,y_act) < Lya_val && Lya_val - Lya(x1,y1,y_act) < 1e-8
%         break
%     else
%         Lya_val = Lya(x1,y1,y_act);
%     end
end
x = x(1:iter);
y = y(1:iter);
plot([2;x],[1;y],'-o');
hold on

% cvx_begin quiet
%     variable x(1)
%     minimize( x+.5*ep*x.^2 )
%     1-x <= 0
%     
% options = odeset('NonNegative',2,'OutputFcn',@odephas2);
% [t,z] = ode45(odefun,[0,100],[2;1],options);
axis equal
grid on
% disp(z(end,:))