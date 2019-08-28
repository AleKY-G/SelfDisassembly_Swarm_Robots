function [ ] = plot_robots( robots )

M = length(robots);
pos =[];
for i = 1:M
    pos = [pos; robots(i).pos];
end


figure(2);

plot(pos(:,1),pos(:,2),'o');
axis([-10 35 -10 35]);

pause(0.05)


end