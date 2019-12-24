%% stat sol for cooperative self-inducing gene

% dx/dt = 
% steady state: 0 = beta + (x^n)/(x^n+k^n) - x 
% x^(n+1) - (beta+1)*x^n + (k^n)*x - beta*k^n

k_val=3/4; % n=3;
beta_vals = [0 1e-3 linspace(0.01,k_val,100)]; n_vals=[2:5 8 10];
% rootfinding function
disp(strcat('number of calc.s: ',num2str(numel(beta_vals)*numel(n_vals))))
tic; [roots_real_nonnegat_matr,roots_all] = fcn_bistab_roots(beta_vals,n_vals,k_val); toc

%% heatmap plot

figure('name', 'bifurc heatmap')
n_row=round(sqrt(numel(roots_real_nonnegat_matr))); n_col=n_row;
if n_row*n_col<numel(roots_real_nonnegat_matr); n_col=n_col+1; end
for k=1:numel(roots_real_nonnegat_matr)
    subplot(n_row,n_col,k)
    if k>(n_row-1)*n_col; x=beta_vals; else x=[];  end
    heatmap(flipud(roots_real_nonnegat_matr{k}'),x,[], [], 'NaNColor',[1 1 1],'GridLines',':');
    ylabel(strcat('n=',num2str(n_vals(k))))
end

%% BIFURC plot

plot_pars=22; % fontsize
fcn_plot_bifurc_diff_n(roots_real_nonnegat_matr,beta_vals,n_vals,k_val,plot_pars)
% export_fig bifurc_plots_autostim.png -transparent -nocrop

%% toggle switch with multistability: A |=| B, both are self-activating

% dA/dt = beta_a + fA*(1+fBA) - A = beta_a + ( (A^n)/(A^n + kAA^n) )*( 1 + (kBA^n)/(kBA^n + B^n) ) - A
% A = beta_a + ((A^n)/(A^n + kAA^n))*(1+(kBA^n)/(kBA^n + B^n))
% A*(A^n + kAA^n) = beta_a*(A^n + kAA^n) + ((A^n))*( 1 + (kBA^n)/(kBA^n + B^n) )
% A*(A^n + kAA^n) *(kBA^n + B^n) - ( beta_a*(A^n + kAA^n)*(kBA^n + B^n) + (A^n)*((kBA^n + B^n) + kBA^n ))
%
% params: n, kAA, kBA, beta_a, kBB, kAB, beta_b
% n=4; k_val=3/4; beta=1/4
n=3;
kAA=3/4; kBB=3/4;
beta_a=1/5; beta_b=1/5;
kBA=1/2; kAB=1/2;
params = [n,kAA,1/2,beta_a,kBB,1/2,beta_b];
% params_cell = num2cell(params);
% [n, kAA, kBA, beta_a, kBB, kAB, beta_b] = deal(params_cell{:});
maxval_B=2.25; logvals=logspace(-2,log10(maxval_B),200); linvals=linspace(0.01,maxval_B,300);
B_vals=[0 linvals]; A_vals=[0 linvals];
tic; [real_nonnegroots_f1,real_nonnegroots_f2] = fcn_nullclines_double_inhib(A_vals,B_vals,params); toc

%% plot nullclines (intersection points are steady states)

parnames='$[n, k_{AA}, k_{BA},\beta_a, k_{BB},k_{AB},\beta_b]=$';
legend_str={'dA/dt=0,stable','dA/dt=0,unstable','dA/dt=0,stable'};
% fontsize_val=plot_pars{1}; linewidth_val=plot_pars{2}; linewidth_val2=plot_pars{3}; parnames=plot_pars{4};
% legend_str = plot_pars{5};
plot_pars={22,3,5,parnames,legend_str,0.02};
fcn_plot_double_inhib(B_vals,real_nonnegroots_f1,A_vals,...
    real_nonnegroots_f2,params,plot_pars,'vectorfield')
% no vector field:
% fcn_plot_double_inhib(B_vals,real_nonnegroots_f1,A_vals,real_nonnegroots_f2,params,plot_pars,[])
% export_fig double_inhib_bistable_symm.jpg -transparent -nocrop
set(gca,'FontSize',22)

%% dynam behav with ODEs

initvals=linspace(0,2.25,16); tspan=0:0.01:20; initvals_perms=permn(initvals,2);
options = odeset('RelTol',1e-4); % ,'AbsTol',at
trajectories=cell(1,size(initvals_perms,1));

for initv1=1:size(initvals_perms,1)
    disp(initv1/size(initvals_perms,1)); x0=initvals_perms(initv1,:);
    [t,x]=ode45(@(t,x)fcn_odes_double_inhib(t,x,params),tspan, x0);
    trajectories{initv1}=x;
end

%% plot trajectories
figure('name','2dtrajs')
fcn_plot_trajs_diff_initvals(initvals,tspan,trajectories)