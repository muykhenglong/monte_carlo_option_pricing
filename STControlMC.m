function [price CI Quality] = STControlMC(S,K,r,q,vol,T,N,N2,IsCall)
  
    rng('default');

    if IsCall
        Intrinsic = @(S) max(0,S-K);
    else
        Intrinsic = @(S) max(0,K-S);
    end

    % Euro Style
    drift = (r-q-0.5*vol^2)*T;
    risk = vol*sqrt(T);

    % Y = ST as a control variate
    % Theta = ExpectedST
    ExpectedST = S*exp((r-q)*T);
    VarST = S^2 * exp(2*(r-q)*T) * (exp(vol^2*T)-1);

    % Estimate C
    ST = S*exp(drift + risk*randn(N,1));
    SampleCov = cov( exp(-r*T)*Intrinsic(ST) , ST);
    c = SampleCov(1,2) / VarST;

    % Discard first random sample to avoid bias
    ST = S*exp(drift + risk*randn(N2,1));
    ContVar = exp(-r*T) * Intrinsic(ST) - c * (ST - ExpectedST);

    [price XX CI] = normfit(exp(-r*T)*ContVar);
    Quality = (CI(2) - CI(1))/price/2;
   
end
