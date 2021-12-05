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
V=zeros(M+2,N+2);

r=0.4;

% Implementation de la condition finale %

for j=1:N+2
    V(M+2,j)=Pay_off_Asset(S(j),K);
end

% Implementation des conditions aux limites Dirichlet %

for k=1:M+1
    V(k,1)=0;
    V(k,N+2)=0;
end

% Discrétisation de l'équation de Black et Scholes %

for n=M+2:-1:2
for i=2:N+1
    V(n-1,i)=V(n,i)+dt*(r*S(i)*(V(n,i+1)-V(n,i-1))/(2*ds)+(1/2)*(sigma^2)*(S(i)^2)*((V(n,i+1)+V(n,i-1)-2*V(n,i))/(ds^2))-r*V(n,i));    
end
end

% Question 1
figure;
hold on;
plot(S,V(M+2,:));
plot(S,V(1,:));
legend('V(t=T,S)','V(t=0,S)');
title('Prix de l option t=0 et t=T')

% Question 2
figure;
mesh(S,t,V)
xlabel('Prix de l actif S_t')
ylabel('temps t')
zlabel('Prix de l option V')
title('Surface du prix de loption ASSET')

% Question 2
fprintf("V(t=T/3,S=6)=%f",V(floor(T/(3*dt))+1,floor(6/(ds))+1));

end

% la condition finale %

function [f] = Pay_off_Asset(S,K)

if (S < K)
    f=S; 
elseif (S >= K)
    f=0;
else
    f=0;
end

end




