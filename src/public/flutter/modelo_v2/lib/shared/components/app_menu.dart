import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppMenu extends StatelessWidget {
  const AppMenu({super.key});

  static const List<NavigationItem> _items = [
    NavigationItem(route: '/', icon: Icons.lock, label: 'Login'),
    NavigationItem(route: '/contato/salvar', icon: Icons.save, label: 'Salvar'),
    NavigationItem(
      route: '/auth/instructions',
      icon: Icons.info,
      label: 'Instruções',
    ),
    NavigationItem(route: '/auth/acceptance', icon: Icons.check, label: 'Termo'),
    NavigationItem(route: '/profile', icon: Icons.person, label: 'Profile'),
    NavigationItem(route: '/home', icon: Icons.home, label: 'Home'),
    NavigationItem(
      route: '/contato',
      icon: Icons.account_circle,
      label: 'Contato',
    ),
    NavigationItem(
      route: '/geolocationmap',
      icon: Icons.map,
      label: 'Geolocalização',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _getSelectedIndex(context);
    // Tamanho de cada item calculado para caber 5 no máximo na tela
    final double itemWidth = MediaQuery.of(context).size.width / 5;

    return SafeArea(
      top: false,
      child: Container(
        color:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor ??
            Colors.white,
        padding: const EdgeInsets.only(bottom: 8, top: 8),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(_items.length, (index) {
              final item = _items[index];
              final selected = selectedIndex == index;
              return SizedBox(
                width: itemWidth,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => context.go(item.route),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        item.icon,
                        color:
                            selected
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey,
                      ),
                      Text(
                        item.label,
                        style: TextStyle(
                          color:
                              selected
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.grey,
                          fontWeight:
                              selected ? FontWeight.bold : FontWeight.normal,
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  int _getSelectedIndex(BuildContext context) {
    final state = GoRouterState.of(context);
    final location = state.uri.path;
    if (location == '/') return 0;
    for (int i = 1; i < _items.length; i++) {
      if (location.startsWith(_items[i].route)) return i;
    }
    return 0;
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
