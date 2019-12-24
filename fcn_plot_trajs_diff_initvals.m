function [] = fcn_plot_trajs_diff_initvals(initvals,tspan,trajectories)

initvals_perms=permn(initvals,2);

for k=1:size(initvals_perms,1)
    % plot(trajectories{initv1}(:,2), trajectories{initv1}(:,1)); hold on
    surface(repmat(trajectories{k}(:,2),1,2), repmat(trajectories{k}(:,1),1,2), ...
        repmat(zeros(size(tspan)),2,1)', ([tspan;tspan]-mean(tspan))', ...
        'facecol','no', 'edgecol','interp', 'linew',2); 
% plot(tspan,trajectories{k}(:,2))
    hold on;
end
xlim([0 max(max(cell2mat(trajectories)))]); ylim([0 max(max(cell2mat(trajectories)))])
hold off