import 'package:flutter/material.dart';
import '/provider/userProvider.dart';
import '/routes.dart';
import '/screens/auth/services/auth_services.dart';
import '/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'constants/appColors.dart';
import 'package:month_year_picker/month_year_picker.dart';

void main() {
  runApp(   
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        MonthYearPickerLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.backgroundColor,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.secondaryColor),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.backgroundColor,
          foregroundColor: Colors.black87,
        ),
      ),
      home: const MyHomePage(),
      onGenerateRoute: (settings) => generateRoute(settings),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AuthService authService = AuthService();
  @override
  void initState() {
    if (mounted) {
      Future.delayed(const Duration(seconds: 3), () {
        authService.getUserData(context);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
