import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppMenu extends StatelessWidget {
  const AppMenu({super.key});

  static const List<NavigationItem> _items = [
    NavigationItem(route: '/', icon: Icons.home, label: 'Home'),
    NavigationItem(route: '/profile', icon: Icons.person, label: 'Profile'),
    NavigationItem(route: '/contato', icon: Icons.account_circle, label: 'Contato'),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _getSelectedIndex(context),
      onTap: (index) => context.go(_items[index].route),
      type: BottomNavigationBarType.fixed, // Para mais de 3 itens testar com .shifting
      items:
          _items
              .map(
                (item) => BottomNavigationBarItem(
                  icon: Icon(item.icon),
                  label: item.label,
                ),
              )
              .toList(),
    );
  }

  int _getSelectedIndex(BuildContext context) {
    final state = GoRouterState.of(context);
    final location = state.uri.path; // Usa apenas o path, ignora query params

    // Para rota raiz, comparação exata
    if (location == '/') {
      return 0;
    }

    // Para outras rotas, verifica se começa com a rota base
    for (int i = 1; i < _items.length; i++) {
      if (location.startsWith(_items[i].route)) {
        return i;
      }
    }

    return 0; // Default para Home
  }
}

class NavigationItem {
  final String route;
  final IconData icon;
  final String label;

  const NavigationItem({
    required this.route,
    required this.icon,
    required this.label,
  });
}
