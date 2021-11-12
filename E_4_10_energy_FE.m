%Juuso Narsakka 11.11.2021
%Computational methods...
%Task 3 4.10 (S. Linge and H. P. Langtangen, Programming for Computations - MATLAB/Octave: A Gentle Introduction to Numerical Simulations with MATLAB/Octave. 2016.)
%Reference for code https://github.com/gorzech/lut_cmim2021B.git 

clc; clear all; close all

w = 2;
T0 = 2*pi/w;
dt = T0/20;
tk = 10*T0;

N_t = floor(tk/dt);
t = linspace(0, N_t*dt, N_t+1);
u = zeros(N_t+1, 1);
v = zeros(N_t+1, 1);

% Initial condition
X_0 = 2;
u(1) = X_0;
v(1) = 0;

% Step equations forward in time
for n = 1:N_t
    u(n+1) = u(n) + dt*v(n);
    v(n+1) = v(n) - dt*w^2*u(n);
end

[pot, kine] = energy(u, v, w);

sum=pot+kine;
plot(t, sum, 'b-');
xlabel('t');
ylabel('energy sum');