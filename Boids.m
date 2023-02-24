
% Initialize Model
boid_model = Model();

% Initialize Scheduler
boid_model.scheduler = BaseScheduler();

% Initialize Tunable Parameters
avoid_factor = 2;
avoid_range = 0.5;
align_range = 10;
match_factor = 0.1;
cohesion_factor = 0.1;
bounds = [-8, 8];
turnfactor = 2;


% Add Agents
num_boids = 20;
for i = 1:num_boids
    boid_model = boid_model.add(BoidAgent(i, avoid_factor, avoid_range,...
        align_range, match_factor, cohesion_factor, bounds, turnfactor));
end


% Plotting
boid_model = boid_model.get_agent_data();
figure()
set(gcf, "position", [100, 100, 1000, 800]);
p = plot(boid_model.agent_position(:, 1), boid_model.agent_position(:, 2), "b*");
xlim([-10, 10])
ylim([-10, 10])
p.XDataSource = "boid_x";
p.YDataSource = "boid_y";

% Start Agent Steps
while true
    boid_model = boid_model.step(boid_model.agent_position, boid_model.agent_velocity);
    boid_model = boid_model.get_agent_data();
    boid_pos = boid_model.agent_position;
    boid_x = boid_pos(:, 1);
    boid_y = boid_pos(:, 2);
    refreshdata
    drawnow
    pause(1/24)
end
