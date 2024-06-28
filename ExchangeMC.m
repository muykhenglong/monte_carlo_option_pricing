function [price CI Quality] = ExchangeMC(S1,S2,r,q1,q2,vol1,vol2,corr,T,N)
    
    rng('default');
    
    drift1 = (r-q1-0.5*vol1^2)*T;
    risk1 = vol1*sqrt(T);
    Z1 = randn(N,1);
    ST1 = S1 * exp(drift1 + risk1*Z1);
    
    drift2 = (r-q2-0.5*vol2^2)*T;
    risk2 = vol2*sqrt(T);
    Z2 = corr*Z1 + (1-corr^2)^.5*randn(N,1);
    ST2 = S2 * exp(drift2 + risk2*Z2);

    Intrinsic = max(0,ST1-ST2);
    [price XX CI] = normfit(exp(-r*T)*Intrinsic);
    Quality = (CI(2) - CI(1))/price/2;

end



