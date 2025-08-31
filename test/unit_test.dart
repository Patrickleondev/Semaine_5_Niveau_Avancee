import 'package:flutter_test/flutter_test.dart';
import 'package:activite_4_debogage/main.dart';

void main() {
  group('Tests unitaires pour la classe Etudiant', () {
    test('Création d\'un étudiant avec nom et moyenne', () {
      final etudiant = Etudiant(nom: 'Alice', moyenne: 17.25);
      
      expect(etudiant.nom, equals('Alice'));
      expect(etudiant.moyenne, equals(17.25));
    });

    test('Création d\'un étudiant avec moyenne décimale', () {
      final etudiant = Etudiant(nom: 'Bob', moyenne: 16.5);
      
      expect(etudiant.nom, equals('Bob'));
      expect(etudiant.moyenne, equals(16.5));
    });
  });

  group('Tests unitaires pour la fonction calculateMoyenne', () {
    test('Calcul de la moyenne avec une liste d\'étudiants', () {
      final etudiants = [
        Etudiant(nom: 'Alice', moyenne: 17.25),
        Etudiant(nom: 'Bob', moyenne: 16.5),
        Etudiant(nom: 'Charlie', moyenne: 11.75),
      ];
      
      final moyenne = calculateMoyenne(etudiants);
      final moyenneAttendue = (17.25 + 16.5 + 11.75) / 3;
      
      expect(moyenne, equals(moyenneAttendue));
    });

    test('Calcul de la moyenne avec un seul étudiant', () {
      final etudiants = [
        Etudiant(nom: 'Alice', moyenne: 17.25),
      ];
      
      final moyenne = calculateMoyenne(etudiants);
      
      expect(moyenne, equals(17.25));
    });

    test('Calcul de la moyenne avec une liste vide', () {
      final etudiants = <Etudiant>[];
      
      final moyenne = calculateMoyenne(etudiants);
      
      expect(moyenne.isNaN, isTrue);
    });

    test('Calcul de la moyenne avec des moyennes négatives', () {
      final etudiants = [
        Etudiant(nom: 'Alice', moyenne: -5.0),
        Etudiant(nom: 'Bob', moyenne: 10.0),
      ];
      
      final moyenne = calculateMoyenne(etudiants);
      
      expect(moyenne, equals(2.5));
    });
  });
}

// Fonction utilitaire pour les tests
double calculateMoyenne(List<Etudiant> etudiants) {
  if (etudiants.isEmpty) {
    return double.nan;
  }
  
  double total = 0.0;
  for (var etudiant in etudiants) {
    total += etudiant.moyenne;
  }
  return total / etudiants.length;
}
