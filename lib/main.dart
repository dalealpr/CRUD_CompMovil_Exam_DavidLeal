import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_api_1/services/auth_service.dart';
import 'package:provider/provider.dart';
// Routes
import '../routes/app_routes.dart';
// Theme
import 'package:flutter_api_1/theme/my_theme.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthService())],
      child: MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Color.fromARGB(255, 240, 240, 240),
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Color.fromARGB(0, 238, 238, 238),
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'API realtimeDB App',
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      theme: MyTheme.myTheme,
    );
  }
}
