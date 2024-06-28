function [price, CI, Quality] = GEOControlAsianCall(S,K,r,q,vol,T,N,NPaths1,NPaths2)
   
    rng('default');
    
    % X = ARTHOptionPrice
    Underlying = GBMPaths(S,r,q,vol,T,N,NPaths1);
    ARTHStockPrice = mean(Underlying(:,2:N+1) , 2);
    ARTHOptionPrice = exp(-r*T)*max(0,ARTHStockPrice-K);
 
    %Y = GEOOptionPrice
    % GEOStockPrice = (prod(Underlying(:,2:N+1) , 2)).^(1/N);
    GEOStockPrice = exp(mean(log(Underlying(:,2:N+1)) , 2));
    GEOOptionPrice = exp(-r*T)*max(0,GEOStockPrice-K); 
   
    SampleCov = cov( ARTHOptionPrice, GEOOptionPrice);
    c = SampleCov(1,2)/var(GEOOptionPrice);
    
    % Discard first random sample to avoid bias
    Underlying = GBMPaths(S,r,q,vol,T,N,NPaths2);
    ARTHStockPrice = mean(Underlying(:,2:N+1) , 2);
    ARTHOptionPrice = exp(-r*T)*max(0,ARTHStockPrice-K);
    GEOStockPrice = exp(mean(log(Underlying(:,2:N+1)) , 2));
    GEOOptionPrice = exp(-r*T)*max(0,GEOStockPrice-K); 

    % Theta
    bA = 1/2 * (r-q-(vol^2)/6);
    volA = vol/sqrt(3);
    d1 = (log(S/K) + (bA + volA^2/2)*T) / (volA * sqrt(T));
    d2 = d1 - volA * sqrt(T);
    ExpGEOOptionPrice = S * exp((bA - r)*T) * normcdf(d1) - K * exp(-r*T) * normcdf(d2);
    
    % Control Variate
    ControlVar = ARTHOptionPrice - c*(GEOOptionPrice - ExpGEOOptionPrice);
    [price, XX, CI] = normfit(ControlVar);
    Quality = (CI(2)-CI(1))/price/2;

end

