% Juuso Narsakka 26.11.2021
%Computational methods...
%Task 4 4.14 (S. Linge and H. P. Langtangen, Programming for Computations - MATLAB/Octave: A Gentle Introduction to Numerical Simulations with MATLAB/Octave. 2016.)
%Reference for code https://github.com/gorzech/lut_cmim2021B.git

clc; close all; clear all;

%% 4.2 a)

hand = [1 2 4 8];
T = 3;
dt = 1;       
U_0 = 1.0; 
f = @(u,t) u;
[u, t] = ode_FE(f, U_0, dt, T);

comparison =hand-u;

figure
plot(0:1:T, hand, 'r')
hold on
plot(0:dt:T, u, 'b')
title(' 4.2 a) comparison of hand & ode FE')
legend('hand','ode Fe')
%% 4.2 b)
r=1;
f2 = @(u,t) r*u;
[u2, t2] = ode_FE(f2, U_0, dt, T);

n = 1:1:length(u);
num = U_0*(1+r*dt).^n;

comparison =num-u2';

figure
plot(0:dt:T, num, 'r')
hold on
plot(0:dt:T, u2, 'b')
title('4.2 b) comparison of num & ode FE')
legend('u^n','ode Fe')

%% 4.8

omega = 10;
P = 2*pi/omega;
dt = P/50;
T = 5*P;
X_0 = 2;
[u, v, t] = osc_FE(X_0, omega, dt, T);

figure
plot(t, u, 'b-', t, X_0*cos(omega*t), 'r--');
title('4.8 position')
legend('numerical', 'exact', 'Location', 'northwest');
xlabel('t');
ylabel('m')

figure
plot(t, v, 'b-', t, -omega*X_0*sin(omega*t), 'r--');
title('4.8 Velocity')
legend('numerical', 'exact', 'Location', 'northwest');
xlabel('t');
ylabel('m/s')    
    
%% 4.9
   
file_name = 'osc_FE_data';
osc_FE_2file(file_name, X_0, omega, dt, T)   
   
% Read data from file for comparison     
infile = fopen(file_name, 'r');
u_ref = fscanf(infile, '%f');
fclose(infile);

figure
plot(t, u_ref, 'b-', t, X_0*cos(omega*t), 'r--');
title('4.9 position readed from file')
legend('numerical', 'exact', 'Location', 'northwest');
xlabel('t');
ylabel('m')





