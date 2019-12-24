function [roots_real_nonnegat_matr,roots_all] = fcn_bistab_roots(beta_vals,n_vals,k_thresh)

roots_all=cell(numel(beta_vals),numel(n_vals)); 
roots_real_nonnegat=roots_all;
roots_real_nonnegat_matr=cell(1,numel(n_vals));

for c1=1:numel(beta_vals)
    beta=beta_vals(c1);
    for c2=1:numel(n_vals)
        n=n_vals(c2);
    roots_all{c1,c2} = roots([1, -(beta+1), zeros(1,n-2), k_thresh^n, -beta*k_thresh^n]);
    tvals=cell2mat(arrayfun(@(x) isreal(roots_all{c1,c2}(x)) & roots_all{c1,c2}(x)>=0, ...
        1:numel(roots_all{c1,c2}),'un',0));
    roots_real_nonnegat{c1,c2}=unique(roots_all{c1,c2}(tvals));
    if c1==1
        z = [unique(roots_all{c1,c2}(tvals))' NaN(1,3-numel(unique(roots_all{c1,c2}(tvals))))];
    elseif c1>1 && max(sum(~isnan(roots_real_nonnegat_matr{c2}(1:max([1,c1-1]),:)')))==1
        z=[unique(roots_all{c1,c2}(tvals))' NaN(1,3-numel(unique(roots_all{c1,c2}(tvals))))];
    else
      z=[NaN(1,3-numel(unique(roots_all{c1,c2}(tvals)))) unique(roots_all{c1,c2}(tvals))'];
    end
    roots_real_nonnegat_matr{c2}(c1,:)=z;
    end
end
