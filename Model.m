classdef Model

    properties
        scheduler
        agent_position
        agent_velocity
    end

    methods
        function obj = Model()
            % Model Initializer
        end

        function obj = step(obj, boid_pos, boid_vel)
            obj.scheduler = obj.scheduler.step(boid_pos, boid_vel);
        end

        function obj = add(obj, agent)
            obj.scheduler = obj.scheduler.add(agent);
        end

        function obj = get_agent_data(obj)
            num_agents = length(obj.scheduler.agents);
            temp_agent_position = zeros(num_agents, 2);
            temp_agent_velocity = zeros(num_agents, 2);
            for i = 1:num_agents
                temp_agent_position(i, :) = obj.scheduler.agents{i}.position;
                temp_agent_velocity(i, :) = obj.scheduler.agents{i}.velocity;
            end
            obj.agent_position = temp_agent_position;
            obj.agent_velocity = temp_agent_velocity;
        end
    end
end