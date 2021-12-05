# Methodes_Numeriques_Avancees_pour_la_Finance
Introduire les méthodes numériques avancées utisées pour la valorisation de produits financiers (Équation de Black et Scholes...).
Les méthodes numériques fondées sur les équations aux dérivées partielles n’etaient pas très populaires jusque’à récement. Les modèles obtenus par des arguments probabilistes et simulés par les méthodes de Monte-Carlo sont en effet plus naturelles et il est plus facile à implémenter des méthodes stochastiques que les algorithmes utilisés pour les EDP.
Cependant, quand il est possible discrétiser les EDP, les algorithmes pour la résolution des équations discrétisées sont très efficaces. Les solutions, numériques
des EDP donnent plus d’informations. Elles donnent, par exemple, les prix d’une option pour toutes les valeurs initiales de l’actif sous-jacent et pour toutes les valeurs du temps d’exercice, tandis que les méthodes de Monte-Carlo les donnent pour une seule valeur de l’actif et du temps d’exercice. 
Les EDP sont aussi très efficaces pour le calcul des Greecs.
Les EDP en finance possèdent plusieurs caractéristiques. On travaille sur des domaines temporels et spatiaux finis. On doit impérativement imposer des conditions aux limites et des conditions initiales.
Les équations sont souvent parabolique, mais elles peuvent aussi contenir les termes hyperboliques, comme par exemple l’EDP pour les options asiatiques.
Des modèles de stratégie de hedging du marché nonliquide ont permis d’arriver à une équation de Black and Scholes nonlinéaire. La resolution numérique des ces équations sont indispensables.
