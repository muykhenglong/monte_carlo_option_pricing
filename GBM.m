function GBM(S,r,q,vol,T,N)
  paths = zeros(1, N+1);
  paths(1,1) = S;
  dT = T/N;
  drift = (r-q-0.5*vol^2)*dT;
  risk = vol*sqrt(dT);
  
  for i = 1:1:N
      paths(1,i+1) = paths(1,i) * exp(drift + risk*randn);
  end
  
  plot(0:dT:T, paths);
  
end
