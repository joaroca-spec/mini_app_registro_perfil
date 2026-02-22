import 'package:app_registro_perfil/config/app_router.dart';
import 'package:app_registro_perfil/screens/componentes/app_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String name = 'home';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: colorScheme.surface,
          ),
          Positioned(
            top: 80,
            right: -40,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.primaryContainer.withValues(alpha: 0.5),
              ),
            ),
          ),
          Positioned(
            bottom: 200,
            left: -30,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.primaryContainer.withValues(alpha: 0.4),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 48),
                Icon(
                  Icons.person_4_rounded,
                  size: 175,
                  color: colorScheme.primary,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 200,
                  child: Divider(color: colorScheme.primary, thickness: 1),
                ),
                const SizedBox(height: 10),
                Text(
                  'COMUNI-APP',
                  style: theme.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: colorScheme.primary,
                    letterSpacing: 2.5,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Conectando personas',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                    letterSpacing: .9,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 100),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(28),
                        topRight: Radius.circular(28),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bienvenido',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 45,
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: 225,
                            child: Divider(color: Colors.white70, thickness: 2),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Registra tu perfil para formar parte de la comunidad o consulta la lista de usuarios registrados y descubre nuevos contactos.',
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: Colors.white,
                              height: 1.45,
                              fontSize: 16,
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Expanded(
                                child: AppButton(
                                  label: 'Registrarse',
                                  onPressed: () =>
                                      context.push(AppRouter.pathRegistro),
                                  variant: AppButtonVariant.black,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: AppButton(
                                  label: 'Ver usuarios',
                                  onPressed: () =>
                                      context.push(AppRouter.pathUsuarios),
                                  variant: AppButtonVariant.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
