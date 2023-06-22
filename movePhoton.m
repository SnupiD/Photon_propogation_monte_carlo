function [x_new,y_new,z_new] = movePhoton(x_old,y_old,z_old,ux,uy,uz,step)
%advance the photon packet to the next step.

    x_new = x_old + ux*step; %by equation from ch.3 pg.19
    y_new = y_old + uy*step;
    z_new = z_old + uz*step;
end

