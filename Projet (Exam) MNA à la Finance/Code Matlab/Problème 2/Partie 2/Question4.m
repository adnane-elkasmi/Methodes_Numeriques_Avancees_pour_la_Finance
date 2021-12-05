
% Question 4

Graphe_prix_Asset_valitilite_varie_fixe(10000)

function [] = Graphe_prix_Asset_valitilite_varie_fixe(Nmc)

K=10;

for j=1:49
  S0(j)=0.5*(j-1);
  prix_sigma_varie(j)=prix_Asset_valitilite_varie_S0_fixe(S0(j),Nmc);
  prix_sigma_fixe(j)=prix_Asset_valitilite_fixe_S0_fixe(S0(j),Nmc);
end

figure;
hold on;
plot(S0,prix_sigma_varie,'r');
plot(S0,prix_sigma_fixe,'b');
title("Prix de l'option Asset par Monte-Carlo pour t=0");
legend("V(t=0,S) Volatilité variante","V(t=0,S)Volatilité constante")
xlabel("S_0");
ylabel("V(0,S_0)");
end

function [prix] = prix_Asset_valitilite_varie_S0_fixe(S0,Nmc)

sum=0;
r=0.4;
T=0.5;

for n=1:Nmc
 sum=sum+PayOff_Asset_valitile_varie_S0_fixe(S0);
end

prix=exp(-r*T)*sum/Nmc;

end

function [prix] = prix_Asset_valitilite_fixe_S0_fixe(S0,Nmc)

sum=0;
r=0.4;
T=0.5;

for n=1:Nmc
 sum=sum+PayOff_Asset_valitile_fixe_S0_fixe(S0);
end

prix=exp(-r*T)*sum/Nmc;

end


function [gain] = PayOff_Asset_valitile_varie_S0_fixe(S0)

K=10;
T=0.5;
r=0.4;
N=100;
S(1)=S0;
dt=T/N;

for i=1:N
    g=randn;
    S(i+1)=S(i)*exp((r-(Sigma_variable(S(i),K)^2)/2)*dt+Sigma_variable(S(i),K)*sqrt(dt)*g);
end

gain=Pay_off_Asset(S(N+1),K);

end

function [gain] = PayOff_Asset_valitile_fixe_S0_fixe(S0)

K=10;
T=0.5;
r=0.4;
N=100;
S(1)=S0;
sigma=0.5;
dt=T/N;

for i=1:N
    S(i+1)=S(i)*exp((r-(sigma^2)/2)*dt+sigma*sqrt(dt)*randn);
end

gain=Pay_off_Asset(S(N+1),K);

end


function [f] = Pay_off_Asset(S,K)

if (S < K)
    f=S; 
elseif (S >= K)
    f=0;
end

end

function [f] = Sigma_variable(S,K)

sigma=0.5;

if (S < K)
    f=sigma+(K-S)/K; 
elseif (S >= K)
    f=sigma;
end

end

