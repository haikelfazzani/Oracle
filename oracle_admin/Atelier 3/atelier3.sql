/*___________ Exercice 1 _____________*/
    -- 1 Afficher le nom et l��tat de l�instance en cours. 
    desc v$instance;
    select status from v$instance;
    
    -- 2 Afficher le nom de votre base, quel est son �tat ?
    select name from v$database;
    select database_status from v$instance;
    
    -- 3 Quels sont les diff�rents utilisateurs de l�instance en cours.
    select * from user_users;
    
    -- 4 D�crire les champs open_mode (v$database) et database_status(v$instance) .
    select open_mode from v$database;
    select database_status from v$instance;
    
    -- 5 Lister les noms des param�tres d�initialisation d�une instance oracle.
    show PARAMETERS;



/*___________ Exercice 2 _____________*/
    -- 1 Quelle est la valeur du param�tre d�initialisation spfile ?
    select * from v$spparameter;
    
    -- 2 Quelle est la valeur du param�tre d�initialisation pfile si elle existe?
    /* n'existe pas */
    
    -- 3 Que peut en conclure ?
    /* l'instance courante utilise par default les parameter du fichier SPFILE */
    
    -- 4 Cr�er un fichier de param�tres serveur pfile � partir du fichir spfile.
    create pfile from spfile;
    
    -- 5 Afficher � nouveau les informations relatives aux deux fichiers.
    select * from v$spparameter;



/*___________ Exercice 3 _____________*/

    -- 1 Quelle est la valeur du param�tre processes.
    show PARAMETER processes;
    
    -- 2 Modifier cette valeur � 50.
    alter system set processes = 50 scope = SPFILE;
    SHUTDOWN IMMEDIATE; -- fermer database
    STARTUP;


-- 3 La valeur du param�tre processes a-t-elle chang�e ?pourquoi ? qu�est ce qu�il faut faire pour que la modification soit permanente ?
/* les valeurs ne sont pas chang�e parceque on a sp�cifier le scope = SPFILE donc les parameter modofiable seront chang�
    dans le prochain demarrage
    on doit chang� le scope = BOTH pour que les modification seront effectu�es
*/

    -- 4 Afficher les diff�rents NLS (Nationnal Langage Support) parametres de votre base (utiliser la vue NLS_SESSION_PARAMETERS ou NLS_DATABASE_PARAMETERS)
    select * from NLS_SESSION_PARAMETERS;
    
    -- 5 Modifier le param�tre 'NLS_DATE_FORMAT'
    show PARAMETERS NLS_DATE_FORMAT;
    ALTER SESSION set NLS_DATE_FORMAT='yy.mm.dd';
    
    -- 6 V�rifier la modification
    show PARAMETERS NLS_DATE_FORMAT;
    
    
    
    