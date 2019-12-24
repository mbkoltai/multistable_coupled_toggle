function real_nonnegroots_f1_arr = fcn_cell_arr_multiple(real_nonnegroots_f1)

max_ss_n=max(cellfun(@(x) numel(x),real_nonnegroots_f1));
real_nonnegroots_f1_arr=nan(numel(real_nonnegroots_f1), max_ss_n );
ss_inds=arrayfun(@(x) cellfun(@(x) numel(x),real_nonnegroots_f1)==x,1:max_ss_n,'un',0);
for ks=1:max_ss_n
    rel_ss=horzcat(real_nonnegroots_f1{ss_inds{ks}})';
    real_nonnegroots_f1_arr(ss_inds{ks},1:ks)=rel_ss;
end
