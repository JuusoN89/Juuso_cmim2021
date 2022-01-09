function [y_ver kr_s] = stiffness(n_p,l_p,F,E,I,l,d)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if n_p==1
    syms kr_s
    kr_s= vpasolve(F*l/(kr_s)*l==d,kr_s);
    y_ver=F*l/(kr_s)*l

    elseif n_p>2
    kr_s=E*I;               % spring stffness when parts number is more than 2
    n_p_ver=5
    if n_p==5
        [y_ver]=veri_stiff(F,l,kr_s,n_p_ver,d,l_p); % 
    else 
    y_ver=0;
    end

    elseif n_p==2
    [y_ver kr_s]=cal_stiff_2sprin(F,l,n_p,d,l_p);

end
end

