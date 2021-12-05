
Nmc=100;

graphe_V_estime3(Nmc)

function [] = graphe_V_estime3(Nmc)

K=10;

for j=1:500
    S0(j)=0.4*(j-1);
    prix_graphe(j)=V_estime3(S0(j),Nmc);
end

figure;
hold;
plot(S0,prix_graphe)
plot(S0,max(S0-K,0))
xlabel('Prix S_0')
ylabel('V_{estime3}(S_0,0)')
legend('V_{estime3}(S_0,0)','Pay-Off');
title('Graphe de l estimateur 3 de l option N_{mc}=100')

end



function [Prix_Call] = V_estime3(S0,Nmc)

% Définition des constantes et vecteurs %

K=10;
T=0.5;
r=0.1;
sigma=0.5;
valeur=0;

for n=1:Nmc
    ST(n)=S0*exp((r-(sigma^2)/2)*T+sigma*sqrt(T)*randn);
    valeur=valeur+(exp(-r*T)*Payoff_Europ_Call(ST(n),K)-b_estime(S0,Nmc)*(ST(n)-S0*exp(r*T)));
end

Prix_Call=valeur/Nmc;

end


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
