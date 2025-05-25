import 'package:flutter/material.dart';
import 'package:modelo_v2/shared/components/app_menu.dart';

class ShellLayout extends StatelessWidget {
  final Widget child;

  const ShellLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: const AppMenu(),
    );
  }
}