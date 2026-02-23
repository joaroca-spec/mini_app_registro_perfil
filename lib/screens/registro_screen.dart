import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:app_registro_perfil/config/app_router.dart';
import 'package:app_registro_perfil/domain/user_model.dart';
import 'package:app_registro_perfil/domain/user_service.dart';
import 'package:app_registro_perfil/screens/componentes/app_button.dart';
import 'package:app_registro_perfil/screens/componentes/app_confirm_dialog.dart';
import 'package:app_registro_perfil/screens/componentes/app_input.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  static const String name = 'registro';

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cedulaController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _avatarUrlController = TextEditingController();

  @override
  void dispose() {
    _cedulaController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _avatarUrlController.dispose();
    super.dispose();
  }

  Future<void> _guardar() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final confirmado = await AppConfirmDialog.show(
      context,
      title: 'Guardar perfil',
      message: '¿Deseas guardar este perfil?',
      confirmLabel: 'Guardar',
      cancelLabel: 'Cancelar',
    );
    if (!confirmado || !mounted) return;
    final user = UserModel(
      cedula: _cedulaController.text.trim(),
      name: _nameController.text.trim(),
      email: _emailController.text.trim().isEmpty ? null : _emailController.text.trim(),
      phone: _phoneController.text.trim().isEmpty ? null : _phoneController.text.trim(),
      avatarUrl: _avatarUrlController.text.trim().isEmpty ? null : _avatarUrlController.text.trim(),
    );
    await UserService().add(user);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Perfil guardado correctamente'),
        behavior: SnackBarBehavior.floating,
      ),
    );
    _cedulaController.clear();
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _avatarUrlController.clear();
    _formKey.currentState?.reset();
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
            color: colorScheme.primary,
          ),
          SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 8),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_rounded),
                    color: Colors.white,
                    onPressed: () => context.pop(),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tu perfil',
                        style: theme.textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 36,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: 135,
                        height: 1,
                        child: Divider(
                          color: Colors.white.withValues(alpha: 0.8),
                          thickness: 1,
                          endIndent: 0, 
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Completa la información a continuación y forma parte de la comunidad en un solo paso.',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: Colors.white.withValues(alpha: 0.95),
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(28),
                        topRight: Radius.circular(28),
                      ),
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(30, 50, 30, 32),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            AppInput(
                              controller: _cedulaController,
                              label: 'Cédula',
                              hint: 'Ingrese su cédula',
                              validator: (v) {
                                if (v == null || v.trim().isEmpty) {
                                  return 'La cédula es obligatoria';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            AppInput(
                              controller: _nameController,
                              label: 'Nombre',
                              hint: 'Ingrese su nombre',
                              validator: (v) {
                                if (v == null || v.trim().isEmpty) {
                                  return 'El nombre es obligatorio';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            AppInput(
                              controller: _emailController,
                              label: 'Email',
                              hint: 'ejemplo@correo.com',
                              keyboardType: TextInputType.emailAddress,
                              validator: (v) {
                                if (v == null || v.trim().isEmpty) {
                                  return 'El email es obligatorio';
                                }
                                final emailRegex = RegExp(
                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                if (!emailRegex.hasMatch(v.trim())) {
                                  return 'Ingrese un email válido';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            AppInput(
                              controller: _phoneController,
                              label: 'Teléfono',
                              hint: 'Ingrese su teléfono',
                              keyboardType: TextInputType.phone,
                              validator: (v) {
                                if (v == null || v.trim().isEmpty) {
                                  return 'El teléfono es obligatorio';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            AppInput(
                              controller: _avatarUrlController,
                              label: 'URL imagen de perfil',
                              hint: 'https://...',
                              keyboardType: TextInputType.url,
                              validator: (v) {
                                if (v == null || v.trim().isEmpty) {
                                  return 'La URL de la imagen es obligatoria';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 28),
                            AppButton(
                              label: 'Guardar',
                              onPressed: _guardar,
                              variant: AppButtonVariant.black,
                            ),
                            const SizedBox(height: 16),
                            AppButton(
                              label: 'Ir a la lista',
                              onPressed: () => context.push(AppRouter.pathUsuarios),
                              variant: AppButtonVariant.white,
                            ),
                          ],
                        ),
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
