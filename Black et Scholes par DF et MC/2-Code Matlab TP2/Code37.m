S0=10;

fprintf("Pour Nmc=10, b= %f\n",b_estime(S0,10));
fprintf("Pour Nmc=100, b= %f\n",b_estime(S0,100));

function [b] = b_estime(S0,Nmc)

% Définition des constantes et vecteurs %

K=10;
T=0.5;
r=0.1;
sigma=0.5;
Nominateur=0;
Denominateur=0;

for n=1:Nmc
    ST(n)=S0*exp((r-(sigma^2)/2)*T+sigma*sqrt(T)*randn);
    Nominateur=Nominateur+(exp(-r*T)*Payoff_Europ_Call(ST(n),K)-Esperance_estime(S0,Nmc))*(ST(n)-S0*exp(r*T));
    Denominateur=Denominateur+(ST(n)-S0*exp(r*T))^2;
end

b=Nominateur/Denominateur;

end

function [prix] = Esperance_estime(S0,Nmc)

% Définition des constantes et vecteurs %

K=10;
T=0.5;
r=0.1;
sigma=0.5;

for n=1:Nmc
    ST(n)=S0*exp((r-(sigma^2)/2)*T+sigma*sqrt(T)*randn);
    gain(n)=Payoff_Europ_Call(ST(n),K);
end

prix=exp(-r*T)*mean(gain);

end

function [f] = Payoff_Europ_Call(S,K)
f=max(S-K,0);
end
