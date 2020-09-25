function [q_out,qnois,q_level]=uniquan(sig_in,L)
sig_pmax= max(sig_in);
sig_nmax= min(sig_in);
delta = (sig_pmax - sig_nmax)/L;
q_level = sig_nmax + delta/2 : delta : sig_pmax - delta/2;
sig_p = (sig_in - sig_nmax)/delta +1/2;
q_index=round(sig_p);
q_index=min(q_index,L);
q_out=q_level(q_index);
qnois=sig_in-q_out;
end
