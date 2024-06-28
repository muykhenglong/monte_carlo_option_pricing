function price = EurCallMC(S,K,r,q,vol,T,N)
    
    rng('default');
    
    drift = (r-q-0.5*vol^2)*T;
    risk = vol*sqrt(T);
    ST = S * exp(drift + risk*randn(N,1));
    Intrinsic = max(0,ST-K);
    price = mean(exp(-r*T)*Intrinsic);

end

