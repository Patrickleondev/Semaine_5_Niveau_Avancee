# Activité 4 - Débogage et Test d'une Application Flutter

## Description du Projet

Cette activité vise à vous familiariser avec les outils de débogage de Flutter et à pratiquer la détection et la correction d'erreurs dans le code. L'application affiche une liste d'étudiants avec leurs moyennes et permet de calculer la moyenne de la classe.

## Structure du Projet

```
activite_4_debogage/
├── lib/
│   ├── main.dart                    # Code corrigé
│   └── main_avec_erreurs.dart       # Code original avec erreurs
├── test/
│   ├── unit_test.dart               # Tests unitaires
│   ├── widget_test.dart             # Tests de widgets
│   └── integration_test.dart        # Tests d'intégration
├── Release/
│   └── README.md                    # Documentation des APK
├── pubspec.yaml                     # Dépendances du projet
└── README.md                        # Ce fichier
```

## Erreurs Identifiées et Corrections

### 1. Erreur dans la Structure du Widget (Lignes 43-45)

**Problème :** Utilisation incorrecte des propriétés `mainAxisAlignment` et `crossAxisAlignment` dans un widget `Padding`.

**Code avec erreur :**
```dart
body: Padding(
  padding: EdgeInsets.all(16.0),
  mainAxisAlignment: MainAxisAlignment.start,  // ERREUR
  crossAxisAlignment: CrossAxisAlignment.stretch,  // ERREUR
  children: <Widget>[
    // ...
  ],
),
```

**Solution :** Remplacer `Padding` par `Column` ou envelopper le contenu dans un `Column`.

**Code corrigé :**
```dart
body: Padding(
  padding: EdgeInsets.all(16.0),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      // ...
    ],
  ),
),
```

### 2. Erreur dans la Fonction calculateMoyenne (Lignes 95-98)

**Problème :** Variable `total` redéclarée et conversion incorrecte de `double` vers `int`.

**Code avec erreur :**
```dart
double calculateMoyenne(List<Etudiant> etudiants) {
  double total = 0.0;
  for (var etudiant in etudiants) {
    var total = 0;  // ERREUR: Variable redéclarée
    total += etudiant.moyenne as int;  // ERREUR: Conversion incorrecte
  }
  return total / etudiants.length;
}
```

**Solution :** Supprimer la redéclaration et utiliser directement la variable `total` de type `double`.

**Code corrigé :**
```dart
double calculateMoyenne(List<Etudiant> etudiants) {
  double total = 0.0;
  for (var etudiant in etudiants) {
    total += etudiant.moyenne;  // Utilisation directe de la variable double
  }
  return total / etudiants.length;
}
```

### 3. Amélioration de l'Affichage de la Moyenne

**Problème :** La moyenne affichée peut avoir trop de décimales.

**Solution :** Utiliser `toStringAsFixed(2)` pour limiter à 2 décimales.

**Code amélioré :**
```dart
content: Text('La moyenne des étudiants est : ${average.toStringAsFixed(2)}'),
```

## Outils de Débogage Utilisés

### 1. Points d'Arrêt (Breakpoints)

**Utilisation :**
- Placer des points d'arrêt dans VS Code en cliquant sur la marge gauche
- Points d'arrêt recommandés :
  - Ligne 95 : Avant la boucle de calcul
  - Ligne 97 : Dans la boucle pour inspecter les valeurs
  - Ligne 99 : Après le calcul pour vérifier le résultat

### 2. Inspecteur de Variables

**Utilisation :**
- Dans le mode débogage, examiner les valeurs des variables
- Variables importantes à surveiller :
  - `etudiants` : Liste des étudiants
  - `total` : Accumulateur dans la fonction de calcul
  - `etudiant.moyenne` : Moyenne de chaque étudiant

### 3. Messages de Console (print)

**Exemple d'utilisation :**
```dart
double calculateMoyenne(List<Etudiant> etudiants) {
  double total = 0.0;
  print('Début du calcul de la moyenne');
  for (var etudiant in etudiants) {
    print('Étudiant: ${etudiant.nom}, Moyenne: ${etudiant.moyenne}');
    total += etudiant.moyenne;
    print('Total actuel: $total');
  }
  final resultat = total / etudiants.length;
  print('Moyenne finale: $resultat');
  return resultat;
}
```

## Tests Implémentés

### 1. Tests Unitaires (`test/unit_test.dart`)

**Objectif :** Tester les fonctions individuelles et la classe `Etudiant`.

**Tests inclus :**
- Création d'étudiants avec différents types de moyennes
- Calcul de moyenne avec différentes listes d'étudiants
- Gestion des cas limites (liste vide, moyennes négatives)

**Exécution :**
```bash
flutter test test/unit_test.dart
```

### 2. Tests de Widgets (`test/widget_test.dart`)

**Objectif :** Tester l'interface utilisateur et les interactions.

**Tests inclus :**
- Affichage correct de tous les éléments de l'interface
- Fonctionnement du bouton de calcul de moyenne
- Navigation vers les pages de détails
- Fermeture des boîtes de dialogue

**Exécution :**
```bash
flutter test test/widget_test.dart
```

### 3. Tests d'Intégration (`test/integration_test.dart`)

**Objectif :** Tester le flux complet de l'application.

**Tests inclus :**
- Parcours complet de l'application
- Navigation multiple entre les pages
- Interaction avec la liste d'étudiants
- Persistance des données
- Responsivité de l'interface

**Exécution :**
```bash
flutter test test/integration_test.dart
```

## Instructions d'Exécution

### 1. Installation des Dépendances

```bash
cd activite_4_debogage
flutter pub get
```

### 2. Exécution de l'Application

```bash
flutter run
```

### 3. Génération des APK

**APK Release (recommandé pour la production) :**
```bash
flutter build apk --release
```

**APK Debug (pour les tests) :**
```bash
flutter build apk --debug
```

**Emplacement des APK générés :**
- APK Release : `build/app/outputs/flutter-apk/app-release.apk`
- APK Debug : `build/app/outputs/flutter-apk/app-debug.apk`

**Copier les APK dans le dossier Release :**
```bash
# Créer le dossier Release s'il n'existe pas
mkdir -p Release

# Copier l'APK release
cp build/app/outputs/flutter-apk/app-release.apk Release/activite_4_debogage-release.apk

# Copier l'APK debug (optionnel)
cp build/app/outputs/flutter-apk/app-debug.apk Release/activite_4_debogage-debug.apk
```

### 3. Exécution des Tests

**Tous les tests :**
```bash
flutter test
```

**Tests spécifiques :**
```bash
flutter test test/unit_test.dart
flutter test test/widget_test.dart
flutter test test/integration_test.dart
```

### 4. Mode Débogage

1. Ouvrir le projet dans VS Code
2. Placer des points d'arrêt aux endroits critiques
3. Appuyer sur F5 ou utiliser "Run and Debug"
4. Utiliser l'inspecteur de variables pour examiner les valeurs

## Résultats Attendus

### Interface Utilisateur
- Liste des 5 étudiants avec leurs moyennes
- Bouton "Calculer la moyenne de la classe"
- Navigation vers les pages de détails
- Boîte de dialogue affichant la moyenne (14.35)

### Fonctionnalités
- Affichage correct de tous les étudiants
- Calcul précis de la moyenne de la classe
- Navigation fluide entre les pages
- Interface responsive


