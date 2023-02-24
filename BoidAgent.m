classdef BoidAgent < Agent

    properties
        position
        velocity
        avoid_factor
        avoid_range
        align_range
        match_factor
        cohesion_factor
        del_t = 0.1
        low_speed = 1
        high_speed = 5
        bounds
        turnfactor
    end

    methods
        function obj = BoidAgent(unique_id, avoid_factor, avoid_range, align_range,...
                match_factor, cohesion_factor, bounds, turnfactor)
            % Initialize BoidAgent
            obj = obj@Agent(unique_id)
            obj.avoid_factor = avoid_factor;
            obj.avoid_range = avoid_range;
            obj.align_range = align_range;
            obj.match_factor = match_factor;
            obj.cohesion_factor = cohesion_factor;
            obj.bounds = bounds;
            obj.turnfactor = turnfactor;
            obj.position = rand(1, 2);
            obj.velocity = rand(1, 2);
        end

        function obj = step(obj, boid_pos, boid_vel)
            % Boid Time Step
            closeness = [0, 0];
            new_vel = [0, 0];
            dist_to_boids = vecnorm(boid_pos - boid_pos(obj.unique_id, :), 2, 2);

            % Separation
            for i = 1:length(boid_pos)
                if dist_to_boids(i) <= obj.avoid_range && i ~= obj.unique_id
                    closeness = closeness + obj.position - boid_pos(i, :);
                end
            end
            new_vel = new_vel + closeness*obj.avoid_factor;
            obj.velocity = obj.velocity + new_vel;

            % Alignment
            vel_avg = [0, 0];
            num_close = 0;
            for i = 1:length(boid_pos)
                if dist_to_boids(i) <= obj.align_range && i ~= obj.unique_id
                    vel_avg = vel_avg + boid_vel(i, :);
                    num_close = num_close + 1;
                end
            end
            obj.velocity = obj.velocity + (vel_avg/num_close - obj.velocity)*obj.match_factor;

            % Cohesion
            pos_avg = [0, 0];
            num_close = 0;
            for i = 1:length(boid_pos)
                if dist_to_boids(i) <= obj.align_range && i ~= obj.unique_id
                    pos_avg = pos_avg + boid_pos(i, :);
                    num_close = num_close + 1;
                end
            end
            obj.velocity = obj.velocity + (pos_avg/num_close - obj.position)*obj.cohesion_factor;

            % Turn Boid if out of bounds
            if obj.position(1) < obj.bounds(1)
                obj.velocity(1) = obj.velocity(1) + obj.turnfactor;
            elseif obj.position(1) > obj.bounds(2)
                obj.velocity(1) = obj.velocity(1) - obj.turnfactor;
            end

            if obj.position(2) < obj.bounds(1)
                obj.velocity(2) = obj.velocity(2) + obj.turnfactor;
            elseif obj.position(2) > obj.bounds(2)
                obj.velocity(2) = obj.velocity(2) - obj.turnfactor;
            end

            % Constrain Boid speed
            vel_mag = vecnorm(obj.velocity);
            if vel_mag < obj.low_speed
                obj.velocity = obj.velocity / vel_mag * obj.low_speed;
            elseif vel_mag > obj.high_speed
                obj.velocity = obj.velocity / vel_mag * obj.high_speed;
            end

            % Update Position
            obj.position = obj.position + obj.del_t * obj.velocity;
        end
    end
end