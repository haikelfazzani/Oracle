select * from client;
SET SERVEROUTPUT ON

-- Question 1 :
DECLARE
    nb_total NUMBER;
    nb_client_tunis number;
    percnt number;
BEGIN
    SELECT COUNT(*) INTO nb_total FROM CLIENT;
    SELECT COUNT(*) INTO nb_client_tunis FROM CLIENT WHERE VILLECLIENT = 'TUNIS';
    percnt := (nb_client_tunis * 100) / nb_total;
    DBMS_OUTPUT.PUT_LINE(
        'Nombre total des clients = ' || nb_total || chr(10) || 
        'Nombre client - Tunis = ' || nb_client_tunis || chr(10) || 
        'Percentage des client - Tunis = ' || percnt || ' %');
END;
/

-- Question 1 :
CREATE OR REPLACE PROCEDURE AFFICHER_VILLE (ville_input CLIENT.VILLECLIENT%TYPE) IS
    nb_client NUMBER;
    nb_total NUMBER;
    perc NUMBER;
BEGIN
    SELECT COUNT(*) INTO nb_total FROM CLIENT;
    SELECT COUNT(*) INTO nb_client FROM CLIENT WHERE VILLECLIENT = ville_input;
    perc := (nb_client * 100) / nb_total;
    DBMS_OUTPUT.PUT_LINE('Le pourcentage des clients = ' || perc || ' %');
END;
/
EXECUTE AFFICHER_VILLE('NABEUL');

-- Question 3 :
CREATE OR REPLACE PROCEDURE AUG_PRIX IS
BEGIN
    UPDATE ARTICLE SET PRIXUNITAIRE = PRIXUNITAIRE * 1.05;
END;
/

EXECUTE AUG_PRIX;

-- Question 4 :
SELECT * FROM ARTICLE;
CREATE OR REPLACE PROCEDURE MODIFIER_PRIX (
    id_article ARTICLE.IDARTICLE%TYPE,
    prix_art ARTICLE.PRIXUNITAIRE%TYPE) IS
BEGIN
    UPDATE ARTICLE SET PRIXUNITAIRE = prix_art WHERE IDARTICLE = id_article;
END;
/

BEGIN
    MODIFIER_PRIX('PR101' ,15.75);
END;
/

-- Question 5 :
SELECT * FROM VENTE;
CREATE OR REPLACE PROCEDURE Calcule_qte_vendue (id_artcile VENTE.IDARTICLE%TYPE) IS
    qte_vendue VENTE.QTEVENDUE%TYPE;
BEGIN
    SELECT QTEVENDUE INTO qte_vendue FROM VENTE WHERE IDARTICLE = id_artcile;
    DBMS_OUTPUT.PUT_LINE('Quantite vendue de ' || id_artcile || ' est ' || qte_vendue);
END;
/

BEGIN
    Calcule_qte_vendue('PR100');
END;
/


-- Question 6 :
CREATE OR REPLACE PROCEDURE Calcule_Montant (
    prix_unitaire ARTICLE.PRIXUNITAIRE%TYPE, 
    quantite ARTICLE.QTESTOCK%TYPE
) IS
    MONTANT FLOAT;
BEGIN
    MONTANT := prix_unitaire * quantite;
    DBMS_OUTPUT.PUT_LINE('Le montant est = ' || MONTANT);
END;
/

BEGIN
    Calcule_Montant(15.5 , 10);
END;
/

-- Question 7 :
CREATE OR REPLACE FUNCTION Prix_ventes_total 
    RETURN VENTE.PRIXVENTE%TYPE IS
     prix_total VENTE.PRIXVENTE%TYPE; 
BEGIN
    SELECT SUM(PRIXVENTE) INTO prix_total FROM VENTE;
    RETURN prix_total;
END;
/

DECLARE
    prix_total VENTE.PRIXVENTE%TYPE := Prix_ventes_total;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Prix vente total est = ' || prix_total);
END;
/


-- Question 8 :
select * from VENTE;
DESC VENTE;
CREATE OR REPLACE FUNCTION Quantite_vendeur (vend VENTE.NUMVENDEUR%TYPE)
    RETURN VENTE.QTEVENDUE%TYPE IS
    qte_total VENTE.QTEVENDUE%TYPE;
BEGIN
    SELECT SUM(QTEVENDUE) INTO qte_total FROM VENTE WHERE NUMVENDEUR = vend;
    RETURN qte_total;
END;
/

DECLARE
    qte_total VENDEUR.QTEVENDUE%TYPE;
BEGIN
    qte_total := Quantite_vendeur('VE1');
    DBMS_OUTPUT.PUT_LINE(qte_total);
END;
/

-- Qestion 9 :
SELECT * FROM FOURNISSEUR;
CREATE OR REPLACE PROCEDURE Affiche_Fournisseur (id_article ARTICLE.IDARTICLE%TYPE) IS
    nom_fourn FOURNISSEUR.NOMFOURNISSEUR%TYPE;
    num_tel_fourn FOURNISSEUR.TELFOURNISSEUR%TYPE;
BEGIN
    SELECT FOU.NOMFOURNISSEUR , FOU.TELFOURNISSEUR 
    INTO nom_fourn , num_tel_fourn
    FROM ARTICLE ART JOIN FOURNISSEUR FOU
    ON ART.NUMFOURNISSEUR = FOU.NUMFOURNISSEUR
    WHERE ART.IDARTICLE = id_article;
    
    DBMS_OUTPUT.PUT_LINE(
        'Nom fournisseur est : ' || nom_fourn || chr(10) || 
        'Numero de fournisseur est : ' || num_tel_fourn);
END;
/

BEGIN
    Affiche_Fournisseur('PR100');
END;
/


-- Question 10 :
CREATE OR REPLACE FUNCTION  Compter_Client(ville CLIENT.VILLECLIENT%TYPE) 
    RETURN NUMBER IS
    
    NB_CLIENT NUMBER;
BEGIN
    SELECT COUNT(*) INTO NB_CLIENT FROM CLIENT WHERE VILLECLIENT = ville;
    RETURN NB_CLIENT;
END;
/

SELECT * FROM CLIENT;
DECLARE
    NB_CLIENT NUMBER;
BEGIN
    NB_CLIENT := Compter_Client(UPPER('Tunis'));
    DBMS_OUTPUT.PUT_LINE(NB_CLIENT);
    EXCEPTION 
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/




