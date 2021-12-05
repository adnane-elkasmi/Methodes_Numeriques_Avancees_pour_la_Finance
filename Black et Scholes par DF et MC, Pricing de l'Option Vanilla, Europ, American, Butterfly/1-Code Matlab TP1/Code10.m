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
Veu=zeros(M+2,N+2);
Vam=zeros(M+2,N+2);


% Implementation de la condition finale %

for j=1:N+2
    V(M+2,j)=condition_finale(S(j),K);
    Veu(M+2,j)=condition_finale(S(j),K);
    Vam(M+2,j)=condition_finale(S(j),K);
end

for n=M+2:-1:2
for i=2:N+1
    
    % Implementation des conditions aux limites de Neumann %

    V(n-1,1)=V(n-1,2);
    V(n-1,N+2)=V(n-1,N+1)+ds;
    Veu(n-1,1)=Veu(n-1,2); % Européen
    Veu(n-1,N+2)=Veu(n-1,N+1)+ds; % Européen
    Vam(n-1,1)=Vam(n-1,2); % Americain
    Vam(n-1,N+2)=Vam(n-1,N+1)+ds; % Americain
    
    % Discrétisation de l'équation de Black et Scholes %
    
    V(n-1,i)=V(n,i)+dt*(r*S(i)*(V(n,i+1)-V(n,i-1))/(2*ds)+(1/2)*(sigma^2)*(S(i)^2)*((V(n,i+1)+V(n,i-1)-2*V(n,i))/(ds^2))-r*V(n,i));
    Veu(n-1,i)=V(n-1,i); % Européen
    Vam(n-1,i)=max(V(n-1,i),max(K-S(i),0)); % Americain
end
end

figure;
hold;
plot(S,Veu(M+2,:));
plot(S,Vam(M+2,:));
plot(S,Veu(floor(T/(2*dt))+1,:));
plot(S,Vam(floor(T/(2*dt))+1,:));
plot(S,Veu(1,:));
plot(S,Vam(1,:));
legend('Put Européen t=T','Put Americain t=T','Put Européen t=T/2','Put Americain t=T/2','Put Européen t=0','Put Americain t=0');
title('Comparaison des Prix de l option Européen et Americain' )

end

% la condition finale %

function [f] = condition_finale(S,K)
f = max(0,K-S);
end

