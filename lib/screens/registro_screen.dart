import 'package:flutter/material.dart';

class RegistroScreen extends StatelessWidget {
  const RegistroScreen({super.key});

  static const String name = 'registro';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro de perfil')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 8),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Cédula',
              hintText: 'Ingrese su cédula',
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Nombre',
              hintText: 'Ingrese su nombre',
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Email',
              hintText: 'ejemplo@correo.com',
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Teléfono',
              hintText: 'Ingrese su teléfono',
            ),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Fecha de nacimiento',
              hintText: 'DD/MM/AAAA',
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'URL imagen de perfil',
              hintText: 'https://...',
            ),
            keyboardType: TextInputType.url,
          ),
          const SizedBox(height: 32),
          FilledButton(onPressed: () {}, child: const Text('Guardar')),
        ],
      ),
    );
  }
}
