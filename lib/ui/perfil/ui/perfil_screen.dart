import 'package:entrega_1/domain/models/usuario.dart';
import 'package:entrega_1/ui/acceso/ui/login_screen.dart';
import 'package:entrega_1/ui/core/ui/boton.dart';
import 'package:entrega_1/ui/core/ui/opcion_ajustes.dart';
import 'package:entrega_1/ui/core/ui/texto.dart';
import 'package:entrega_1/ui/espacios/ui/espacios_screen.dart';
import 'package:entrega_1/ui/reservas/ui/mis_reservas_screen.dart';
import 'package:flutter/material.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({
    super.key,
    this.usuario = const Usuario(
      id: 'u1',
      nombre: 'Alex Lopez',
      correo: 'alex@example.com',
    ),
    this.onCerrarSesion,
  });

  final Usuario usuario;
  final VoidCallback? onCerrarSesion;

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  var _notificacionesActivas = true;

  void _cerrarSesion() {
    if (widget.onCerrarSesion != null) {
      widget.onCerrarSesion!();
      return;
    }

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  void _abrirEspacios() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const EspaciosScreen()));
  }

  void _abrirReservas() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const MisReservasScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final iniciales = widget.usuario.nombre
        .split(' ')
        .where((parte) => parte.isNotEmpty)
        .take(2)
        .map((parte) => parte[0].toUpperCase())
        .join();

    return Scaffold(
      appBar: AppBar(
        title: const Texto(texto: 'Perfil y ajustes', tipo: TipoTexto.subtitle),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
        children: [
          CircleAvatar(
            radius: 42,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Texto(
              texto: iniciales,
              estilo: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Center(
            child: Texto(
              texto: widget.usuario.nombre,
              tipo: TipoTexto.subtitle,
            ),
          ),
          const SizedBox(height: 4),
          Center(
            child: Texto(
              texto: widget.usuario.correo,
              tipo: TipoTexto.secondary,
            ),
          ),
          const SizedBox(height: 28),
          const _TituloSeccion(texto: 'Navegación'),
          OpcionAjustes(
            icono: Icons.meeting_room_outlined,
            titulo: 'Espacios',
            descripcion: 'Explora los espacios disponibles',
            onTap: _abrirEspacios,
          ),
          OpcionAjustes(
            icono: Icons.event_note_outlined,
            titulo: 'Mis reservas',
            descripcion: 'Consulta tus solicitudes y estados',
            onTap: _abrirReservas,
          ),
          const SizedBox(height: 20),
          const _TituloSeccion(texto: 'Preferencias'),
          OpcionAjustes(
            icono: Icons.notifications_outlined,
            titulo: 'Notificaciones',
            descripcion: _notificacionesActivas
                ? 'Avisos activados como ejemplo'
                : 'Avisos desactivados como ejemplo',
            trailing: Switch(
              value: _notificacionesActivas,
              onChanged: (valor) {
                setState(() => _notificacionesActivas = valor);
              },
            ),
          ),
          const OpcionAjustes(
            icono: Icons.language_outlined,
            titulo: 'Idioma',
            descripcion: 'Español · Valor de ejemplo',
            trailing: Icon(Icons.lock_outline),
          ),
          const SizedBox(height: 20),
          const _TituloSeccion(texto: 'Sobre la aplicación'),
          const OpcionAjustes(
            icono: Icons.info_outline,
            titulo: 'Reservas',
            descripcion: 'Versión 1.0.0 · Mockup visual navegable',
            trailing: Icon(Icons.check_circle_outline),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: Boton(
              texto: 'Cerrar sesión',
              tipo: TipoBoton.secundario,
              onPressed: _cerrarSesion,
            ),
          ),
        ],
      ),
    );
  }
}

class _TituloSeccion extends StatelessWidget {
  const _TituloSeccion({required this.texto});

  final String texto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Texto(texto: texto, tipo: TipoTexto.subtitle),
    );
  }
}