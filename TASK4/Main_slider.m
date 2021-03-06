% Juuso Narsakka 26.11.2021
%Computational methods...
%Task 4 2 (piston/slider) (S. Linge and H. P. Langtangen, Programming for Computations - MATLAB/Octave: A Gentle Introduction to Numerical Simulations with MATLAB/Octave. 2016.)
%Reference for code https://github.com/gorzech/lut_cmim2021B.git

clc; clear all; close all;

a = 0.1;    % rod 1
b = 0.2;    % rod 2
w=-1;       % Rod 1 angular velocity
t=linspace(0,1,101);    %time (from,to,steps)
phi = pi()/6+w*t;   %Starting angle for rod 1

% parameter for loop 
round=1; 
theta=[]; 
u_vec=[];
theta_avel=[];
v_vec=[];

for phi=phi(1:1:end)
tt=t(round);
% set a reasonable starting point
u0 = [deg2rad(0); b + a];
v0 = [0; 1];

% create function handles for position
F = @(u) constraint(u, a, b, phi);
J = @(u) jacobian(u, b);

eps = 1e-9;
[u, iteration_counter] = NR_method(F, J, u0, eps); % position calculation
theta(end+1)=u(1);
u_vec(end+1)=u(2);

% create function handles for velocity
F2 = @(v) constraint2(u, v, a, b, w, phi);
J2 = @(v) jacobian2(u, b);

[v, iteration_counter2] = NR_method_diff(F2, J2, v0, eps);   % Velocity calculation
theta_avel(end+1)=v(1);
v_vec(end+1)=v(2);

%figure for slider
sliderfigure(phi,a,b,u,v)
% pause(0.05)
round=round+1;
end

%other figures
pos_vel_figure(theta, theta_avel, u_vec, v_vec, t)


%for position & angle functions
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