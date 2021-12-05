
visualiser_fonction_V_theorique()
    
function [] = visualiser_fonction_V_theorique()

% Définition des constantes %

L=20;
K=10;
T=0.5;
r=0.1;
sigma=0.5;
N=99;
M=4999;

% Définition des vecteurs %

S=linspace(0,L,N+2);
t=linspace(0,T,M+2);

V=zeros(M+2,N+2);
for n=1:M+2
for i=1:N+2
    if i==1
        V(n,i)=0;
    else
        V(n,i)=BS_theorie(S(i),K,r,sigma,t(n),T);
    end
end    
end

figure;
mesh(S,t,V)
xlabel('Prix de l actif S')
ylabel('temps t')
zlabel('Prix de l option V')
title('Solution analytique de l équation de Black et Scholes')

end

function [f] = BS_theorie(S,K,r,sigma,t,T)
if (t==T) 
    f=max(S-K,0);
else
    f=S*N(d1(S,K,r,sigma,t,T))-K*exp(-r*(T-t))*N(d2(S,K,r,sigma,t,T));
end    
end

function [f] = d1(S,K,r,sigma,t,T)
    f = (log(S/K)+(r+(sigma^2)/2)*(T-t))/(sigma*sqrt(T-t)); 
end

function [f] = d2(S,K,r,sigma,t,T)
    f = (log(S/K)+(r-(sigma^2)/2)*(T-t))/(sigma*sqrt(T-t));
end

function [f] = N(x)
    f = 1/2*(1+erf(x/sqrt(2)));
end