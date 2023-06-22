function [ux_new,uy_new,uz_new,Nscatters] = scattering(ux_old,uy_old,uz_old,g,Nscatters)
% changing the propogation vectors for the scattering of new step.

    zeta = rand();  % random function for uniformal distribution between 0-1.
    
    if g==0         % by equation from ch.3 pg.21
        cos_theta = 2*zeta-1;
    else
        cos_theta = (1/(2*g))*(1+(g^2)-((1-(g^2))/(1-g+2*g*zeta))^2);
    end
    theta = acos(cos_theta);
    phi = 2*pi*rand();
                     
    if abs(uz_old) == 1   % by equation from ch.3 pg.23 - if uz -> 1
        ux_new = sin(theta)*cos(phi);
        uy_new = sin(theta)*sin(phi);
        uz_new = sign(uz_old)*cos(theta);
    else
        ux_new = sin(theta)*(ux_old*uz_old*cos(phi)-uy_old*sin(phi))/sqrt(1-(uz_old^2))+ux_old*cos(theta);
        uy_new = sin(theta)*(uy_old*uz_old*cos(phi)+ux_old*sin(phi))/sqrt(1-(uz_old^2))+uy_old*cos(theta);
        uz_new = uz_old*cos(theta)-sqrt(1-(uz_old^2))*sin(theta)*cos(phi);
    end
    Nscatters=Nscatters+1;
end
