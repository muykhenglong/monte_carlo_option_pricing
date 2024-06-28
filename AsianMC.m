function [price, CI, Quality] = AsianMC(S,K,r,q,vol,T,N,NPaths,IsCall)
    
    rng('default');
 
    if IsCall
    Intrinsic = @(S) max(0, S- K);
    else
    Intrinsic = @(S) max(0, K - S);
    end
    
    % X
    Underlying = GBMPaths(S,r,q,vol,T,N,NPaths);
    AVEPrice = mean(Underlying(:,2:N+1) , 2);
    [price, XX, CI] = normfit(exp(-r*T)*Intrinsic(AVEPrice));
    Quality = (CI(2)-CI(1))/price/2;

end
