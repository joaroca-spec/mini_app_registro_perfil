import 'package:app_registro_perfil/screens/home_screen.dart';
import 'package:app_registro_perfil/screens/lista_usuarios_screen.dart';
import 'package:app_registro_perfil/screens/registro_screen.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const String pathHome = '/';
  static const String pathRegistro = '/registro';
  static const String pathUsuarios = '/usuarios';
}

final appRouter = GoRouter(
  initialLocation: AppRouter.pathHome,
  routes: [
    GoRoute(
      path: AppRouter.pathHome,
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRouter.pathRegistro,
      name: RegistroScreen.name,
      builder: (context, state) => const RegistroScreen(),
    ),
    GoRoute(
      path: AppRouter.pathUsuarios,
      name: ListaUsuariosScreen.name,
      builder: (context, state) => const ListaUsuariosScreen(),
    ),
  ],
);
