# Partie 1
#01 selectionner les ticket ou id article est 500
SELECT NUMERO_TICKET FROM ventes WHERE  ID_ARTICLE = 500;
#02 Afficher les tickets du 15/01/2014
SELECT NUMERO_TICKET FROM ticket WHERE  DATE_VENTE = '2014-01-15';
#03 Afficher les tickets du 15/01/2014 au 17/01/2014
SELECT NUMERO_TICKET FROM ticket WHERE  DATE_VENTE BETWEEN '2014-01-15' AND '2014-01-17';
#04 Afficher la liste des articles apparaissant à 50 et plus exemplaire sur un ticket
SELECT ID_ARTICLE FROM ventes WHERE QUANTITE >= 50;
# Avec join
SELECT
#05 Afficher les ticket émis au moi de mars
SELECT NUMERO_TICKET FROM ticket WHERE DATE_VENTE BETWEEN '2014-03-01' AND '2014-03-31';
SELECT NUMERO_TICKET FROM ticket WHERE MONTH(DATE_VENTE) = 3 AND YEAR(DATE_VENTE) = 2014;
#06  Afficher les ticket émis entre les mois de mars et avril 2014
SELECT NUMERO_TICKET FROM ticket WHERE YEAR(DATE_VENTE) = 2014 AND MONTH(DATE_VENTE) BETWEEN 3 AND 4;
#07  Afficher les ticket émis au moi de mars et juin 2014
SELECT NUMERO_TICKET, MONTH(DATE_VENTE) FROM ticket WHERE YEAR(DATE_VENTE) = 2014 AND MONTH(DATE_VENTE) IN (3,6);
#08 Afficher les bières classées par couleur.
SELECT ID_ARTICLE, NOM_ARTICLE FROM article ORDER BY ID_Couleur;
# Avec join et nom de couleur
SELECT ID_ARTICLE.article, NOM_ARTICLE.article, NOM_COULEUR.couleur FROM article JOIN couleur ON article.ID_Couleur = couleur.ID_Couleur;


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
# SELECT ID_ARTICLE, NOM_ARTICLE, VOLUME FROM article WHERE ID_Type = 13;
SELECT ID_ARTICLE, NOM_ARTICLE, VOLUME FROM article WHERE ID_TYPE = (SELECT ID_TYPE FROM type WHERE NOM_TYPE = 'Trappiste');
# Avec join
SELECT ID_ARTICLE, NOM_ARTICLE, VOLUME FROM article JOIN type ON article.ID_TYPE = type.ID_TYPE WHERE NOM_TYPE = 'Trappiste';
#14 Listez les marques de bières du continent 'Afrique' table marque(id_marque, nom_marque, id_pays), pays(id_pays, nom_pays, id_continent), continent(id_contient, nom_contient)
SELECT NOM_MARQUE FROM marque WHERE ID_PAYS IN (SELECT ID_PAYS FROM pays WHERE ID_CONTINENT IN (SELECT ID_CONTINENT FROM continent WHERE NOM_CONTINENT = 'Afrique'));
# Avec join
SELECT NOM_MARQUE FROM marque JOIN pays ON marque.ID_PAYS = pays.ID_PAYS JOIN continent ON pays.ID_CONTINENT = continent.ID_CONTINENT WHERE NOM_CONTINENT = 'Afrique';
#15 Lister les bières du continent ‘Afrique’
SELECT NOM_ARTICLE FROM article WHERE ID_MARQUE IN (SELECT ID_MARQUE FROM marque WHERE ID_PAYS IN (SELECT ID_PAYS FROM pays WHERE ID_CONTINENT = (SELECT ID_CONTINENT FROM continent WHERE NOM_CONTINENT = 'Afrique')));
# Avec join
SELECT NOM_ARTICLE FROM article JOIN marque ON article.ID_MARQUE = marque.ID_MARQUE JOIN pays ON marque.ID_PAYS = pays.ID_PAYS JOIN continent ON pays.ID_CONTINENT = continent.ID_CONTINENT WHERE NOM_CONTINENT = 'Afrique';
#16. Lister les tickets (année, numéro de ticket, montant total payé).
# article(id_article) ventes(annnee, numero_ticket, id_article, quantite) ticket (annee, numero_ticket, date_vente)
SELECT ANNEE, NUMERO_TICKET, SUM(QUANTITE) FROM ventes GROUP BY ANNEE, NUMERO_TICKET;
#17 Donner le C.A. par année.
SELECT ANNEE, SUM(QUANTITE) FROM ventes GROUP BY ANNEE;
#18. Lister les quantités vendues de chaque article pour l’année 2016.
SELECT ID_ARTICLE, SUM(QUANTITE) FROM ventes WHERE ANNEE = 2016 GROUP BY ID_ARTICLE;
#19. Lister les quantités vendues de chaque article pour les années 2014, 2015, 2016.
SELECT ID_ARTICLE, SUM(QUANTITE) FROM ventes WHERE ANNEE BETWEEN 2014 AND 2016 GROUP BY ID_ARTICLE;

#Après toutes ces bière ca tape !
#TP Beez - Partie 3
# Vous devrez utiliser des sous requêtes pour toutes les questions !
#20. Listez les articles qui n’ont fait l’objet d’aucune vente en 2014.
SELECT ID_ARTICLE FROM article WHERE ID_ARTICLE NOT IN (SELECT ID_ARTICLE FROM ventes WHERE ANNEE = 2014);
#21. Codez de 2 manières différentes la requête suivante : Listez les pays qui fabriquent des bières de type ‘Trappiste’.
SELECT ID_PAYS FROM marque WHERE ID_MARQUE IN (SELECT ID_MARQUE FROM article WHERE ID_TYPE = (SELECT ID_TYPE FROM type WHERE NOM_TYPE = 'Trappiste'));
#Avec join
SELECT ID_PAYS FROM marque JOIN article ON marque.ID_MARQUE = article.ID_MARQUE JOIN type ON article.ID_TYPE = type.ID_TYPE WHERE NOM_TYPE = 'Trappiste';
#22. Listez les tickets sur lesquels apparaissent un des articles apparaissant aussi sur le ticket 2014-856.
SELECT NUMERO_TICKET FROM ventes WHERE ID_ARTICLE IN (SELECT ID_ARTICLE FROM ventes WHERE NUMERO_TICKET = '2014-856');
#23. Listez les articles ayant un degré d’alcool plus élevé que la plus forte des trappistes. (wtf ?)
-- Vous devrez partir de la table article
-- Vous devrez réaliser une sous requête dans le WHERE, afin de récupérer le titrage de la plus forte des trappistes
-- Vous devrez utiliser la fonction MAX dans la sous requête
-- Votre sous requête aura besoin d'une sous requête pour récupérer l'ID_TYPE de la bière
-- Vous devrez utiliser la fonction ORDER BY dans la requête principale
SELECT ID_ARTICLE, NOM_ARTICLE, TITRAGE FROM article WHERE TITRAGE > (SELECT MAX(TITRAGE) FROM article WHERE ID_TYPE = (SELECT ID_TYPE FROM type WHERE NOM_TYPE = 'Trappiste')) ORDER BY TITRAGE DESC;
#Avec join pour le fun
SELECT ID_ARTICLE, NOM_ARTICLE, TITRAGE FROM article JOIN type ON article.ID_TYPE = type.ID_TYPE WHERE TITRAGE > (SELECT MAX(TITRAGE) FROM article WHERE ID_TYPE = (SELECT ID_TYPE FROM type WHERE NOM_TYPE = 'Trappiste')) ORDER BY TITRAGE DESC;
#24. Editez les quantités vendues pour chaque couleur en 2014.
SELECT ID_COULEUR, SUM(QUANTITE) FROM ventes JOIN article ON ventes.ID_ARTICLE = article.ID_ARTICLE WHERE ANNEE = 2014 GROUP BY ID_COULEUR;
#25. Donnez l’ID, le nom, le volume et la quantité vendue des 20 articles les plus vendus en 2016.
SELECT ventes.ID_ARTICLE, NOM_ARTICLE, VOLUME, SUM(QUANTITE) FROM ventes JOIN article ON ventes.ID_ARTICLE = article.ID_ARTICLE WHERE ANNEE = 2016 GROUP BY ID_ARTICLE ORDER BY SUM(QUANTITE) DESC LIMIT 20;
#26. Donner l’ID, le nom, le volume et la quantité vendue des 5 ‘Trappistes’ les plus vendus en 2016.
SELECT ventes.ID_ARTICLE, NOM_ARTICLE, VOLUME, SUM(QUANTITE) FROM ventes JOIN article ON ventes.ID_ARTICLE = article.ID_ARTICLE WHERE ANNEE = 2016 AND ID_TYPE = (SELECT ID_TYPE FROM type WHERE NOM_TYPE = 'Trappiste') GROUP BY ID_ARTICLE ORDER BY SUM(QUANTITE) DESC LIMIT 5;
#
#TP Beez - PArtie 4

