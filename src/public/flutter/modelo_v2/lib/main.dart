import 'package:flutter/material.dart';
import '/core/routes/app_router.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      title: 'Modelo v2',
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
