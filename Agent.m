classdef Agent

    properties
        unique_id
    end

    methods
        function obj = Agent(unique_id)
            % Initializes an agent
            obj.unique_id = unique_id;
        end
    end
end