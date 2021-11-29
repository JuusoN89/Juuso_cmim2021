% Juuso Narsakka 26.11.2021
%Computational methods...
%Task 4 4.14 (S. Linge and H. P. Langtangen, Programming for Computations - MATLAB/Octave: A Gentle Introduction to Numerical Simulations with MATLAB/Octave. 2016.)
%Reference for code https://github.com/gorzech/lut_cmim2021B.git

clc; clear all; close all;

% u = [phi_2; d];
a = 0.1;
% r = 4;
b = 0.2;
w=-1;
t=linspace(0,5,101);
phi = pi()/6+w*t;
% phi = deg2rad(30);
round=1; 

for phi=phi(1:1:end)
tt=t(round)
% set a reasonable starting point
u0 = [deg2rad(0); b + a];
v0 = [0; 1];

% create function handles
F = @(u) constraint(u, a, b, phi);
J = @(u) jacobian(u, b);

eps = 1e-9;
[u, iteration_counter] = NR_method(F, J, u0, eps);

F2 = @(v) constraint2(u, v, a, b, w, phi);
J2 = @(v) jacobian2(u, b);

[v, iteration_counter2] = NR_method_diff(F2, J2, [u0 v0], eps);


plot([0 cos(phi)*a u(2)], [0 sin(phi)*a 0], 'b')
xlim([-a-b a+b])
ylim([-a-b a+b])
legend(['Piston speed = ' num2str(v(2)) 'm/s'])
% hold off
pause(0.03)
round=round+1;

end

fprintf('\n\tPiston valid position is for d = %.3g m and theta = %g deg\n\n', ...
    u(2), rad2deg(u(1)));
fprintf('\n\tPiston valid velocity is for d = %.3g m/s and theta angular velocity = %g rad/s\n\n', ...
    v(2), (v(1)));

%for position & angle 
function PP = constraint(u, a, b, phi)
theta = u(1);
d = u(2);

PP = [a * cos(phi) + b * cos(theta) - d
    a * sin(phi) - b * sin(theta)];
end

function P = jacobian(u, b)
theta = u(1);
P = [-b * sin(theta), -1
    -b * cos(theta), 0];
end

% For velocity (diff above)
function PP = constraint2(u, v, a, b, w, phi)
theta = u(1);
d_dot = v(2);
theta_dot = v(1);

PP = [-a*w * sin(phi) - b*theta_dot * sin(theta) - d_dot
    a*w * cos(phi) - b*theta_dot * cos(theta)];
end

function P = jacobian2(u, b)
theta = u(1);
P = [-b*sin(theta), -1
    -b*cos(theta), 0];
end