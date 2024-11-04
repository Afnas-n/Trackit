import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackit/firebase_options.dart';
import 'package:trackit/controller/user_display_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:trackit/controller/budget_controller.dart';
import 'package:trackit/controller/signin_controller.dart';
import 'package:trackit/controller/toggle_controller.dart';
import 'package:trackit/controller/expence_controller.dart';
import 'package:trackit/controller/dropdown_controller.dart';
import 'package:trackit/controller/bottombar_controller.dart';
import 'package:trackit/controller/datepicker_controller.dart';
import 'package:trackit/controller/shared_preferences_controller.dart';
import 'package:trackit/view/signin_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ToggleController(),
        ),
        ChangeNotifierProvider(
          create: (_) => BottombarCntrl(),
        ),
        ChangeNotifierProvider(
          create: (_) => DropdownController(),
        ),
        ChangeNotifierProvider(
          create: (_) => DatepickerController(),
        ),
        ChangeNotifierProvider(
          create: (_) => ExpenseController(),
        ),
        ChangeNotifierProvider(
          create: (_) => BudgetController(),
        ),
        ChangeNotifierProvider(
          create: (_) => SignInController(),
        ),
        ChangeNotifierProvider(
          create: (_) => SharedPreferencesController(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home:SigninPage(),
      ),
    );
  }
}
