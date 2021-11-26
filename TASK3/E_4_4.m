%Juuso Narsakka 11.11.2021
%Computational methods...
%Task 3 4.4 (S. Linge and H. P. Langtangen, Programming for Computations - MATLAB/Octave: A Gentle Introduction to Numerical Simulations with MATLAB/Octave. 2016.)
%Reference for code https://github.com/gorzech/lut_cmim2021B.git 

clc; clear all; close all;
k=1;
con = true;

while con == true

    
    dt = 200;                % starting time step
    dtk = 2^(-k)*dt;        % change in time step
    T = 300;                % Time period
    tspan=[dtk T]
    f = @(u,t) 0.05*(1-u/2000)*u;
    U_0 = 100;
    
    [u, t] = ode_FE(f, tspan, U_0);
    
    if k>1;
    figure
    plot(t, u, 'b-', t2, u2, 'r--');
    legend('new', 'old', 'Location','northwest');
    xlabel('t [s]');
    
    fprintf('Timestep is: %g\n', dtk);
    answer = input('next round (y/n)? ', 's')
    

        if strcmp(answer,'y')
            con = true;
        else
            con = false;
        end
    end
    
    u2 = u;         %for next round
    t2 = t;
    
    k = k + 1;
    
end