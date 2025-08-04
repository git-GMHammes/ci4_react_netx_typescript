import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modelo_v2/features/auth/presentation/pages/auth_page.dart';
import 'package:modelo_v2/features/auth/presentation/pages/auth_instructions_page.dart';
import 'package:modelo_v2/features/auth/presentation/pages/auth_acceptance.dart';
import 'package:modelo_v2/features/geolocationmap/presentation/pages/geolocationmap_page.dart';
import 'package:modelo_v2/features/home/presentation/pages/home_page.dart';
import 'package:modelo_v2/features/profile/presentation/pages/profile_page.dart';
import 'package:modelo_v2/features/Contact/presentation/pages/contactList_page.dart';
import 'package:modelo_v2/features/Contact/presentation/pages/form_page.dart';
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
        GoRoute(path: '/', builder: (context, state) => const AuthPage()),
        GoRoute(
          path: '/auth/instructions',
          builder:
              (context, state) => AuthInstructionsPage(
                cadastro:
                    state.extra as Map<String, dynamic>?, // <-- aqui dá erro
              ),
        ),
        GoRoute(
          path: '/auth/acceptance',
          builder: (context, state) => const AuthAcceptancePage(),
        ),
        GoRoute(path: '/home', builder: (context, state) => const HomePage()),
        GoRoute(path: '/profile', builder: (context, state) => ProfilePage()),
        GoRoute(path: '/contato', builder: (context, state) => ContatoPage()),
        GoRoute(
          path: '/contato/salvar',
          builder: (context, state) => FormPage(),
        ),
        GoRoute(
          path: '/geolocationmap',
          builder: (context, state) => GeolocationMapPage(),
        ),
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
