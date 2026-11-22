import 'package:flutter/material.dart';
import 'package:flutter_control/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Форма проверяет имя и благодарит за каждую отправку', (
    tester,
  ) async {
    await tester.pumpWidget(const MainApp());
    final input = find.byType(TextField);
    final submit = find.widgetWithText(ElevatedButton, 'Отправить');
    expect(find.textContaining('Отправлено!'), findsNothing);

    await tester.enterText(input, '   ');
    await tester.tap(submit);
    await tester.pump();
    expect(find.text('Введите имя'), findsOneWidget);
    expect(find.textContaining('Отправлено!'), findsNothing);

    for (final name in ['Алмаз', 'Анна']) {
      await tester.enterText(input, '  $name  ');
      await tester.pump();
      expect(find.text('Введите имя'), findsNothing);
      expect(find.textContaining('Отправлено!'), findsNothing);

      await tester.tap(submit);
      await tester.pump();
      expect(find.text('Отправлено! Спасибо, $name'), findsOneWidget);
      expect(tester.widget<TextField>(input).controller!.text, isEmpty);
      expect(find.text('Обратная связь'), findsOneWidget);
      expect(
        find.text('Введите ваше имя и нажмите кнопку отправки.'),
        findsOneWidget,
      );
    }
  });
}
