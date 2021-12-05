visualiser_fonction_V_analytique()
    
function [] = visualiser_fonction_V_analytique()

% Définition des constantes %

L=60;
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
    V(M+2,j)=PayOff_Butterfly(S(j),K);
end

for n=M+2:-1:2
for i=2:N+1
    
    % Implementation des conditions aux limites de Neumann %

    V(n-1,1)=V(n-1,2);
    V(n-1,N+2)=V(n-1,N+1)+ds;
    
    % Discrétisation de l'équation de Black et Scholes %
    
    V(n-1,i)=V(n,i)+dt*(r*S(i)*(V(n,i+1)-V(n,i-1))/(2*ds)+(1/2)*(sigma^2)*(S(i)^2)*((V(n,i+1)+V(n,i-1)-2*V(n,i))/(ds^2))-r*V(n,i));    
end
end

figure;
mesh(S,t,V)
xlabel('Prix de l actif S')
ylabel('temps t')
zlabel('Prix de l option Butterfly V')
title('Solution de l équation de Black et Scholes')

end

% la condition finale %

function [f] = PayOff_Butterfly(S,K)
f = max(S-K,0)+max(S-3*K,0)-2*max(S-2*K,0);
end

