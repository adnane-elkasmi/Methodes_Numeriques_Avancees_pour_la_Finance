graphe_erreur()

function [] = graphe_erreur()

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
Vana=V_theorique();
Vdir=V_Dirichlet();
Vneu=V_Neumann();

figure;
hold;
plot(S,abs(Vana(1,:)-Vneu(1,:)))
plot(S,abs(Vana(1,:)-Vdir(1,:)))
xlabel('Prix de l actif S')
legend('V_{analytique}(t=0,S_i)-V_{condition Neumann}(t=0,S_i)','V_{analytique}(t=0,S_i)-V_{condition Dirichlet}(t=0,S_i)')
title('Comparaison entre les deux differences')

end

function [Vana] = V_theorique()

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

Vana=V;

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

function [Vdir] = V_Dirichlet()

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
dt=T/(M+2);
ds=L/(N+2);
V=zeros(M+2,N+2);

% Implementation de la condition finale %

for j=1:N+2
    V(M+2,j)=condition_finale(S(j),K);
end

% Implementation des conditions aux limites %

for k=1:M+1
    V(k,1)=0;
    V(k,N+2)=L-K*exp(-r*(T-t(k)));
end

% Discrétisation de l'équation de Black et Scholes %

for n=M+2:-1:2
for i=2:N+1
    V(n-1,i)=V(n,i)+dt*(r*S(i)*(V(n,i+1)-V(n,i-1))/(2*ds)+(1/2)*(sigma^2)*(S(i)^2)*((V(n,i+1)+V(n,i-1)-2*V(n,i))/(ds^2))-r*V(n,i));    
end
end

Vdir=V;

end

function [Vneu] = V_Neumann()

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
dt=T/(M+2);
ds=L/(N+2);
V=zeros(M+2,N+2);

% Implementation de la condition finale %

for j=1:N+2
    V(M+2,j)=condition_finale(S(j),K);
end

% Discrétisation de l'équation de Black et Scholes %

for n=M+2:-1:2
for i=2:N+1
    V(n-1,i)=V(n,i)+dt*(r*S(i)*(V(n,i+1)-V(n,i-1))/(2*ds)+(1/2)*(sigma^2)*(S(i)^2)*((V(n,i+1)+V(n,i-1)-2*V(n,i))/(ds^2))-r*V(n,i));    
end

% Implementation des conditions aux limites de Neumann %

    V(n-1,1)=V(n-1,2);
    V(n-1,N+2)=V(n-1,N+1)+ds;
end

Vneu=V;

end

% la condition finale %

function [f] = condition_finale(S,K)
f = max(S-K,0);
end
