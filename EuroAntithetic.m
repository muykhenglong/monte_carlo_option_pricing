function [price CI Quality] = EuroAntithetic(S,K,r,q,vol,T,N,IsCall)
    
    rng('default');

    if IsCall
        Intrinsic = @(S) max(0,S-K);
    else
        Intrinsic = @(S) max(0,K-S);
    end
    
    drift = (r-q-0.5*vol^2)*T;
    risk = vol*sqrt(T);
    Z = randn(N,1);
    ST1 = S * exp(drift + risk*Z);
    ST2 = S * exp(drift + risk*(-Z));
    X = 0.5 * Intrinsic(ST1) + 0.5 * Intrinsic(ST2);
    [price XX CI] = normfit(exp(-r*T)*X);
    Quality = (CI(2) - CI(1))/price/2;

end



