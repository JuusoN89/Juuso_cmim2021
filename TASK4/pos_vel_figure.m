function [] = pos_vel_figure(theta, theta_avel, u_vec, v_vec, t)

figure (2)
plot(t, theta)
title(['Piston rod angle (theta)'])
xlabel('Time (s)')
ylabel('Angle (rad)')
set(gca,'FontSize',12,'FontName','Times New Roman');

figure (3)
plot(t, u_vec)
title(['Piston position'])
xlabel('Time (s)')
ylabel('Position (m)')
set(gca,'FontSize',12,'FontName','Times New Roman');

figure (4)
plot(t, theta_avel)
title(['Piston rod anglular velocity (theta)'])
xlabel('Time (s)')
ylabel('Anglular velocity (rad/s)')
set(gca,'FontSize',12,'FontName','Times New Roman');

figure (5)
plot(t, v_vec)
title(['Piston velocity'])
xlabel('Time (s)')
ylabel('velocity (m/s)')
set(gca,'FontSize',12,'FontName','Times New Roman');
end

