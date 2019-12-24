function [] = fcn_plot_double_inhib(B_vals,real_nonnegroots_f1,A_vals,real_nonnegroots_f2,params,...
                            plot_pars,vectorfield_flag)

figure('name','multistab'); fontsize_val=plot_pars{1}; linewidth_val=plot_pars{2}; linewidth_val2=plot_pars{3}; 
parnames=plot_pars{4}; legend_str=plot_pars{5};
plot1=plot(B_vals,real_nonnegroots_f1,'LineWidth',linewidth_val); hold on; 
set(plot1(2),'Color','red','LineStyle','-.'); set(plot1([1 3]),'Color','blue','LineStyle','none','Marker','o'); % 
legend(legend_str); hold on;
% dB/dt nullcline
plot2=plot(real_nonnegroots_f2,A_vals,'LineWidth',linewidth_val); % 'LineWidth',linewidth_val,
set(plot2([1 3]),'LineStyle','none','Marker','o','Color','green'); set(plot2(2),'Color','magenta','LineStyle','-.'); 
title(strcat(parnames, strjoin(arrayfun(@(x) num2str(x),params,'un',0),',') ), ...
    'FontSize',fontsize_val*1.25,'interpreter','latex');
xlabel('B','FontSize',fontsize_val); ylabel('A','FontSize',fontsize_val); 
xlim(B_vals([1 end])); ylim(A_vals([1 end]));

if ~isempty(vectorfield_flag)
    resol_param=plot_pars{6};
    stepsize=round(resol_param*numel(A_vals)); 
    A=meshgrid(A_vals(1:stepsize:end))'; B=meshgrid(B_vals(1:stepsize:end));
    params_cell = num2cell(params);
    [n, kAA, kBA, beta_a, kBB, kAB, beta_b] = deal(params_cell{:});
    f1=beta_a + ( (A.^n)./(A.^n + kAA^n) ).*( 1 + (kBA^n)./(kBA^n + B.^n) ) - A;
    f2=beta_b + ( (B.^n)./(B.^n + kBB^n) ).*( 1 + (kAB^n)./(kAB^n + A.^n) ) - B;
    quiver(A,B,f1,f2) % ,2
end
    
hold off;