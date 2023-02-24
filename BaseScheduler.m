classdef BaseScheduler

    properties
        agents
        num_agents
        time
    end

    methods
        function obj = BaseScheduler()
            % BaseScheduler Initializer
            obj.time = 0;
            obj.agents = {};
            obj.num_agents = 0;
        end

        function obj = add(obj, agent)
            % Adds an agent
            obj.agents{end+1} = agent;
            obj.num_agents = obj.num_agents + 1;
        end

        function obj = step(obj, agent_position, agent_velocity)
            % Steps through time
            for i = 1:obj.num_agents
                obj.agents{i} = obj.agents{i}.step(agent_position, agent_velocity);
                agent_position(i, :) = obj.agents{i}.position;
                agent_velocity(i, :) = obj.agents{i}.velocity;
            end
        end
    end
end