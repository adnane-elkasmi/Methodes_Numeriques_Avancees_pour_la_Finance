visualiser_delta()
    
function [] = visualiser_delta()

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
delta=zeros(M+2,N+2);

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

for n=1:M+2
    for i=1:N+1
        delta(n,i)=(V(n,i+1)-V(n,i))/ds;
    end
    delta(n,N+2)=0;
end

% Question 6
figure;
hold on;
plot(S,delta(1,:));
legend('\Delta(t=0,S)');
title('Graphe de delta pour t=0')

% Question 2
figure;
mesh(S,t(1:floor(T/(2*dt))+1),delta(1:floor(T/(2*dt))+1,:))
xlabel('Prix de l actif S_t')
ylabel('temps t')
zlabel('Delta')
title('Surface de Delta')

end

% la condition finale %

function [f] = Pay_off_Asset(S,K)

if (S < K)
    f=S; 
elseif (S >= K)
    f=0;
end


end




