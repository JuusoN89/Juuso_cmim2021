%Juuso Narsakka 11.11.2021
%Computational methods...
%Task 3 4.14 (S. Linge and H. P. Langtangen, Programming for Computations - MATLAB/Octave: A Gentle Introduction to Numerical Simulations with MATLAB/Octave. 2016.)
%Reference for code https://github.com/gorzech/lut_cmim2021B.git 

clc; clear all; close all

%%
syms u un v vn n dt w a b

un=dt*v^n+u^(n-1);
vn=-dt*w^2*u^n+v^(n-1);

vn2=-dt*w^2*(un)+v^(n-1) % print and add to V0

v0=a==v^(n - 1) - dt*(dt*a + u^(n - 1))*w^2; % replace v^n with a

v_n=solve(v0,a)

u_n=dt*(v_n)+u^(n-1) % v_n to un (v_n --> v^n)

for timestep = [20 2000]
%% 
w = 2;
T0 = 2*pi/w;
dt = T0/timestep;
tk = 10*T0;

N_t = floor(tk/dt);
t = linspace(0, N_t*dt, N_t+1);
u = zeros(N_t+1, 1);
v = zeros(N_t+1, 1);

% Initial condition
X_0 = 2;
u(1) = X_0;
v(1) = 0;

% Step equations backward in time
for n = 2:N_t
    u(n) = u(n - 1) + (dt*(v(n - 1) - dt*u(n - 1)*w^2))/(dt^2*w^2 + 1);
    v(n) = (v(n - 1) - dt*u(n - 1)*w^2)/(dt^2*w^2 + 1);
end

figure
plot(t(1:1:end-1), u(1:1:end-1), 'b-', t, X_0*cos(w*t), 'r--');
legend('numerical', 'exact', 'Location', 'northwest');
xlabel('t');
print('tmp', '-dpdf');  print('tmp', '-dpng');

end