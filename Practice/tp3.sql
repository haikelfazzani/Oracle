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

EXECUTE MODIFIER_PRIX('PR100' ,15);
