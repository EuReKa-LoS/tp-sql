# Partie 1
#01 selectionner les ticket ou id article est 500
SELECT NUMERO_TICKET FROM ventes WHERE  ID_ARTICLE = 500;
#02 Afficher les tickets du 15/01/2014
SELECT NUMERO_TICKET FROM ticket WHERE  DATE_VENTE = '2014-01-15';
#03 Afficher les tickets du 15/01/2014 au 17/01/2014
SELECT NUMERO_TICKET FROM ticket WHERE  DATE_VENTE BETWEEN '2014-01-15' AND '2014-01-17';
#04 Afficher la liste des articles apparaissant à 50 et plus exemplaire sur un ticket
SELECT ID_ARTICLE FROM ventes WHERE QUANTITE >= 50;
#05 Afficher les ticket émis au moi de mars
SELECT NUMERO_TICKET FROM ticket WHERE DATE_VENTE BETWEEN '2014-03-01' AND '2014-03-31';
SELECT NUMERO_TICKET FROM ticket WHERE MONTH(DATE_VENTE) = 3 AND YEAR(DATE_VENTE) = 2014;
#06  Afficher les ticket émis entre les mois de mars et avril 2014
SELECT NUMERO_TICKET FROM ticket WHERE YEAR(DATE_VENTE) = 2014 AND MONTH(DATE_VENTE) BETWEEN 3 AND 4;
#07  Afficher les ticket émis au moi de mars et juin 2014
SELECT NUMERO_TICKET, MONTH(DATE_VENTE) FROM ticket WHERE YEAR(DATE_VENTE) = 2014 AND MONTH(DATE_VENTE) IN (3,6);
#08 Afficher les bières classées par couleur.
SELECT ID_ARTICLE, NOM_ARTICLE FROM article ORDER BY ID_Couleur;
#09 Afficher la liste des bières n ayant pas de couleur.
SELECT ID_ARTICLE, NOM_ARTICLE, ID FROM article WHERE ID_Couleur IS NULL;

# Partie 2
#10 Listez pour chaque ticket la quantité totale d’articles vendus. (Classer par quantité décroissante)
SELECT NUMERO_TICKET, SUM(QUANTITE) FROM ventes GROUP BY NUMERO_TICKET ORDER BY SUM(QUANTITE) DESC;
#11 Listez chaque ticket pour lequel la quantité totale d’articles vendus est supérieure à 500.
# Classer par quantité décroissante
SELECT NUMERO_TICKET, SUM(QUANTITE) FROM ventes GROUP BY NUMERO_TICKET HAVING SUM(QUANTITE) > 500 ORDER BY SUM(QUANTITE) DESC;
#12 Listez chaque ticket pour lequel la quantité totale d’articles vendus est supérieure à 500.
# On exclura du total, les ventes ayant une quantité supérieure à 50 (classer par quantité décroissante)
SELECT NUMERO_TICKET FROM ventes WHERE QUANTITE < 50 GROUP BY NUMERO_TICKET HAVING SUM(QUANTITE) > 500 ORDER BY SUM(QUANTITE) DESC;
#13 Listez les bières de type 'Trappiste'.(id, nom de la bière, volume).
SELECT ID_ARTICLE, NOM_ARTICLE, VOLUME FROM article WHERE Nom_type = 'Trappiste';
#14 Listez les marques de bières du continent 'Afrique'