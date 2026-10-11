:- encoding(utf8).

% SYSTÈME EXPERT DE DIAGNOSTIC DE PANNES D'ORDINATEUR

:- dynamic symptome_actif/1.

% Réinitialiser tous les symptômes
reset_diagnostic :- retractall(symptome_actif(_)).

% Ajouter un symptôme
set_symptome(Symptome) :- assertz(symptome_actif(Symptome)).

% Vérifier si un symptôme est actif
a_symptome(Symptome) :- symptome_actif(Symptome).

% ===================================================================
% BASE DE CONNAISSANCES - RÈGLES DE DIAGNOSTIC
% ===================================================================

% 1. PROBLÈMES D'ALIMENTATION
panne(alimentation_defaillante) :-
    a_symptome(ordinateur_ne_demarre_pas),
    a_symptome(aucun_bruit_ventilateur),
    a_symptome(aucune_led_allumee).

panne(extinction_soudaine) :-
    a_symptome(ordinateur_eteint_brusquement),
    a_symptome(ordinateur_tres_chaud).

panne(bloc_alimentation_faible) :-
    a_symptome(ordinateur_ne_demarre_pas),
    a_symptome(aucune_led_allumee).

% 2. PROBLÈMES DE REFROIDISSEMENT
panne(surchauffe_processeur) :-
    a_symptome(ordinateur_tres_chaud),
    a_symptome(ralentissements_frequents),
    a_symptome(arrets_inopines).

panne(surchauffe_generale) :-
    a_symptome(ordinateur_tres_chaud),
    a_symptome(systeme_tres_lent).

panne(ventilateur_defectueux) :-
    a_symptome(bruit_ventilateur_anormal),
    a_symptome(ordinateur_tres_chaud).

panne(ventilateur_bruyant_defectueux) :-
    a_symptome(bruit_ventilateur_anormal).

panne(probleme_ventilation) :-
    a_symptome(surchauffe),
    a_symptome(bruit_ventilateur_anormal).

% 3. PROBLÈMES D'AFFICHAGE
panne(carte_graphique_defectueuse) :-
    a_symptome(ecran_noir_demarrage),
    a_symptome(ordinateur_demarre_sons),
    \+ a_symptome(cable_ecran_defectueux).

panne(probleme_affichage) :-
    a_symptome(ecran_noir_demarrage).

panne(ecran_defectueux) :-
    a_symptome(pixels_morts),
    a_symptome(couleurs_deformees).

% 4. PROBLÈMES DISQUE DUR/SSD
panne(disque_dur_defaillant) :-
    a_symptome(bruits_cliquetis),
    a_symptome(demarrage_lent).

panne(disque_dur_critique) :-
    a_symptome(bruits_cliquetis),
    a_symptome(fichiers_inaccessibles).

panne(disque_sature) :-
    a_symptome(demarrage_lent),
    a_symptome(systeme_tres_lent),
    a_symptome(espace_disque_faible).

panne(erreur_disque) :-
    a_symptome(ecran_bleu_mort),
    a_symptome(message_erreur_disque).

% 5. PROBLÈMES DE MÉMOIRE RAM
panne(ram_defectueuse) :-
    a_symptome(ecran_bleu_mort),
    a_symptome(blocages_frequents),
    a_symptome(programmes_plantent).

panne(ram_insuffisante) :-
    a_symptome(systeme_tres_lent),
    a_symptome(programmes_plantent),
    a_symptome(utilisation_ram_elevee).

panne(probleme_memoire) :-
    a_symptome(ecran_bleu_mort),
    a_symptome(blocages_frequents).

% 6. PROBLÈMES PÉRIPHÉRIQUES
panne(clavier_defectueux) :-
    a_symptome(clavier_ne_repond_pas),
    a_symptome(touches_bloquees).

panne(souris_defectueuse) :-
    a_symptome(souris_ne_repond_pas),
    a_symptome(curseur_saccade).

panne(peripherique_usb_probleme) :-
    a_symptome(peripheriques_non_detectes),
    a_symptome(ports_usb_inactifs).

% 7. PROBLÈMES CARTE MÈRE
panne(carte_mere_defectueuse) :-
    a_symptome(ordinateur_ne_demarre_pas),
    a_symptome(bips_demarrage_anormaux),
    a_symptome(ports_usb_inactifs).

panne(probleme_carte_mere) :-
    a_symptome(bips_demarrage_anormaux).

% 8. PROBLÈMES RÉSEAU
panne(carte_reseau_defectueuse) :-
    a_symptome(pas_de_connexion_internet),
    a_symptome(wifi_non_detecte),
    \+ a_symptome(probleme_routeur).

panne(probleme_wifi) :-
    a_symptome(wifi_non_detecte),
    a_symptome(autres_appareils_connectent).

panne(probleme_configuration_reseau) :-
    a_symptome(pas_de_connexion_internet),
    a_symptome(connecte_au_reseau).

panne(probleme_connexion_internet) :-
    a_symptome(pas_de_connexion_internet).

% 9. PROBLÈMES LOGICIELS
panne(infection_malware) :-
    a_symptome(systeme_tres_lent),
    a_symptome(fenetres_pub_intempestives),
    a_symptome(programmes_inconnus).

panne(logiciels_malveillants) :-
    a_symptome(fenetres_pub_intempestives),
    a_symptome(programmes_inconnus).

panne(trop_programmes_demarrage) :-
    a_symptome(demarrage_lent),
    a_symptome(systeme_tres_lent),
    a_symptome(nombreux_programmes_arriere_plan).

panne(systeme_lent) :-
    a_symptome(systeme_tres_lent),
    a_symptome(demarrage_lent).

panne(fichiers_systeme_corrompus) :-
    a_symptome(plantages_frequents),
    a_symptome(message_erreur_demarrage),
    a_symptome(ecran_bleu_mort).

% 10. PROBLÈMES SYSTÈME D'EXPLOITATION
panne(windows_corrompu) :-
    a_symptome(ecran_bleu_mort),
    a_symptome(windows_ne_demarre_pas),
    a_symptome(erreur_fichiers_systeme).

panne(systeme_exploitation_probleme) :-
    a_symptome(windows_ne_demarre_pas).

panne(echec_mise_a_jour) :-
    a_symptome(mise_a_jour_echoue),
    a_symptome(erreur_windows_update).

% 11. PROBLÈMES AUDIO
panne(pilotes_audio_corrompus) :-
    a_symptome(pas_de_son),
    a_symptome(peripherique_audio_non_detecte).

panne(carte_son_defectueuse) :-
    a_symptome(pas_de_son),
    a_symptome(son_deforme).

panne(probleme_audio) :-
    a_symptome(pas_de_son).

panne(microphone_defectueux) :-
    a_symptome(microphone_ne_fonctionne_pas).

% ===================================================================
% PANNES PARTIELLES - Détection avec symptômes individuels
% ===================================================================

% Alimentation
panne_partielle(probleme_alimentation) :-
    a_symptome(aucune_led_allumee).

panne_partielle(probleme_alimentation) :-
    a_symptome(ordinateur_ne_demarre_pas).

% Disque dur
panne_partielle(disque_suspect) :-
    a_symptome(bruits_cliquetis).

% Affichage
panne_partielle(probleme_carte_graphique) :-
    a_symptome(artefacts_visuels).

panne_partielle(probleme_ecran) :-
    a_symptome(pixels_morts).

% RAM
panne_partielle(probleme_ram) :-
    a_symptome(ecran_bleu_mort).

% Température
panne_partielle(probleme_temperature) :-
    a_symptome(ordinateur_tres_chaud).

panne_partielle(probleme_temperature) :-
    a_symptome(surchauffe).

% Réseau
panne_partielle(probleme_reseau) :-
    a_symptome(pas_de_connexion_internet).

panne_partielle(probleme_reseau) :-
    a_symptome(wifi_non_detecte).

% Audio
panne_partielle(probleme_son) :-
    a_symptome(pas_de_son).

% Performance
panne_partielle(probleme_performance) :-
    a_symptome(systeme_tres_lent).

panne_partielle(probleme_performance) :-
    a_symptome(demarrage_lent).

% ===================================================================
% SOLUTIONS POUR CHAQUE PANNE
% ===================================================================

solution(alimentation_defaillante, 
'PROBLÈME D\'ALIMENTATION ÉLECTRIQUE

  DIAGNOSTIC:
  Votre ordinateur ne reçoit pas d\'alimentation électrique.
  Les composants ne sont pas alimentés correctement.

  SOLUTIONS:
  1. Vérifiez que le câble d\'alimentation est bien branché
  2. Testez avec un autre câble d\'alimentation
  3. Vérifiez l\'interrupteur sur le bloc d\'alimentation (position ON)
  4. Testez la prise électrique avec un autre appareil
  5. Remplacez le bloc d\'alimentation si défectueux
  Niveau difficulté: Moyen - Peut nécessiter un technicien').

solution(bloc_alimentation_faible,
'BLOC D\'ALIMENTATION DÉFAILLANT

  DIAGNOSTIC:
  Le bloc d\'alimentation ne fournit pas assez de puissance.

   SOLUTIONS:
  1. Vérifiez toutes les connexions d\'alimentation
  2. Testez avec un autre bloc d\'alimentation
  3. Vérifiez la puissance requise par vos composants
  4. Remplacez par un bloc plus puissant si nécessaire
    Niveau difficulté: Moyen').

solution(extinction_soudaine,
'EXTINCTION SOUDAINE

   DIAGNOSTIC:
  L\'ordinateur s\'éteint brutalement, probablement dû à la surchauffe
  ou à un problème d\'alimentation.

   SOLUTIONS:
  1. Vérifiez la température interne (utilisez HWMonitor)
  2. Nettoyez les ventilateurs et grilles d\'aération
  3. Testez le bloc d\'alimentation
  4. Vérifiez les paramètres de gestion d\'énergie
  5. Remplacez la pâte thermique du processeur
   Niveau difficulté: Moyen').

solution(surchauffe_processeur,
'SURCHAUFFE DU PROCESSEUR - URGENT

  DIAGNOSTIC:
  Le processeur atteint des températures critiques (>85°C).
  Risque d\'endommagement permanent si non traité.

   SOLUTIONS:
  1. ÉTEIGNEZ immédiatement si température >90°C
  2. Nettoyez les ventilateurs et dissipateurs avec air comprimé
  3. Remplacez la pâte thermique du processeur
  4. Vérifiez que tous les ventilateurs fonctionnent
  5. Améliorez la ventilation du boîtier
  6. Envisagez un meilleur système de refroidissement
    Niveau difficulté: Moyen à difficile').

solution(surchauffe_generale,
'SURCHAUFFE GÉNÉRALE

   DIAGNOSTIC:
  L\'ordinateur chauffe excessivement.

   SOLUTIONS:
  1. Nettoyez tous les ventilateurs
  2. Vérifiez la circulation d\'air
  3. Remplacez la pâte thermique
  4. Ajoutez des ventilateurs si nécessaire
    Niveau difficulté: Facile à moyen').

solution(ventilateur_bruyant_defectueux,
'VENTILATEUR BRUYANT/DEFECTUEUX

DIAGNOSTIC:
  Les ventilateurs font un bruit anormal.
  Cela peut indiquer une usure ou un probleme mecanique.

SOLUTIONS:
  1. Nettoyez le ventilateur avec de l\'air comprime
  2. Huilez l\'axe du ventilateur si possible
  3. Verifiez les connexions electriques
  4. Remplacez le ventilateur defectueux
  5. Verifiez qu\'aucun cable ne touche les pales
Niveau difficulte: Facile').

solution(probleme_ventilation,
'PROBLEME DE VENTILATION

DIAGNOSTIC:
  Surchauffe associee a un bruit anormal des ventilateurs.

SOLUTIONS:
  1. Nettoyez IMMEDIATEMENT tous les ventilateurs
  2. Verifiez que tous les ventilateurs tournent
  3. Remplacez le ventilateur bruyant
  4. Nettoyez les grilles d\'aeration
  5. Ameliorez la circulation d\'air dans le boitier
Niveau difficulte: Facile a moyen').

solution(ventilateur_defectueux,
'VENTILATEUR DEFECTUEUX

DIAGNOSTIC:
  Un ou plusieurs ventilateurs ne fonctionnent pas correctement.

SOLUTIONS:
  1. Nettoyez le ventilateur avec de l\'air comprime
  2. Huilez l\'axe du ventilateur si possible
  3. Verifiez les connexions electriques
  4. Remplacez le ventilateur defectueux
Niveau difficulte: Facile').

solution(ventilateur_bruyant,
'VENTILATEUR BRUYANT

DIAGNOSTIC:
  Les ventilateurs font un bruit anormal (grincement, cliquetis).

SOLUTIONS:
  1. Nettoyez le ventilateur avec de l\'air comprime
  2. Verifiez qu\'aucun cable ne touche les pales
  3. Huilez le ventilateur si possible
  4. Remplacez le ventilateur s\'il est use
  5. Verifiez les fixations du ventilateur
Niveau difficulte: Facile').

solution(probleme_ventilation,
'PROBLEME DE VENTILATION ET SURCHAUFFE

DIAGNOSTIC:
  Surchauffe combinee avec bruit anormal des ventilateurs.
  Situation urgente pouvant endommager les composants.

SOLUTIONS:
  1. ETEIGNEZ l\'ordinateur si tres chaud
  2. Nettoyez TOUS les ventilateurs immediatement
  3. Verifiez que tous les ventilateurs tournent
  4. Remplacez le ventilateur bruyant/defectueux
  5. Nettoyez les grilles d\'aeration
  6. Ameliorez la circulation d\'air dans le boitier
  7. Remplacez la pate thermique du processeur
Niveau difficulte: Facile a moyen
URGENT: Ne pas ignorer ce probleme!').

solution(carte_graphique_defectueuse,
'CARTE GRAPHIQUE DÉFECTUEUSE

   DIAGNOSTIC:
  La carte graphique ne fonctionne pas correctement.
  L\'ordinateur démarre mais rien ne s\'affiche.

   SOLUTIONS:
  1. Réinstallez les pilotes graphiques en mode sans échec
  2. Nettoyez les contacts de la carte graphique
  3. Réinstallez la carte dans son slot
  4. Testez avec une autre carte graphique
  5. Vérifiez l\'alimentation de la carte (câbles PCIe)
    Niveau difficulté: Moyen').

solution(probleme_affichage,
'PROBLÈME D\'AFFICHAGE

   DIAGNOSTIC:
  L\'écran ne s\'allume pas au démarrage.

   SOLUTIONS:
  1. Vérifiez le câble vidéo (HDMI/DisplayPort/VGA)
  2. Testez avec un autre écran
  3. Vérifiez que l\'écran est allumé
  4. Testez un autre port vidéo
  5. Réinitialisez le BIOS (retirez la pile CMOS 30 secondes)
    Niveau difficulté: Facile').

solution(ecran_defectueux,
'ÉCRAN DÉFECTUEUX

   DIAGNOSTIC:
  L\'écran présente des défauts visuels (pixels morts, couleurs).

   SOLUTIONS:
  1. Testez l\'écran sur un autre ordinateur
  2. Vérifiez les paramètres d\'affichage
  3. Utilisez l\'outil de calibrage des couleurs
  4. Remplacez l\'écran si nécessaire
    Niveau difficulté: Facile').

solution(disque_dur_defaillant,
'DISQUE DUR DÉFAILLANT - URGENCE DONNÉES!

   DIAGNOSTIC:
  Le disque dur montre des signes de défaillance imminente.
  VOS DONNÉES SONT EN DANGER!

   SOLUTIONS URGENTES:
  1. SAUVEGARDEZ IMMÉDIATEMENT vos données importantes!
  2. Utilisez CrystalDiskInfo pour vérifier l\'état SMART
  3. Exécutez CHKDSK /F /R depuis l\'invite de commandes
  4. NE PAS continuer à utiliser si bruits persistent
  5. Remplacez le disque par un SSD dès que possible
  6. Clonez vos données sur le nouveau disque
    Niveau difficulté: Moyen - URGENT!').

solution(disque_dur_critique,
'DISQUE DUR EN ÉTAT CRITIQUE

   DIAGNOSTIC:
  Le disque dur est en panne ou proche de la panne.

   SOLUTIONS:
  1. SAUVEGARDEZ immédiatement vos données
  2. N\'utilisez plus l\'ordinateur
  3. Contactez un professionnel pour récupération de données
  4. Remplacez le disque dur
    Niveau difficulté: Difficile - CRITIQUE').

solution(disque_sature,
'DISQUE DUR SATURÉ

   DIAGNOSTIC:
  Votre disque dur est plein ou presque plein.
  Windows a besoin d\'au moins 15-20 Go libres pour fonctionner.

   SOLUTIONS:
  1. Exécutez le "Nettoyage de disque" Windows
  2. Supprimez les fichiers temporaires
  3. Désinstallez les programmes inutiles
  4. Videz la corbeille
  5. Déplacez fichiers volumineux sur disque externe
  6. Utilisez WinDirStat pour identifier les gros fichiers
    Niveau difficulté: Facile').

solution(erreur_disque,
'ERREUR CRITIQUE DU DISQUE

   DIAGNOSTIC:
  Le disque présente des erreurs graves.

   SOLUTIONS:
  1. Démarrez en mode sans échec
  2. Exécutez CHKDSK /F /R
  3. Utilisez SFC /scannow
  4. Sauvegardez et remplacez si erreurs persistent
    Niveau difficulté: Moyen').

solution(ram_defectueuse,
'MÉMOIRE RAM DÉFECTUEUSE

   DIAGNOSTIC:
  Une ou plusieurs barrettes de RAM sont défectueuses.
  Cause fréquente d\'écrans bleus et de plantages.

   SOLUTIONS:
  1. Testez la RAM avec MemTest86+ (minimum 4 passes)
  2. Retirez et réinsérez les barrettes de RAM
  3. Nettoyez les contacts dorés avec une gomme
  4. Testez chaque barrette individuellement
  5. Identifiez et remplacez la barrette défectueuse
    Niveau difficulté: Facile à moyen').

solution(ram_insuffisante,
'MÉMOIRE RAM INSUFFISANTE

   DIAGNOSTIC:
  Votre ordinateur manque de mémoire RAM.

   SOLUTIONS:
  1. Fermez les programmes inutiles
  2. Désactivez les programmes au démarrage
  3. Augmentez la mémoire virtuelle
  4. Ajoutez des barrettes de RAM (recommandé)
    Niveau difficulté: Facile').

solution(probleme_memoire,
'PROBLÈME DE MÉMOIRE

   DIAGNOSTIC:
  Problème lié à la mémoire RAM.

   SOLUTIONS:
  1. Testez la RAM avec MemTest86+
  2. Réinsérez les barrettes
  3. Testez avec une barrette à la fois
  4. Remplacez si défectueuse
  Niveau difficulté: Facile').

solution(clavier_defectueux,
'CLAVIER DÉFECTUEUX

   DIAGNOSTIC:
  Le clavier ne fonctionne pas correctement.

   SOLUTIONS:
  1. Nettoyez le clavier avec de l\'air comprimé
  2. Vérifiez la connexion USB/PS2
  3. Testez sur un autre ordinateur
  4. Réinstallez les pilotes du clavier
  5. Remplacez le clavier
    Niveau difficulté: Facile').

solution(souris_defectueuse,
'SOURIS DÉFECTUEUSE

   DIAGNOSTIC:
  La souris ne répond pas correctement.

   SOLUTIONS:
  1. Nettoyez le capteur optique
  2. Changez les piles (souris sans fil)
  3. Réinstallez les pilotes
  4. Testez sur un autre ordinateur
  5. Remplacez la souris
    Niveau difficulté: Facile').

solution(peripherique_usb_probleme,
'PROBLÈME PÉRIPHÉRIQUE USB

    DIAGNOSTIC:
  Les ports USB ne détectent pas les périphériques.

   SOLUTIONS:
  1. Testez tous les ports USB
  2. Mettez à jour les pilotes USB
  3. Désinstallez et réinstallez les contrôleurs USB
  4. Vérifiez les paramètres d\'alimentation USB
    Niveau difficulté: Facile').

solution(carte_mere_defectueuse,
'CARTE MÈRE DÉFECTUEUSE - PANNE GRAVE

   DIAGNOSTIC:
  La carte mère présente une défaillance matérielle.
  C\'est une panne sérieuse et coûteuse.

   SOLUTIONS:
  1. Identifiez le code des bips au démarrage
  2. Réinitialisez le BIOS (retirez pile CMOS 5 minutes)
  3. Vérifiez les condensateurs gonflés sur la carte
  4. Testez avec le minimum de composants
  5. Remplacez la carte mère (ou envisagez PC neuf)
    Niveau difficulté: Difficile - Professionnel recommandé').

solution(probleme_carte_mere,
'PROBLÈME DE CARTE MÈRE

   DIAGNOSTIC:
  Dysfonctionnement de la carte mère.

   SOLUTIONS:
  1. Vérifiez les bips au démarrage
  2. Réinitialisez le BIOS
  3. Vérifiez les composants un par un
  4. Consultez un technicien
    Niveau difficulté: Difficile').

solution(carte_reseau_defectueuse,
'CARTE RÉSEAU DÉFECTUEUSE

   DIAGNOSTIC:
  La carte réseau (WiFi ou Ethernet) est défectueuse.

   SOLUTIONS:
  1. Réinstallez les pilotes de la carte réseau
  2. Désactivez puis réactivez la carte réseau
  3. Vérifiez dans le gestionnaire de périphériques
  4. Utilisez une carte réseau USB externe (solution rapide)
  5. Remplacez la carte réseau interne
    Niveau difficulté: Moyen').

solution(probleme_wifi,
'PROBLÈME WIFI

   DIAGNOSTIC:
  L\'ordinateur ne détecte pas le réseau WiFi.

   SOLUTIONS:
  1. Activez/désactivez le mode avion
  2. Redémarrez le routeur
  3. Oubliez et reconnectez le réseau
  4. Mettez à jour les pilotes WiFi
  5. Réinitialisez les paramètres réseau
    Niveau difficulté: Facile').

solution(probleme_configuration_reseau,
'PROBLÈME DE CONFIGURATION RÉSEAU

   DIAGNOSTIC:
  Configuration réseau incorrecte.

   SOLUTIONS:
  1. Exécutez l\'utilitaire de résolution réseau Windows
  2. ipconfig /release puis ipconfig /renew
  3. ipconfig /flushdns
  4. Changez les DNS (8.8.8.8 et 8.8.4.4)
  5. Réinitialisez TCP/IP
    Niveau difficulté: Facile').

solution(probleme_connexion_internet,
'PROBLÈME DE CONNEXION INTERNET

   DIAGNOSTIC:
  Pas de connexion Internet.

   SOLUTIONS:
  1. Vérifiez le câble Ethernet
  2. Redémarrez le routeur/modem
  3. Vérifiez les paramètres réseau
  4. Testez avec un autre appareil
  5. Contactez votre FAI si nécessaire
    Niveau difficulté: Facile').

solution(infection_malware,
'INFECTION PAR MALWARE/VIRUS

   DIAGNOSTIC:
  Votre ordinateur est infecté par des logiciels malveillants.
  Cela affecte les performances et la sécurité.

   SOLUTIONS:
  1. Démarrez en mode sans échec
  2. Lancez Windows Defender en analyse complète
  3. Téléchargez et utilisez Malwarebytes (gratuit)
  4. Supprimez les programmes suspects (Panneau de config)
  5. Réinitialisez tous les navigateurs web
  6. Changez TOUS vos mots de passe importants
  7. Activez un antivirus 
    Niveau difficulté: Moyen').

solution(logiciels_malveillants,
'LOGICIELS MALVEILLANTS DÉTECTÉS

   DIAGNOSTIC:
  Programmes indésirables ou malveillants installés.

   SOLUTIONS:
  1. Mode sans échec
  2. Désinstallez les programmes suspects
  3. Scan antivirus complet
  4. Utilisez Malwarebytes
  5. Réinitialisez les navigateurs
    Niveau difficulté: Moyen').

solution(trop_programmes_demarrage,
'TROP DE PROGRAMMES AU DÉMARRAGE

   DIAGNOSTIC:
  De nombreux programmes se lancent au démarrage,
  ralentissant considérablement le système.

   SOLUTIONS:
  1. Ouvrez le Gestionnaire des tâches (Ctrl+Maj+Échap)
  2. Allez dans l\'onglet "Démarrage"
  3. Désactivez les programmes inutiles
  4. Gardez uniquement antivirus et programmes essentiels
  5. Redémarrez l\'ordinateur
  6. Désinstallez les logiciels vraiment inutilisés
    Niveau difficulté: Facile').

solution(systeme_lent,
'SYSTÈME LENT

   DIAGNOSTIC:
  L\'ordinateur fonctionne lentement.

   SOLUTIONS:
  1. Nettoyez les fichiers temporaires
  2. Désactivez programmes au démarrage
  3. Défragmentez le disque (HDD seulement)
  4. Ajoutez de la RAM si < 8 Go
  5. Passez à un SSD si HDD
    Niveau difficulté: Facile à moyen').

solution(fichiers_systeme_corrompus,
'FICHIERS SYSTÈME CORROMPUS

   DIAGNOSTIC:
  Les fichiers système Windows sont endommagés.

   SOLUTIONS:
  1. Exécutez: SFC /scannow (en administrateur)
  2. Exécutez: DISM /Online /Cleanup-Image /RestoreHealth
  3. Utilisez la réparation au démarrage
  4. Effectuez une restauration système
  5. Réinstallez Windows en dernier recours
    Niveau difficulté: Moyen').

solution(windows_corrompu,
'WINDOWS CORROMPU

   DIAGNOSTIC:
  Le système d\'exploitation Windows est gravement endommagé.

   SOLUTIONS:
  1. Créez une clé USB de récupération Windows
  2. Démarrez dessus et utilisez "Réparation automatique"
  3. Essayez la restauration système
  4. En dernier recours: Réinstallation complète de Windows
  5. SAUVEGARDEZ VOS DONNÉES AVANT!
    Niveau difficulté: Moyen à difficile').

solution(systeme_exploitation_probleme,
'PROBLÈME SYSTÈME D\'EXPLOITATION

   DIAGNOSTIC:
  Windows ne démarre pas correctement.

   SOLUTIONS:
  1. Utilisez la réparation au démarrage
  2. Mode sans échec
  3. Restauration système
  4. Réinstallation Windows si nécessaire
    Niveau difficulté: Moyen').

solution(echec_mise_a_jour,
'ÉCHEC DE MISE À JOUR WINDOWS

   DIAGNOSTIC:
  Les mises à jour Windows échouent.

   SOLUTIONS:
  1. Libérez de l\'espace disque (minimum 20 Go)
  2. Utilitaire de résolution Windows Update
  3. Téléchargez manuellement la mise à jour
  4. Réinitialisez Windows Update
  5. Désactivez temporairement l\'antivirus
     Niveau difficulté: Moyen').

solution(pilotes_audio_corrompus,
'PILOTES AUDIO CORROMPUS

   DIAGNOSTIC:
  Les pilotes de la carte son sont endommagés.

   SOLUTIONS:
  1. Gestionnaire de périphériques → Désinstallez pilotes audio
  2. Redémarrez (Windows réinstallera automatiquement)
  3. Téléchargez derniers pilotes sur site du fabricant
  4. Exécutez l\'utilitaire de résolution audio Windows
    Niveau difficulté: Facile').

solution(carte_son_defectueuse,
'CARTE SON DÉFECTUEUSE

   DIAGNOSTIC:
  La carte son matérielle est défectueuse.

   SOLUTIONS:
  1. Testez avec différents haut-parleurs/casques
  2. Vérifiez les connexions audio
  3. Réinstallez les pilotes
  4. Testez un autre port audio
  5. Utilisez une carte son USB externe
    Niveau difficulté: Facile').

solution(probleme_audio,
'PROBLÈME AUDIO

   DIAGNOSTIC:
  Pas de son sur l\'ordinateur.

   SOLUTIONS:
  1. Vérifiez le volume (non coupé)
  2. Vérifiez les connexions haut-parleurs
  3. Définissez le bon périphérique de lecture par défaut
  4. Réinstallez les pilotes audio
  5. Exécutez l\'utilitaire de résolution audio
    Niveau difficulté: Facile').

solution(microphone_defectueux,
'MICROPHONE DÉFECTUEUX

   DIAGNOSTIC:
  Le microphone ne fonctionne pas.

   SOLUTIONS:
  1. Vérifiez que le micro n\'est pas coupé (mute)
  2. Augmentez le volume du microphone dans les paramètres
  3. Définissez le microphone comme périphérique par défaut
  4. Testez avec un autre microphone
  5. Vérifiez les autorisations microphone dans Windows
    Niveau difficulté: Facile').

% ===================================================================
% FONCTION PRINCIPALE DE DIAGNOSTIC
% ===================================================================

% Trouver la meilleure panne correspondante
run_diagnostic(Panne, Solution) :-
    panne(Panne),
    !,  % Coupe pour prendre la première panne trouvée
    solution(Panne, Solution).

% Si aucune panne exacte, chercher une panne partielle
run_diagnostic(Panne, Solution) :-
    panne_partielle(Panne),
    !,
    solution(Panne, Solution).

% Si toujours rien, diagnostic inconclusif
run_diagnostic('aucune_panne_detectee', 
'DIAGNOSTIC INCONCLUSIF

Les symptômes fournis ne correspondent pas à une panne spécifique
dans la base de connaissances.

RECOMMANDATIONS:
  1. Notez tous les symptômes précis et messages d\'erreur
  2. Essayez de démarrer en mode sans échec (F8 au démarrage)
  3. Vérifiez les journaux d\'événements Windows:
     - Panneau de configuration → Outils d\'administration
     - Observateur d\'événements
  4. Consultez un technicien informatique professionnel

CONSEILS SUPPLÉMENTAIRES:
  • Sauvegardez vos données importantes
  • Prenez des photos des messages d\'erreur
  • Notez quand le problème est apparu
  • Listez les changements récents (installations, mises à jour)
  Un professionnel peut diagnostiquer des problèmes complexes').

% ===================================================================
% FONCTIONS UTILITAIRES
% ===================================================================

% Lister tous les symptômes actifs
liste_symptomes_actifs(Liste) :-
    findall(S, symptome_actif(S), Liste).

% Compter les symptômes actifs
compte_symptomes(Nombre) :-
    findall(S, symptome_actif(S), Liste),
    length(Liste, Nombre).

% Vérifier si au moins un symptôme est actif
a_des_symptomes :-
    symptome_actif(_), !.

% Lister toutes les pannes possibles avec les symptômes actuels
toutes_pannes_possibles(ListePannes) :-
    findall(P, panne(P), ListePannes).

