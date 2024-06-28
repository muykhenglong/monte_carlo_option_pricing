function [price, CI, Quality] = ControlAsian(S,K,r,q,vol,T,N,NPaths1,NPaths2,IsCall)
   
    rng('default');
 
    if IsCall
    Intrinsic = @(S) max(0, S- K);
    else
    Intrinsic = @(S) max(0, K - S);
    end
    
    % X
    Underlying = GBMPaths(S,r,q,vol,T,N,NPaths1);
    AVEPrice = mean(Underlying(:,2:N+1) , 2);
    ARTHPrice = exp(-r*T)*Intrinsic(AVEPrice);
    SUMPrice = sum(Underlying, 2);
    SampleCov = cov( ARTHPrice, SUMPrice);
    c = SampleCov(1,2)/var(SUMPrice);
   
    % Discard first random sample to avoid bias
    Underlying = GBMPaths(S,r,q,vol,T,N,NPaths2);
    AVEPrice = mean(Underlying(:,2:N+1) , 2);
    ARTHPrice = exp(-r*T)*Intrinsic(AVEPrice);
    SUMPrice = sum(Underlying, 2);
    
    % Expected Sum
    dT = T/N;
    ExpectedSum = S * (1 - exp( (r-q)*dT*(N+1) ))/(1 - exp( (r-q)*dT)) ;
    
    % Control Variate
    ControlVar = ARTHPrice - c*(SUMPrice - ExpectedSum);
    [price, XX, CI] = normfit(ControlVar);
    Quality = (CI(2)-CI(1))/price/2;

end
