function paths = GBMPaths(S,r,q,vol,T,N,Npaths)
    
    paths = zeros(Npaths, N+1);
    paths(:,1) = S;
    dT = T/N;
    drift = (r-q-0.5*vol^2)*dT;
    risk = vol*sqrt(dT);

    for i = 1:1:Npaths
        for j = 1:1:N
            paths(i,j+1) = paths(i,j) * exp(drift + risk*randn);
        end
  
    % for i = 1:1:Npaths
    %     plot(0:dT:T, paths(i,:));
    %     hold on;
    % end
    % 
    % hold off;

end

