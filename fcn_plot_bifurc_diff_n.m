function [] = fcn_plot_bifurc_diff_n(roots_real_nonnegat_matr,beta_vals,n_vals,k_val,plot_pars)

n_row=round(sqrt(numel(roots_real_nonnegat_matr))); n_col=n_row; 
fontsize_val=plot_pars(1);
if n_row*n_col<numel(roots_real_nonnegat_matr); n_col=n_col+1; end
figure('name', 'bifurc plot')

for k=1:numel(n_vals)
    subplot(n_row,n_col,k); 
    plot1=plot(beta_vals, roots_real_nonnegat_matr{k},'LineWidth',3); 
    set(plot1(2),'LineStyle','-.'); set(plot1([1 3]),'Color','blue');
    if k>(n_row-1)*n_col; xlabel('\beta','FontSize',fontsize_val); end
        title(strcat('n=',num2str(n_vals(k))) ,'FontSize',fontsize_val);
end
suptitle(strcat('k=',num2str(k_val)))