function [ux_new,uy_new,uz_new,layer_num,dead] = transmitReflect(ux_old,uy_old,uz_old,refInd,layer_num)
% Transmit or Reflect a photon packet after hitting a boundary.
    dead = 0;
    % preperation for Snell's law:
    ni = refInd(layer_num);
    if uz_old > 0                   % moving forward - nt is the next boundary.
        nt = refInd(layer_num+1);
    elseif layer_num > 1            % for more than one layer.
        nt = refInd(layer_num-1);
    else                            % moving backward - nt is out: air.
        nt = 1;
    end
    alpha_i = acos(abs(uz_old));
    % Transmite/Reflect:
    if ni == nt                     % the same refractive index for the tissues.
        Reflectence = 0;
        alpha_t = alpha_i;        
    elseif (ni > nt) && (alpha_i > asin(nt/ni)) % TIR
        Reflectence = 1;
    else                                        % Fresnel for non-polorized light.
        alpha_t = asin((ni/nt)*sin(alpha_i));
        Reflectence = 0.5*((sin(alpha_i-alpha_t))^2/(sin(alpha_i+alpha_t))^2+...
                           (tan(alpha_i-alpha_t))^2/(tan(alpha_i+alpha_t))^2);
    end
    
    % rejection method:
    zeta = rand();                              % uniform distribution.
    if (zeta <= Reflectence)                    % Reflectance
        ux_new = ux_old;
        uy_new = uy_old;
        uz_new = -uz_old;
    else                                        % Transmission
        ux_new = ux_old*ni/nt;
        uy_new = uy_old*ni/nt;
        uz_new = sign(uz_old)*cos(alpha_t);
        layer_num = layer_num + sign(uz_old);
        if (layer_num == 0) || (layer_num == length(refInd))
            dead = 1;
        end
    end
end

