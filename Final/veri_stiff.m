function [y_veri] = veri_stiff(F,l,kr_s,n_p,d,l_p)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    theta_v=F*l/kr_s;
    theta_v2=F*l_p*(n_p-1)/kr_s;
    theta_v3=F*l_p*(n_p-2)/kr_s;
    theta_v4=F*l_p*(n_p-3)/kr_s;
    theta_v5=F*l_p*(n_p-4)/kr_s;
    q1=theta_v*(l_p);
    q2=(theta_v+theta_v2)*(l_p);
    q3=(theta_v+theta_v2+theta_v3)*(l_p);
    q4=(theta_v+theta_v2+theta_v3+theta_v4)*(l_p);
    q5=(theta_v+theta_v2+theta_v3+theta_v4+theta_v5)*(l_p);
    y_veri=q1+q2+q3+q4+q5;

end

