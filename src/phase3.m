function [ robots ] = phase3( robots, i )

if robots(i).state ~= 2 % If state 2, dont move

    if robots(i).state == 3
        mov = 0.5*[1 1]; %Phototaxis, get near to the light
    elseif robots(i).state == 4
        mov = -0.5*[1 1]; % Antiphototaxis, get out of the light
    end
    ang_rand  = (rand * pi - pi/2); % get a random angle
    dir = (robots(i).focus_of_light - robots(i).pos) ; % Compute the direction
    dir = dir ./ norm(dir);   % normalize it
    ang_dir = atan2(dir(1),dir(2)) + ang_rand; % add the random angle
    mov = mov .*[sin( ang_dir),cos(ang_dir)]; % compute the move
    
    next_pos = robots(i).pos + mov; % Get the next position
    
    flag = 0;
    rob = length(robots);
    % If this position colide with other robot, dont move
    for j=1:rob
        if norm(robots(j).pos-next_pos)<1 && j~=i
            flag = 1;
            break
        end
    end
    if flag == 0
        robots(i).pos = next_pos;
    end
end

end

