
visualiser_fonction_V()
    
function [] = visualiser_fonction_V()

% Définition des constantes %

L=20;
K=10;
T=0.5;
r=0.1;
sigma=0.5;
N=99;
M=4999;
S(1)=10;
t(1)=0;
delta_t=T/(N+2);
S1=linspace(0,L,N+2);
t1=linspace(0,T,M+2);

for i=1:N+1
    S(i+1)=S(i)*exp((r-(sigma^2)/2)*delta_t+sigma*sqrt(delta_t)*randn);
    t(i+1)=t(i)+delta_t;
end

for j=1:N+2
    price_option(j)=BS_theorie(S(j),K,r,sigma,t(j),T);
end 

for k=1:M+2
    for l=1:N+2
        price_BS(k,l)=BS_theorie(S1(l),K,r,sigma,t1(k),T);
    end
end

figure;
plot3(S,t,price_option,'r','LineWidth',3)
hold on;
mesh(S1,t1,price_BS)
xlabel('Prix de l actif S')
ylabel('Temps t')
zlabel('V(S,t)')
title('Evolution of European Call')
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