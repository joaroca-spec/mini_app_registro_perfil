import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:app_registro_perfil/domain/user_model.dart';
import 'package:app_registro_perfil/domain/user_service.dart';
import 'package:app_registro_perfil/screens/componentes/app_button.dart';
import 'package:app_registro_perfil/screens/componentes/app_user_card.dart';

class ListaUsuariosScreen extends StatefulWidget {
  const ListaUsuariosScreen({super.key});

  static const String name = 'lista-usuarios';

  @override
  State<ListaUsuariosScreen> createState() => _ListaUsuariosScreenState();
}

class _ListaUsuariosScreenState extends State<ListaUsuariosScreen> {
  List<UserModel> _usuarios = [];
  UserModel? _ultimo;
  bool _loading = true;
  bool _showUltimo = false;

  @override
  void initState() {
    super.initState();
    _cargar();
  }

  Future<void> _cargar() async {
    setState(() => _loading = true);
    final userService = UserService();
    final list = await userService.list();
    final ultimo = await userService.getUltimoRegistrado();
    if (!mounted) return;
    setState(() {
      _usuarios = list;
      _ultimo = ultimo;
      _loading = false; 
    });
  }

  void _toggleUltimo() {
    setState(() => _showUltimo = !_showUltimo);
  }

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
            top: 70,
            right: -50,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.primaryContainer.withValues(alpha: 0.4),
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4, top: 4),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_rounded),
                    onPressed: () => context.pop(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Usuarios',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Divider(
                        color: colorScheme.primary.withValues(alpha: 0.6),
                        thickness: 1,
                        endIndent: 0,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Lista de perfiles registrados y último ingresado.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: AppButton(
                    label: _showUltimo
                        ? 'Ocultar último'
                        : 'Ver último ingresado',
                    onPressed: _ultimo != null ? _toggleUltimo : null,
                    variant: AppButtonVariant.black,
                    icon: Icon(
                      _showUltimo
                          ? Icons.visibility_off_rounded
                          : Icons.person_pin_rounded,
                      size: 20,
                    ),
                  ),
                ),
                if (_showUltimo && _ultimo != null) ...[
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: AppUserCard(user: _ultimo!, highlight: true),
                  ),
                ],
                const SizedBox(height: 24),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(28),
                        topRight: Radius.circular(28),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 12,
                          offset: const Offset(0, -4),
                        ),
                      ],
                    ),
                    child: _loading
                        ? Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircularProgressIndicator(
                                  color: colorScheme.primary,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Cargando usuarios...',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : _showUltimo
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(32),
                              child: Text(
                                'Mostrando solo el último registrado.',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        : _usuarios.isEmpty
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(32),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.people_outline_rounded,
                                    size: 72,
                                    color: colorScheme.outline.withValues(
                                      alpha: 0.5,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    'No hay usuarios',
                                    style: theme.textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Registra el primero desde el inicio.',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: _cargar,
                            color: colorScheme.primary,
                            child: ListView.builder(
                              padding: const EdgeInsets.fromLTRB(
                                24,
                                24,
                                24,
                                32,
                              ),
                              itemCount: _usuarios.length,
                              itemBuilder: (context, index) {
                                final user = _usuarios[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: AppUserCard(user: user),
                                );
                              },
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
