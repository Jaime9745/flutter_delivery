import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_delivery/main.dart';

void main() {
  testWidgets('App starts on the login page', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const MyApp());
    await tester.pump();

    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Ingresar'), findsOneWidget);
    expect(find.text('Registrate'), findsOneWidget);
  });
}
