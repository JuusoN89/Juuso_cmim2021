function [] = sliderfigure(phi,a,b,u,v)

figure (1)
plot([0 cos(phi)*a u(2)], [0 sin(phi)*a 0], 'b')
xlim([-a-b a+b])
ylim([-a-b a+b])
legend(['Piston speed = ' num2str(v(2)) 'm/s'])

end

