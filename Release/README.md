# Dossier Release - APK de l'Application

## Description

Ce dossier contient les fichiers APK (Android Package Kit) de l'application Flutter "Activité 4 - Débogage".

## Contenu du Dossier

### APK Release
- `activite_4_debogage-release.apk` : Version release de l'application (optimisée pour la production)

### APK Debug (optionnel)
- `activite_4_debogage-debug.apk` : Version debug de l'application (pour les tests et le développement)

## Instructions d'Installation

### Sur un appareil Android :

1. **Activer l'installation depuis des sources inconnues :**
   - Aller dans Paramètres > Sécurité
   - Activer "Sources inconnues" ou "Installer des applications inconnues"

2. **Installer l'APK :**
   - Transférer le fichier APK sur votre appareil Android
   - Ouvrir le fichier APK avec le gestionnaire de fichiers
   - Suivre les instructions d'installation

### Sur un émulateur Android :

1. **Via ADB (Android Debug Bridge) :**
   ```bash
   adb install activite_4_debogage-release.apk
   ```

2. **Via l'interface graphique :**
   - Glisser-déposer le fichier APK dans l'émulateur
   - Suivre les instructions d'installation

## Génération des APK

### APK Release
```bash
flutter build apk --release
```

### APK Debug
```bash
flutter build apk --debug
```

## Informations sur l'Application

- **Nom :** Activité 4 - Débogage
- **Version :** 1.0.0
- **Description :** Application Flutter pour afficher une liste d'étudiants et calculer leurs moyennes
- **Fonctionnalités :**
  - Affichage de la liste des étudiants
  - Calcul de la moyenne de la classe
  - Navigation vers les pages de détails
  - Interface utilisateur responsive

## Tests de l'Application

Après installation, vous pouvez tester les fonctionnalités suivantes :

1. **Affichage de la liste :** Vérifier que tous les étudiants sont affichés
2. **Calcul de moyenne :** Appuyer sur "Calculer la moyenne de la classe"
3. **Navigation :** Appuyer sur un étudiant pour voir ses détails
4. **Interface :** Vérifier que l'interface s'adapte à différentes tailles d'écran

## Dépannage

### Problèmes d'installation :
- Vérifier que l'installation depuis des sources inconnues est activée
- S'assurer que l'APK n'est pas corrompu
- Vérifier la compatibilité avec la version Android

### Problèmes d'exécution :
- Redémarrer l'application
- Vérifier les permissions
- Consulter les logs de l'application

## Support

Pour toute question ou problème, consultez le README principal du projet ou contactez l'équipe de développement.
