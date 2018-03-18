SET VERIFY OFF
SET SERVEROUTPUT ON
-- Question 1 :
SELECT * FROM ARTICLE;
DECLARE
    rec article%rowtype;
BEGIN
    SELECT * INTO rec FROM ARTICLE WHERE IDARTICLE = 'PR100';
    DBMS_OUTPUT.PUT_LINE('Resultat est = ' || chr(10) ||
        ' -- ' || rec.IDARTICLE || chr(10) ||
        ' -- ' || rec.LIBELLEARTICLE || chr(10) ||
        ' -- ' || rec.QTESEUIL || chr(10) ||
        ' -- ' || rec.QTESTOCK || chr(10) ||
        ' -- ' || rec.NUMFOURNISSEUR
    );
END;
/
-- Question 2 :
DECLARE
    REC COMMANDE%ROWTYPE;
BEGIN
    SELECT * INTO REC FROM COMMANDE WHERE NUMCOMMANDE = 'CMD001';
    DBMS_OUTPUT.PUT_LINE(
        chr(10) || 
        ' -- La commande dont le numero est : ' || REC.NUMCOMMANDE || chr(10) ||
        ' -- Date Commande le : ' || REC.DATECOMMANDE || chr(10) ||
        ' -- Date Livraison le : ' || REC.DATELIVRAISON || chr(10) ||
        ' -- Etat de la commande : ' || REC.ETATCOMMANDE);
END;
/

-- Question 3 :
SELECT * FROM VENDEUR;
DECLARE
    REC VENDEUR%ROWTYPE;
BEGIN
    SELECT * INTO REC FROM VENDEUR 
    WHERE COMMISSION = (SELECT MAX(COMMISSION) FROM VENDEUR );
    DBMS_OUTPUT.PUT_LINE(chr(10) ||
        ' -- Numero Vendeur : ' || REC.NUMVENDEUR || chr(10) ||
        ' -- Nom Vendeur : ' || REC.NOMVENDEUR || chr(10) ||
        ' -- Prenom Vendeur : ' || REC.PRENOMVENDEUR || chr(10) ||
        ' -- Telephone Vendeur : ' || REC.TELEVENDEUR || chr(10) ||
        ' -- Commision : ' || REC.COMMISSION
    );
END;
/

-- Question 4 :
SELECT * FROM COMMANDE;
DECLARE
    comm COMMANDE%ROWTYPE;
BEGIN
    SELECT * INTO COMM FROM
    (SELECT * FROM COMMANDE ORDER BY NUMCOMMANDE DESC)
    WHERE ROWNUM = 1;
    DBMS_OUTPUT.PUT_LINE(chr(10) ||
        comm.NUMCOMMANDE || chr(10) ||
        comm.DATECOMMANDE || chr(10) ||
        comm.DATELIVRAISON || chr(10) ||
        comm.ETATCOMMANDE || chr(10) ||
        comm.NUMCLIENT || chr(10) ||
        comm.NUMVENDEUR
    );
END;
/
-- Question 5 :
SELECT * FROM ARTICLE;
DECLARE
    TYPE PRODUIT IS RECORD (
        id_artile ARTICLE.IDARTICLE%TYPE,
        libelle_article ARTICLE.LIBELLEARTICLE%TYPE,
        prix_unitaire ARTICLE.PRIXUNITAIRE%TYPE,
        qte_seuil ARTICLE.QTESEUIL%TYPE,
        qte_stock ARTICLE.QTESTOCK%TYPE,
        num_fourniss ARTICLE.NUMFOURNISSEUR%TYPE
    );
    prod PRODUIT;
BEGIN
    prod.id_artile := 'PR116';
    prod.libelle_article := 'SMART';
    prod.prix_unitaire := 35;
    prod.qte_seuil := 30;
    prod.qte_stock := 1300;
    prod.num_fourniss := 'F105';
    INSERT INTO ARTICLE VALUES PROD;
END;
/
-- Question 6 :
DELETE FROM ARTICLE WHERE IDARTICLE = 'PR200';
SELECT * FROM ARTICLE;
DECLARE
    TYPE art IS RECORD (
        id_artile ARTICLE.IDARTICLE%TYPE,
        libelle_article ARTICLE.LIBELLEARTICLE%TYPE,
        prix_unitaire ARTICLE.PRIXUNITAIRE%TYPE,
        qte_seuil ARTICLE.QTESEUIL%TYPE,
        qte_stock ARTICLE.QTESTOCK%TYPE,
        num_fourniss ARTICLE.NUMFOURNISSEUR%TYPE
    );
    a art;
BEGIN
    a.id_artile := 'PR200';
    a.libelle_article := 'DETERGENTS MURS';
    a.prix_unitaire := 78.50;
    a.qte_seuil := 50;
    a.qte_stock := 200;
    a.num_fourniss := 'F103';
    INSERT INTO ARTICLE VALUES a;
    if sql%FOUND then
        DBMS_OUTPUT.PUT_LINE(' -- Ligne ajoutee ' || to_char(SQL%ROWCOUNT));
        DBMS_OUTPUT.PUT_LINE(
            ' -- ' || a.id_artile || chr(10) ||
            ' -- ' || a.libelle_article || chr(10) ||
            ' -- ' || a.prix_unitaire || chr(10) ||
            ' -- ' || a.qte_seuil || chr(10) ||
            ' -- ' || a.qte_stock || chr(10) ||
            ' -- ' || a.num_fourniss
        );
    else 
        DBMS_OUTPUT.PUT_LINE('Erreur d insertion');
    END IF;
END;
/

DECLARE
    TYPE art IS RECORD (
        id_artile ARTICLE.IDARTICLE%TYPE,
        libelle_article ARTICLE.LIBELLEARTICLE%TYPE,
        prix_unitaire ARTICLE.PRIXUNITAIRE%TYPE,
        qte_seuil ARTICLE.QTESEUIL%TYPE,
        qte_stock ARTICLE.QTESTOCK%TYPE,
        num_fourniss ARTICLE.NUMFOURNISSEUR%TYPE
    );
    a art;
BEGIN
    a.id_artile := '&user_input';
    a.libelle_article := '&user_input';
    a.prix_unitaire := &user_input;
    a.qte_seuil := &user_input;
    a.qte_stock := &user_input;
    a.num_fourniss := '&user_input';
    INSERT INTO ARTICLE VALUES a;
    if sql%FOUND then
        DBMS_OUTPUT.PUT_LINE(' -- > Ligne ajoutee ' || to_char(SQL%ROWCOUNT));
        DBMS_OUTPUT.PUT_LINE(
            ' -- ' || a.id_artile || chr(10) ||
            ' -- ' || a.libelle_article || chr(10) ||
            ' -- ' || a.prix_unitaire || chr(10) ||
            ' -- ' || a.qte_seuil || chr(10) ||
            ' -- ' || a.qte_stock || chr(10) ||
            ' -- ' || a.num_fourniss
        );
    else 
        DBMS_OUTPUT.PUT_LINE('Erreur d insertion');
    END IF;
END;
/
-- Question 7 :
SELECT * FROM ARTICLE;
DECLARE 
    rec ARTICLE%ROWTYPE;
BEGIN
    UPDATE ARTICLE SET PRIXUNITAIRE = &prix_input WHERE IDARTICLE = '&id_input';
    SELECT * INTO rec FROM ARTICLE WHERE IDARTICLE = '&id_input';
    if sql%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Ligne modifier ' || chr(10) ||
            ' -- ' || rec.IDARTICLE || chr(10) ||
            ' -- ' || rec.LIBELLEARTICLE || chr(10) ||
            ' -- ' || rec.PRIXUNITAIRE || chr(10) ||
            ' -- ' || rec.QTESEUIL || chr(10) ||
            ' -- ' || rec.QTESTOCK || chr(10) ||
            ' -- ' || rec.NUMFOURNISSEUR
        );
    END IF;
END;
/
-- Question 8 :
SELECT * FROM VENDEUR;
ACCEPT user_inout PROMPT 'ENTRER UNE NOUVELLE VALEUR : '
CREATE OR REPLACE PROCEDURE MODIFICATION IS
BEGIN
    UPDATE VENDEUR SET COMMISSION = &user_input WHERE NUMVENDEUR = 'VE1';
    if sql%FOUND then
        DBMS_OUTPUT.PUT_LINE('Ligne a ete modifier ' || to_char(SQL%ROWCOUNT));
    END IF;
END;
/
EXECUTE MODIFICATION;
-- Question 9 :
SELECT * FROM FOURNISSEUR;
BEGIN
    DELETE FROM FOURNISSEUR WHERE NUMFOURNISSEUR = '&id_input';
    if sql%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Suppression effectue ' || sql%rowcount);
    else
        DBMS_OUTPUT.PUT_LINE('Fournisseur n existe pas');
    END IF;
END;
/
