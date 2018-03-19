-- TP 2 : Haikel Fazzani
SET SERVEROUTPUT ON

-- Question 1 :
DECLARE
    CURSOR curs IS SELECT ART.IDARTICLE, F.NUMFOURNISSEUR , F.NOMFOURNISSEUR , F.ADRESSFOURNISSEUR 
    FROM ARTICLE ART JOIN FOURNISSEUR F
    ON ART.NUMFOURNISSEUR = F.NUMFOURNISSEUR ;
BEGIN
    FOR curs_fourn IN curs LOOP
         DBMS_OUTPUT.PUT_LINE(
            'Num Article : ' || curs_fourn.IDARTICLE || chr(10) ||
            'Num Fournisseur : ' || curs_fourn.NUMFOURNISSEUR || chr(10) ||
            'Nom Fournisseur : ' || curs_fourn.NOMFOURNISSEUR || chr(10) ||
            'Addresse Fournisseur : ' || curs_fourn.ADRESSFOURNISSEUR || chr(10)
         );
    END LOOP;
END;
/


-- Question 2 :
DECLARE
    CURSOR curs IS SELECT * FROM ARTICLE;
    art ARTICLE%ROWTYPE;
BEGIN
    IF NOT curs%ISOPEN THEN
        OPEN curs;
    END IF;
    
    LOOP 
        FETCH curs INTO art;
        EXIT WHEN curs%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(
                'Num Article : ' || art.IDARTICLE || chr(10) ||
                'Libelle Article : ' || art.LIBELLEARTICLE || chr(10) ||
                'Prix unitaire Article : ' || art.PRIXUNITAIRE || chr(10) ||
                'Qte Seuil Article : ' || art.QTESEUIL || chr(10) ||
                'Qte stock Article : ' || art.QTESTOCK || chr(10) ||
                'Num Fournisseur Article : ' || art.NUMFOURNISSEUR || chr(10)
            );
    END LOOP;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

-- Question 3 :
CREATE OR REPLACE PROCEDURE afficher_fourn (fourn FOURNISSEUR.NUMFOURNISSEUR%TYPE) IS
    CURSOR curs IS SELECT A.IDARTICLE , A.LIBELLEARTICLE
    FROM ARTICLE A JOIN FOURNISSEUR F
    ON A.NUMFOURNISSEUR = F.NUMFOURNISSEUR
    WHERE F.NUMFOURNISSEUR = fourn;
    
    nom_fourn FOURNISSEUR.NOMFOURNISSEUR%TYPE;
    
BEGIN
    SELECT NOMFOURNISSEUR INTO nom_fourn FROM FOURNISSEUR WHERE NUMFOURNISSEUR = fourn;

    DBMS_OUTPUT.PUT_LINE(
            ' Le fournisseur qui a pour code : ' || fourn || chr(10) ||
            ' et a pour nom ' || nom_fourn || ' a fourni ces articles : ' || chr(10)
    );
    FOR curs_fourn IN curs LOOP
        DBMS_OUTPUT.PUT_LINE(
            ' ==> L article numero : ' || curs_fourn.IDARTICLE || chr(10) ||
            ' dont le libelle est :' || curs_fourn.LIBELLEARTICLE || chr(10)
        );
    END LOOP;
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

ACCEPT fourn_id_input PROMPT 'Entrer l id de fournisseur : '
BEGIN
    afficher_fourn('&fourn_id_input');
END;
/


-- Question 4 :
SELECT * FROM COMMANDE;
SELECT * FROM VENDEUR;
CREATE OR REPLACE PROCEDURE achats_client(num_clt CLIENT.NUMCLIENT%TYPE) IS
    CURSOR curs IS 
    SELECT C.DATECOMMANDE , V.NOMVENDEUR
    FROM COMMANDE C JOIN VENDEUR V
    ON C.NUMVENDEUR = V.NUMVENDEUR
    WHERE C.NUMCLIENT = num_clt;
BEGIN

    FOR curs_ach IN curs LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Date de commande : ' || curs_ach.DATECOMMANDE || chr(10) ||
            'Nom Vendeur : ' || curs_ach.NOMVENDEUR || chr(10)
        );
    END LOOP;
    
    EXCEPTION 
        WHEN NO_DATA_FOUND THEN
             DBMS_OUTPUT.PUT_LINE(SQLERRM);
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/
EXECUTE achats_client('CL1001');


-- Question 5 :
CREATE OR REPLACE FUNCTION nombre_vente (num_vend VENDEUR.NUMVENDEUR%TYPE) 
RETURN NUMBER IS
    nombre NUMBER;
BEGIN
    SELECT COUNT(NUMVENDEUR) INTO nombre 
    FROM COMMANDE 
    WHERE NUMVENDEUR = num_vend GROUP BY NUMVENDEUR;
    RETURN nombre;
END;
/

DECLARE
    nombre NUMBER := nombre_vente('&num_vend_input');
BEGIN
    DBMS_OUTPUT.PUT_LINE(' Nombre de vente : ' || nombre);
END;
/


-- Question 6 :
-- NUM ARTICLE POUR TESTER : PR100
DECLARE
    CURSOR curs(num_article VENTE.IDARTICLE%TYPE) IS SELECT COUNT(IDARTICLE)
    FROM VENTE WHERE IDARTICLE = num_article;
    nombre NUMBER;
BEGIN
    OPEN curs('&num_art');
    LOOP FETCH curs INTO nombre;
        EXIT WHEN curs%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(chr(10) || 'Nombre de vente est : ' || to_char(nombre));
    END LOOP;
    
    EXCEPTION 
        WHEN NO_DATA_FOUND THEN
             DBMS_OUTPUT.PUT_LINE(SQLERRM);
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

