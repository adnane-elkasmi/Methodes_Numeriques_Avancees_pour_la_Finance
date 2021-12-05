visualiser_fonction_V()
    
function [] = visualiser_fonction_V()

% Définition des constantes %

L=30;
K=10;
T=0.5;
sigma=0.5;
N=99;
M=4999;

% Définition des vecteurs %

S=linspace(0,L,N+2);
t=linspace(0,T,M+2);
dt=T/(M+2);
ds=L/(N+2);
Vneu=zeros(M+2,N+2);
Vdir=zeros(M+2,N+2);
Vneu=zeros(M+2,N+2);

r=0.4;

% Implementation de la condition finale %

for j=1:N+2
    Vdir(M+2,j)=Pay_off_Asset(S(j),K);
    Vneu(M+2,j)=Pay_off_Asset(S(j),K);
end

% Implementation des conditions aux limites Dirichlet %

for k=1:M+1
    Vdir(k,1)=0;
    Vdir(k,N+2)=0;
end

% Discrétisation de l'équation de Black et Scholes %

for n=M+2:-1:2
for i=2:N+1
    Vdir(n-1,i)=Vdir(n,i)+dt*(r*S(i)*(Vdir(n,i+1)-Vdir(n,i-1))/(2*ds)+(1/2)*(sigma^2)*(S(i)^2)*((Vdir(n,i+1)+Vdir(n,i-1)-2*Vdir(n,i))/(ds^2))-r*Vdir(n,i));
    Vneu(n-1,i)=Vneu(n,i)+dt*(r*S(i)*(Vneu(n,i+1)-Vneu(n,i-1))/(2*ds)+(1/2)*(sigma^2)*(S(i)^2)*((Vneu(n,i+1)+Vneu(n,i-1)-2*Vneu(n,i))/(ds^2))-r*Vneu(n,i));
   
    % Question 4
    
    % Implementation des conditions aux limites Newmann %
    
    %Pour S=0
    Vneu(n-1,1)=Vneu(n-1,2)-ds;
    %Pour S=L
    Vneu(n-1,N+2)=Vneu(n-1,N+1);
   

end
end


% Question 5
figure;
hold on;
plot(S,Vneu(M+2,:));
plot(S,Vneu(1,:));
plot(S,Vdir(1,:),'.','LineWidth',0.01);
legend('t=T','Newmann t=0','Dirichlet t=0');
title('Prix de l option t=T et t=0')



end

% la condition finale %

function [f] = Pay_off_Asset(S,K)

if (S < K)
    f=S; 
elseif (S >= K)
    f=0;
end

end




