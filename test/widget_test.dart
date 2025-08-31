import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:activite_4_debogage/main.dart';

void main() {
  group('Tests de widgets pour l\'application', () {
    testWidgets('Test de l\'affichage de la page d\'accueil', (WidgetTester tester) async {
      await tester.pumpWidget(MonApplication());

      // Vérifier que le titre de l'AppBar est présent
      expect(find.text('Liste des étudiants'), findsOneWidget);

      // Vérifier que le texte de description est présent
      expect(find.text('Liste des étudiants et de leurs moyennes :'), findsOneWidget);

      // Vérifier que tous les étudiants sont affichés
      expect(find.text('Nom: Alice'), findsOneWidget);
      expect(find.text('Nom: Bob'), findsOneWidget);
      expect(find.text('Nom: Charlie'), findsOneWidget);
      expect(find.text('Nom: David'), findsOneWidget);
      expect(find.text('Nom: Eve'), findsOneWidget);

      // Vérifier que les moyennes sont affichées
      expect(find.text('Moyenne : 17.25'), findsOneWidget);
      expect(find.text('Moyenne : 16.5'), findsOneWidget);
      expect(find.text('Moyenne : 11.75'), findsOneWidget);
      expect(find.text('Moyenne : 12.75'), findsOneWidget);
      expect(find.text('Moyenne : 13.5'), findsOneWidget);

      // Vérifier que le bouton de calcul de moyenne est présent
      expect(find.text('Calculer la moyenne de la classe'), findsOneWidget);
    });

    testWidgets('Test du bouton de calcul de moyenne', (WidgetTester tester) async {
      await tester.pumpWidget(MonApplication());

      // Appuyer sur le bouton de calcul de moyenne
      await tester.tap(find.text('Calculer la moyenne de la classe'));
      await tester.pumpAndSettle();

      // Vérifier que la boîte de dialogue s'affiche
      expect(find.text('Moyenne des étudiants'), findsOneWidget);
      expect(find.text('La moyenne des étudiants est : 14.35'), findsOneWidget);
      expect(find.text('OK'), findsOneWidget);
    });

    testWidgets('Test de fermeture de la boîte de dialogue', (WidgetTester tester) async {
      await tester.pumpWidget(MonApplication());

      // Appuyer sur le bouton de calcul de moyenne
      await tester.tap(find.text('Calculer la moyenne de la classe'));
      await tester.pumpAndSettle();

      // Vérifier que la boîte de dialogue est affichée
      expect(find.text('Moyenne des étudiants'), findsOneWidget);

      // Appuyer sur le bouton OK pour fermer la boîte de dialogue
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      // Vérifier que la boîte de dialogue a disparu
      expect(find.text('Moyenne des étudiants'), findsNothing);
    });

    testWidgets('Test de navigation vers la page de détails', (WidgetTester tester) async {
      await tester.pumpWidget(MonApplication());

      // Appuyer sur le premier étudiant (Alice)
      await tester.tap(find.text('Nom: Alice'));
      await tester.pumpAndSettle();

      // Vérifier que nous sommes sur la page de détails
      expect(find.text('Détails de l\'étudiant'), findsOneWidget);
      expect(find.text('Nom de l\'étudiant : Alice'), findsOneWidget);
      expect(find.text('Moyenne : 17.25'), findsOneWidget);
    });

    testWidgets('Test de navigation vers la page de détails pour Bob', (WidgetTester tester) async {
      await tester.pumpWidget(MonApplication());

      // Appuyer sur Bob
      await tester.tap(find.text('Nom: Bob'));
      await tester.pumpAndSettle();

      // Vérifier que nous sommes sur la page de détails
      expect(find.text('Détails de l\'étudiant'), findsOneWidget);
      expect(find.text('Nom de l\'étudiant : Bob'), findsOneWidget);
      expect(find.text('Moyenne : 16.5'), findsOneWidget);
    });

    testWidgets('Test de retour à la page d\'accueil', (WidgetTester tester) async {
      await tester.pumpWidget(MonApplication());

      // Naviguer vers la page de détails
      await tester.tap(find.text('Nom: Alice'));
      await tester.pumpAndSettle();

      // Vérifier que nous sommes sur la page de détails
      expect(find.text('Détails de l\'étudiant'), findsOneWidget);

      // Appuyer sur le bouton retour
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      // Vérifier que nous sommes revenus à la page d'accueil
      expect(find.text('Liste des étudiants'), findsOneWidget);
      expect(find.text('Nom: Alice'), findsOneWidget);
    });

    testWidgets('Test de l\'interface utilisateur complète', (WidgetTester tester) async {
      await tester.pumpWidget(MonApplication());

      // Vérifier la structure de l'interface
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byType(ListTile), findsNWidgets(5)); // 5 étudiants
    });
  });
}
