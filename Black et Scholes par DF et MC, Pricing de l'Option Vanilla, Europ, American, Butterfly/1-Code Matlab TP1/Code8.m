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
hold;
plot(S,V(M+2,:));
plot(S,V(floor(T/(2*dt))+1,:));
plot(S,V(1,:));
legend('t=T','t=T/2','t=0');
title('Prix de l option t=T , t=T/2 et t=0')

end

% la condition finale %

function [f] = condition_finale(S,K)
f = max(K-S,0);
end

