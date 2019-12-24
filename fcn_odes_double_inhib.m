function dx = fcn_odes_double_inhib(t,x,params)

% [t,v] = ode45(@myode, tspan, v0);
% function dv = myode(t, v)
%   dv = 981-(025/681)*v^2;

params_cell = num2cell(params);
[n, kAA, kBA, beta_a, kBB, kAB, beta_b] = deal(params_cell{:});
dx=zeros(2,1);
A=x(1); B=x(2); 
dx(1)=beta_a + ( (A^n)/(A^n + kAA^n) )*( 1 + (kBA^n)/(kBA^n + B^n) ) - A;
dx(2)=beta_b + ( (B^n)/(B^n + kBB^n) )*( 1 + (kAB^n)/(kAB^n + A^n) ) - B;