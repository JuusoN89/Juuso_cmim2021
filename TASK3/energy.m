function [pot,kine] = energy(u,v,w)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
pot = 0.5*w.^2*u.^2;
kine = 0.5*v.^2;
end

