function [ robots] = robot_action( robots, i )


if robots(i).in_phase3 == 0
    if robots(i).state == 1 %if this robot is unlocalized, do this
        robots = phase1( robots, i );
    else % if not, wait until all of them are localized
        robots = phase2( robots, i );
    end
else
    robots = phase3( robots, i ); % move 
end


end

