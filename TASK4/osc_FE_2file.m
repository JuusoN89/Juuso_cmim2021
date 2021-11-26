function osc_FE_2file(filename, X_0, omega, dt, T)
    N_t = floor(T/dt);
    u = zeros(N_t+1, 1);
    v = zeros(N_t+1, 1);

    % Initial condition
    u(1) = X_0;
    v(1) = 0;
    
    outfile = fopen(filename, 'w');
    fprintf(outfile,'%10.5f\n', u(1));

    % Step equations forward in time
    for n = 1:N_t
        u(n+1) = u(n) + dt*v(n);
        v(n+1) = v(n) - dt*omega^2*u(n);
        fprintf(outfile,'%10.5f\n', u(n+1));
    end
    fclose(outfile);  

