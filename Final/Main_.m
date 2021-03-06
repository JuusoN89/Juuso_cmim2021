% Juuso Narsakka 15.12.2021
%Computational methods...
%Task 5  
%Reference for code https://github.com/gorzech/lut_cmim2021B.git

clc;
clear all; 
% close all

%% Kinematic Model for mechanism
ang1=90;
ang2=0;
dir1=+1; % - = counter clock, + = clock (driving joint)
dir2=-1; % - = counter clock, + = clock (driving joint)

L1=0.2;
L2=0.4;
l3=0.6;

%Global system
mbs = init_mbs();
mbs = add_body(mbs, "link0",  0,0);
mbs = add_body(mbs, "slider1", 0,0);
mbs = add_body(mbs, "link1",  -0.0, L1/2, deg2rad(ang1));
mbs = add_body(mbs, "link2", -L2/2, L2/2, deg2rad(ang2));
mbs = add_body(mbs, "slider2", -L2, L1);
mbs = add_body(mbs, "link3", -L2, L1);

% Revolute, body system
mbs = add_revolute(mbs, "revA", "slider1", [0; 0], "link1", [L1/2, 0.0]);
mbs = add_revolute(mbs, "revB", "link1", [-L1/2; 0], "link2", [L2/2, 0.0]);
mbs = add_revolute(mbs, "revC", "link2", [-L2/2; 0], "slider2", [0.0, 0.0]);


% Simple joints
mbs = add_simple_joint(mbs, "groundx", "link0", "x", 0);
mbs = add_simple_joint(mbs, "groundy", "link0", "y", 0);
mbs = add_simple_joint(mbs, "groundangle", "link0", "fi", 0);

mbs = add_simple_joint(mbs, "groundx", "link3", "x", -L2);
mbs = add_simple_joint(mbs, "groundy", "link3", "y", L1);
mbs = add_simple_joint(mbs, "groundangle", "link3", "fi", 0);
% 
mbs = add_simple_joint(mbs, "slidertranslation", "slider1", "y", 0);
mbs = add_simple_joint(mbs, "sliderrotation", "slider1", "fi", 0);

mbs = add_simple_joint(mbs, "slidertranslation", "slider2", "x", -L2);
mbs = add_simple_joint(mbs, "sliderrotation", "slider2", "fi", 0);

om1 = 2*pi()/36/3; % rad/s
om2 = 2*pi()/36; % rad/s
mbs = add_driving_joint(mbs, "crankrotation", "link1", "fi", @(t)-deg2rad(ang1) -dir1* om1 * t);
mbs = add_driving_joint(mbs, "crankrotation", "link2", "fi", @(t)-deg2rad(ang2) -dir2* om2 * t);

fprintf("System has %d bodies and %d coordinates.\n", length(mbs.bodies), mbs.nq)
fprintf("Number of the joints:\n\tRevolute: %d\n\tPrismatic: %d\n", ...
    length(mbs.joints.revolute), length(mbs.joints.prismatic))
fprintf("\tSimple: %d\n\tDriving: %d\n", length(mbs.joints.simple), length(mbs.joints.driving))
fprintf("In total %d DOF are constrained!\n", mbs.nc)


% mbs = add_gravity(mbs, g)

q0 = initial_position(mbs);

t0 = 0.0;
C = constraints(mbs, q0, t0);

tic
q0_correct = fsolve(@(y)constraints(mbs, y, 0.0), q0);
toc
% disp([q0, q0_correct])
C0 = constraints(mbs, q0_correct, t0)

Cq = constraints_dq(mbs, q0);

tic
[q0_correct_NR, NR_iter] = ...
    NR_method(@(y)constraints(mbs, y, 0.0), ...
    @(y)constraints_dq(mbs, y), q0, 1e-8)
toc

disp([q0, q0_correct, q0_correct_NR])
C0_NR = constraints(mbs, q0_correct_NR, t0)

h = 0.2;
t_end = 70;
tol = 1e-8;
% [T, Q, Qp, niter] = kinematic_analysis(mbs, q0, h, t_end, tol);
[T, Q, Qp, Qpp, niter] = kinematic_analysis_acc(mbs, q0, h, t_end, tol);
% for xxx=1:1:length(T)
% plot(Q(xxx, 6),Q(xxx, 7),'x')
% pause(0.01)
% hold on
% end

%Joint locations
joint1x=Q(:,4);
joint1y=Q(:,5);
% joint2x=Q(:,7);
% joint2y=Q(:,8);
joint3x=Q(:,10);
joint3y=Q(:,11);
joint4x=Q(:,13);
joint4y=Q(:,14);
joint2x=joint1x+cos(Q(:,9))*-L1;
joint2y=joint1y+sin(Q(:,9))*-L1;
% joint3x=joint2x+cos(Q(:,9))*L2;
% joint3y=joint2y+sin(Q(:,9))*L2;
% joint4x=Q(:,10);
% joint4y=Q(:,11);

%% Plots animation

% Position image over the time
% ddd=2
figure ()
ddd=length(T)
for xxx=1:1:ddd
plot([joint1x(xxx),joint2x(xxx),joint3x(xxx),joint4x(xxx)],[joint1y(xxx),joint2y(xxx),joint3y(xxx),joint4y(xxx)],'linewidth',2)
hold on
xline(-L2,'b')
yline(0,'b')
axis equal
ylim([-1.5*L2 1.5*L2])
pause(0.04)
hold off
end

%% Plots 

%Position
figure ()
plot(T,Q(:,7)) % revB location, x direction (horizontal)
title('Kinematic analysis on position, horizontal')
xlabel('Time (s)')
ylabel('Position (m)')
set(gca,'FontSize',12,'FontName','Times New Roman');

figure ()
plot(T,Q(:,8)) % revB location, ydirection
title('Kinematic analysis on position, vertical')
xlabel('Time (s)')
ylabel('Position (m)')
set(gca,'FontSize',12,'FontName','Times New Roman');

%Velocity
figure ()
plot(T,Qp(:,7)) % revB location, x direction (horizontal)
title('Kinematic analysis on velocity, horizontal')
xlabel('Time (s)')
ylabel('Velocity (m/s)')
set(gca,'FontSize',12,'FontName','Times New Roman');

figure ()
plot(T,Qp(:,8)) % revB location, ydirection
title('Kinematic analysis on velocity, vertical')
xlabel('Time (s)')
ylabel('Velocity (m/s)')
set(gca,'FontSize',12,'FontName','Times New Roman');

%Acceleration
figure ()
plot(T,Qpp(:,7)) % revB location, x direction (horizontal)
title('Kinematic analysis on acceleration, horizontal')
xlabel('Time (s)')
ylabel('Acceleration (m/s^2)')
set(gca,'FontSize',12,'FontName','Times New Roman');

figure ()
plot(T,Qpp(:,8)) % revB location, ydirection
title('Kinematic analysis on acceleration, vertical')
xlabel('Time (s)')
ylabel('Acceleration (m/s^2)')
set(gca,'FontSize',12,'FontName','Times New Roman');


%% Cantilever
% Initial parameters of cantilever beam (SI)

% l=5;        % length of the beam
% F=73000;    % Force in end of the beam
% E=210e9;    % Elastic modulus
% I=141e-6;   % Second moment of area
% A=4623e-6;  % Area
% rhoo=7800;  % Density
% m_tot=rhoo*A*l;
% g=[0 -9.81];    % Gravity

% 
% %% verification displecement
% d= F*l^3/(3*E*I);        % beam deflection equation
% 
% %% Spring stiffness evaluation for rigid beam model.
% n_p=1;                  % Number of parts (equal in length)
% l_p=l/n_p;              % Deviding the sections
% 
% %% calculation of stiffness (and verification)
% [y_ver kr_s] = stiffness(n_p,l_p,F,E,I,l,d)     % Verification works only number of parts [1 2 5]
% 
% % d
% % y_ver
% % kr_s

