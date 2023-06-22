function [W_new,dead] = Roulette(W_old,m)
% photon termination when the weight falls below threshold.
    zeta = rand(); % uniform distribution.
    if zeta <= 1/m % by equation from ch.3 pg.27
        W_new = W_old*m;
        dead = 0;
    else
        W_new = 0;
        dead = 1;
    end
end

