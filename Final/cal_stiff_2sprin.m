function [y2,kr_s] = veri_stiff(F,l,n_p,d,l_p)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    syms kr
    theta_1=F*l/kr*(l/n_p);          % sprin ratoation equation F*l is moment and kr is sprin rotational stiffness
    theta_2=F*l/n_p/kr*(l/n_p);
    theta_tot=theta_1;      % sum of number of rotation (springs)
    y=theta_1+theta_2;
    kr_s=vpasolve(y==d, kr);
    y2=F*l/kr_s*(l/n_p)+F*l/n_p/kr_s*(l/n_p)
end

