import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:activite_4_debogage/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Tests d\'intégration pour l\'application', () {
    testWidgets('Test du flux complet de l\'application', (WidgetTester tester) async {
      // Démarrer l'application
      await tester.pumpWidget(MonApplication());
      await tester.pumpAndSettle();

      // Étape 1: Vérifier que la page d'accueil s'affiche correctement
      expect(find.text('Liste des étudiants'), findsOneWidget);
      expect(find.text('Liste des étudiants et de leurs moyennes :'), findsOneWidget);

      // Étape 2: Vérifier que tous les étudiants sont présents
      final etudiants = ['Alice', 'Bob', 'Charlie', 'David', 'Eve'];
      for (final nom in etudiants) {
        expect(find.text('Nom: $nom'), findsOneWidget);
      }

      // Étape 3: Tester la navigation vers la page de détails
      await tester.tap(find.text('Nom: Alice'));
      await tester.pumpAndSettle();

      // Vérifier que la page de détails s'affiche
      expect(find.text('Détails de l\'étudiant'), findsOneWidget);
      expect(find.text('Nom de l\'étudiant : Alice'), findsOneWidget);
      expect(find.text('Moyenne : 17.25'), findsOneWidget);

      // Étape 4: Retourner à la page d'accueil
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      // Vérifier que nous sommes revenus à la page d'accueil
      expect(find.text('Liste des étudiants'), findsOneWidget);

      // Étape 5: Tester le calcul de la moyenne
      await tester.tap(find.text('Calculer la moyenne de la classe'));
      await tester.pumpAndSettle();

      // Vérifier que la boîte de dialogue s'affiche avec la bonne moyenne
      expect(find.text('Moyenne des étudiants'), findsOneWidget);
      expect(find.text('La moyenne des étudiants est : 14.35'), findsOneWidget);

      // Étape 6: Fermer la boîte de dialogue
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      // Vérifier que la boîte de dialogue a disparu
      expect(find.text('Moyenne des étudiants'), findsNothing);
    });

    testWidgets('Test de navigation multiple entre les pages', (WidgetTester tester) async {
      await tester.pumpWidget(MonApplication());
      await tester.pumpAndSettle();

      // Naviguer vers les détails de Bob
      await tester.tap(find.text('Nom: Bob'));
      await tester.pumpAndSettle();
      expect(find.text('Nom de l\'étudiant : Bob'), findsOneWidget);

      // Retourner à la page d'accueil
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      // Naviguer vers les détails de Charlie
      await tester.tap(find.text('Nom: Charlie'));
      await tester.pumpAndSettle();
      expect(find.text('Nom de l\'étudiant : Charlie'), findsOneWidget);

      // Retourner à la page d'accueil
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      // Vérifier que nous sommes bien sur la page d'accueil
      expect(find.text('Liste des étudiants'), findsOneWidget);
    });

    testWidgets('Test de l\'interaction avec la liste d\'étudiants', (WidgetTester tester) async {
      await tester.pumpWidget(MonApplication());
      await tester.pumpAndSettle();

      // Tester le scroll de la liste
      await tester.drag(find.byType(ListView), const Offset(0, -300));
      await tester.pumpAndSettle();

      // Vérifier que tous les étudiants sont toujours visibles après le scroll
      expect(find.text('Nom: Alice'), findsOneWidget);
      expect(find.text('Nom: Eve'), findsOneWidget);

      // Tester la navigation vers le dernier étudiant
      await tester.tap(find.text('Nom: Eve'));
      await tester.pumpAndSettle();
      expect(find.text('Nom de l\'étudiant : Eve'), findsOneWidget);
    });

    testWidgets('Test de la persistance des données', (WidgetTester tester) async {
      await tester.pumpWidget(MonApplication());
      await tester.pumpAndSettle();

      // Calculer la moyenne une première fois
      await tester.tap(find.text('Calculer la moyenne de la classe'));
      await tester.pumpAndSettle();
      expect(find.text('La moyenne des étudiants est : 14.35'), findsOneWidget);
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      // Naviguer vers une page de détails
      await tester.tap(find.text('Nom: David'));
      await tester.pumpAndSettle();
      expect(find.text('Nom de l\'étudiant : David'), findsOneWidget);

      // Retourner et recalculer la moyenne
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Calculer la moyenne de la classe'));
      await tester.pumpAndSettle();
      expect(find.text('La moyenne des étudiants est : 14.35'), findsOneWidget);
    });

    testWidgets('Test de l\'interface utilisateur responsive', (WidgetTester tester) async {
      // Tester avec une taille d'écran différente
      await tester.binding.setSurfaceSize(const Size(400, 800));
      await tester.pumpWidget(MonApplication());
      await tester.pumpAndSettle();

      // Vérifier que l'interface s'adapte
      expect(find.text('Liste des étudiants'), findsOneWidget);
      expect(find.text('Calculer la moyenne de la classe'), findsOneWidget);

      // Tester la navigation
      await tester.tap(find.text('Nom: Alice'));
      await tester.pumpAndSettle();
      expect(find.text('Détails de l\'étudiant'), findsOneWidget);

      // Restaurer la taille d'écran par défaut
      await tester.binding.setSurfaceSize(null);
    });
  });
}
