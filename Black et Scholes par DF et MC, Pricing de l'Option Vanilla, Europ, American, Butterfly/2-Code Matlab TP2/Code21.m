% Prix du Call pour S0=10 par Monte-Carlo %

S0=10;

fprintf("Le prix du Call pour S0=10 par Monte-Carlo est: %f\n",Prix_Europ_S0_fixe_MC(S0));

function [prix] = Prix_Europ_S0_fixe_MC(S0)

% Définition des constantes %

K=10;
T=0.5;
r=0.1;
sigma=0.5;
Nmc=10000;
sum=0;

% Methode Monte-Carlo pour calculer S %

for n=1:Nmc
    S(n)=S0*exp((r-(sigma^2)/2)*T+sigma*sqrt(T)*randn);
    sum=sum+Payoff_Europ_Call(S(n),K);
end

prix=exp(-r*T)*sum/Nmc;
end

% la condition finale %

function [f] = Payoff_Europ_Call(S,K)
f=max(S-K,0);
end
