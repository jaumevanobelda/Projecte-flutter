import 'package:entrega_1/ui/core/ui/boton.dart';
import 'package:entrega_1/ui/core/ui/texto.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key, this.onLogin, this.onRegistro});

  final VoidCallback? onLogin;
  final VoidCallback? onRegistro;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Form(
          child: Column(
            children: [
                Texto(texto: 'Login', tipo: TipoTexto.title),
                TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Correo electrónico',
                  ),
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Contraseña',
                  ),
                ),
                const SizedBox(height: 20),
                Boton(
                  texto: 'Iniciar sesión',
                  tipo: TipoBoton.principal,
                  onPressed: onLogin,
                ),
                const SizedBox(height: 12),
                Boton(
                  texto: 'Crear una cuenta',
                  tipo: TipoBoton.secundario,
                  onPressed: onRegistro,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
