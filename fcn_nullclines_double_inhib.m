function [real_nonnegroots_f1_arr,real_nonnegroots_f2_arr] = fcn_nullclines_double_inhib(A_vals,B_vals,params)

params_cell = num2cell(params);
[n, kAA, kBA, beta_a, kBB, kAB, beta_b] = deal(params_cell{:});
real_nonnegroots_f1=cell(1,numel(B_vals)); % arrayfun(@(x) mat2cell(x,1) , nan(1,numel(B_vals)),'un',0 );
real_nonnegroots_f2=cell(1,numel(B_vals));  % arrayfun(@(x) mat2cell(x,1) , nan(1,numel(B_vals)),'un',0 ); 

for counter = 1:numel(B_vals)
if rem(counter/(numel(B_vals)-1),0.02)==0; disp(round(counter/numel(B_vals),2)); end
B=B_vals(counter);
% polyn from dA/dt
syms A
coeffs_f1=sym2poly(A*(A^n + kAA^n)*(kBA^n + B^n) - ...
    ( beta_a*(A^n + kAA^n)*(kBA^n + B^n) + (A^n)*((kBA^n + B^n) + kBA^n) ));
% polynomial from dB/dt
syms B
A=A_vals(counter);
coeffs_f2=sym2poly(B*(B^n + kBB^n)*(kAB^n + A^n) - ...
    ( beta_b*(B^n + kBB^n)*(kAB^n + A^n) + (B^n)*((kAB^n + A^n) + kAB^n) ));
roots_all_f1= roots(coeffs_f1); roots_all_f2=roots(coeffs_f2);
tvals_f1=cell2mat(arrayfun(@(x) isreal(roots_all_f1(x)) & roots_all_f1(x)>=0, 1:numel(roots_all_f1),'un',0));
tvals_f2=cell2mat(arrayfun(@(x) isreal(roots_all_f2(x)) & roots_all_f2(x)>=0, 1:numel(roots_all_f2),'un',0));
n_prec=4;
if sum(tvals_f1)>0; real_nonnegroots_f1{counter}=sort(unique(round(roots_all_f1(tvals_f1),n_prec)));
else real_nonnegroots_f1{counter}=NaN; end
if sum(tvals_f2)>0; real_nonnegroots_f2{counter}=sort(unique(round(roots_all_f2(tvals_f2),n_prec))); 
else real_nonnegroots_f2{counter}=NaN; end

end

real_nonnegroots_f1_arr = fcn_cell_arr_multiple(real_nonnegroots_f1);
real_nonnegroots_f2_arr = fcn_cell_arr_multiple(real_nonnegroots_f2);