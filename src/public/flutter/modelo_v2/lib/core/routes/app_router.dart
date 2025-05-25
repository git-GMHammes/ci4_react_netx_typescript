import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modelo_v2/features/home/presentation/pages/home_page.dart';
import 'package:modelo_v2/features/profile/presentation/pages/profile_page.dart';
import 'package:modelo_v2/features/contato/presentation/pages/contato_page.dart';
import 'package:modelo_v2/shared/layouts/shell_layout.dart';

// Navegadores para estrutura de shell
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    // Shell route para aplicar o menu em todas as páginas necessárias
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return ShellLayout(child: child);
      },
      routes: [
        // Rota para a Home
        GoRoute(
          path: '/',
          builder: (context, state) => const HomePage(),
        ),
        // Rota para o Perfil
        GoRoute(
          path: '/profile',
          builder: (context, state) => ProfilePage(),
        ),
        // Rota para o Contato
        GoRoute(
          path: '/contato',
          builder: (context, state) => ContatoPage(),
        ),
        // Adicione outras rotas que precisam do menu aqui
      ],
    ),
    
    // Rotas que NÃO precisam do menu (como login, onboarding, etc.)
    // GoRoute(
    //   path: '/login',
    //   parentNavigatorKey: _rootNavigatorKey,
    //   builder: (context, state) => const LoginPage(),
    // ),
  ],
);