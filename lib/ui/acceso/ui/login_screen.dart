import 'package:entrega_1/ui/core/ui/texto.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Form(
        child: Column(
          children: [
            Texto(texto:"Login",tipo: TipoTexto.title),
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Nombre de usuario',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Contraseña',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
