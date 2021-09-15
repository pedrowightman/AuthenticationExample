import 'package:f_authentication_template/domain/controllers/authentication_controller.dart';
import 'package:f_authentication_template/domain/use_case/authentication.dart';
import 'package:f_authentication_template/ui/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';

Future<Widget> createHomeScreen() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut<Authentication>(() => Authentication());
  Get.lazyPut<AuthenticationController>(() => AuthenticationController());
  return MyApp();
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Complete Authentication flow", (WidgetTester tester) async {
    Widget w = await createHomeScreen();
    await tester.pumpWidget(w);

    //verify that we are in login page
    expect(find.byKey(Key('loginScaffold')), findsOneWidget);

    expect(find.byKey(Key('loginEmail')), findsNWidgets(1));

    // go to sign in
    await tester.tap(find.byKey(Key('loginCreateUser')));

    await tester.pumpAndSettle();

    //verify that we are in signup page
    expect(find.byKey(Key('signUpScaffold')), findsOneWidget);

    await tester.enterText(find.byKey(Key('signUpEmail')), 'a@a.com');

    await tester.enterText(find.byKey(Key('signUpPassord')), '123456');

    await tester.tap(find.byKey(Key('signUpSubmit')));

    await tester.pumpAndSettle();

    //expect(find.text('User ok'), findsOneWidget);

    //verify that we are in login page
    expect(find.byKey(Key('loginScaffold')), findsOneWidget);
    //login
    await tester.enterText(find.byKey(Key('loginEmail')), 'a@a.com');

    await tester.enterText(find.byKey(Key('loginPassord')), '123456');

    await tester.tap(find.byKey(Key('loginSubmit')));

    await tester.pumpAndSettle();

    //verify that we are in content page
    expect(find.byKey(Key('contentScaffold')), findsOneWidget);

    // go to profile page
    await tester.tap(find.byIcon(Icons.verified_user));
    await tester.pumpAndSettle();

    // logout
    await tester.tap(find.byKey(Key('profileLogout')));
    await tester.pumpAndSettle();

    //verify that we are in login page
    expect(find.byKey(Key('loginScaffold')), findsOneWidget);
  });

  testWidgets("Authentication signup ok and login fail",
      (WidgetTester tester) async {
    Widget w = await createHomeScreen();
    await tester.pumpWidget(w);

    //verify that we are in login page
    expect(find.byKey(Key('loginScaffold')), findsOneWidget);

    expect(find.byKey(Key('loginEmail')), findsNWidgets(1));

    // go to sign in
    await tester.tap(find.byKey(Key('loginCreateUser')));

    await tester.pumpAndSettle();

    //verify that we are in signup page
    expect(find.byKey(Key('signUpScaffold')), findsOneWidget);

    await tester.enterText(find.byKey(Key('signUpEmail')), 'a@a.com');

    await tester.enterText(find.byKey(Key('signUpPassord')), '123456');

    await tester.tap(find.byKey(Key('signUpSubmit')));

    await tester.pumpAndSettle();

    //expect(find.text('User ok'), findsOneWidget);

    //verify that we are in login page
    expect(find.byKey(Key('loginScaffold')), findsOneWidget);
    //login
    await tester.enterText(find.byKey(Key('loginEmail')), 'b@b.com');

    await tester.enterText(find.byKey(Key('loginPassord')), '123456');

    await tester.tap(find.byKey(Key('loginSubmit')));

    await tester.pumpAndSettle();

    //verify that we are in login page
    expect(find.byKey(Key('loginScaffold')), findsOneWidget);
  });
}
