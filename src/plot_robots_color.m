function [ ] = plot_robots( robots )

M = length(robots);
pos =[];
for i = 1:M
    pos = [pos; robots(i).pos];
end

figure(1);
hold on;
for i = 1:M
    if robots(i).state == 1
plot(pos(i,1),pos(i,2),'ko');
    elseif robots(i).state == 2
plot(pos(i,1),pos(i,2),'bo');
    elseif robots(i).state == 3
plot(pos(i,1),pos(i,2),'ro');
    elseif robots(i).state == 4
plot(pos(i,1),pos(i,2),'go');
    end
    hold on
end

pause(0.05)

end