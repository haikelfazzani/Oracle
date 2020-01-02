/*___________ Exercice 1 _____________*/
    -- 1 Afficher le nom et l’état de l’instance en cours. 
    desc v$instance;
    select status from v$instance;
    
    -- 2 Afficher le nom de votre base, quel est son état ?
    select name from v$database;
    select database_status from v$instance;
    
    -- 3 Quels sont les différents utilisateurs de l’instance en cours.
    select * from user_users;
    
    -- 4 Décrire les champs open_mode (v$database) et database_status(v$instance) .
    select open_mode from v$database;
    select database_status from v$instance;
    
    -- 5 Lister les noms des paramètres d’initialisation d’une instance oracle.
    show PARAMETERS;



/*___________ Exercice 2 _____________*/
    -- 1 Quelle est la valeur du paramètre d’initialisation spfile ?
    select * from v$spparameter;
    
    -- 2 Quelle est la valeur du paramètre d’initialisation pfile si elle existe?
    /* n'existe pas */
    
    -- 3 Que peut en conclure ?
    /* l'instance courante utilise par default les parameter du fichier SPFILE */
    
    -- 4 Créer un fichier de paramètres serveur pfile à partir du fichir spfile.
    create pfile from spfile;
    
    -- 5 Afficher à nouveau les informations relatives aux deux fichiers.
    select * from v$spparameter;



/*___________ Exercice 3 _____________*/

    -- 1 Quelle est la valeur du paramètre processes.
    show PARAMETER processes;
    
    -- 2 Modifier cette valeur à 50.
    alter system set processes = 50 scope = SPFILE;
    SHUTDOWN IMMEDIATE; -- fermer database
    STARTUP;


-- 3 La valeur du paramètre processes a-t-elle changée ?pourquoi ? qu’est ce qu’il faut faire pour que la modification soit permanente ?
/* les valeurs ne sont pas changée parceque on a spécifier le scope = SPFILE donc les parameter modofiable seront changé
    dans le prochain demarrage
    on doit changé le scope = BOTH pour que les modification seront effectuées
*/

    -- 4 Afficher les différents NLS (Nationnal Langage Support) parametres de votre base (utiliser la vue NLS_SESSION_PARAMETERS ou NLS_DATABASE_PARAMETERS)
    select * from NLS_SESSION_PARAMETERS;
    
    -- 5 Modifier le paramètre 'NLS_DATE_FORMAT'
    show PARAMETERS NLS_DATE_FORMAT;
    ALTER SESSION set NLS_DATE_FORMAT='yy.mm.dd';
    
    -- 6 Vérifier la modification
    show PARAMETERS NLS_DATE_FORMAT;
    
    
    
    