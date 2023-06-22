function dW = absorption(W,mua,mut,step)
% relative absorption and beer law for absorbtion
    %dW = (mua/mut)*W;
    dW = (1-exp(-mua*step))*W;
end
