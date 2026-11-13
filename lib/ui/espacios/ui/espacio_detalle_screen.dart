import 'package:entrega_1/domain/models/comentario.dart';
import 'package:entrega_1/domain/models/disponibilidad_dia.dart';
import 'package:entrega_1/domain/models/espacio.dart';
import 'package:entrega_1/domain/models/franja_disponibilidad.dart';
import 'package:entrega_1/domain/models/usuario.dart';
import 'package:entrega_1/ui/core/ui/boton.dart';
import 'package:entrega_1/ui/core/ui/boton_volver.dart';
import 'package:entrega_1/ui/core/ui/texto.dart';
import 'package:flutter/material.dart';

class EspacioDetalleScreen extends StatefulWidget {
  const EspacioDetalleScreen({
    super.key,
    required this.espacio,
    this.comentarios = const [],
    this.disponibilidad,
    this.onReservar,
  });

  final Espacio espacio;
  final List<Comentario> comentarios;
  final List<DisponibilidadDia>? disponibilidad;
  final VoidCallback? onReservar;

  @override
  State<EspacioDetalleScreen> createState() => _EspacioDetalleScreenState();
}

class _EspacioDetalleScreenState extends State<EspacioDetalleScreen> {
  late final PageController _galeriaController;
  late final List<Comentario> _comentarios;
  var _paginaGaleria = 0;

  @override
  void initState() {
    super.initState();
    _galeriaController = PageController();
    _comentarios = List<Comentario>.from(widget.comentarios);
  }

  @override
  void dispose() {
    _galeriaController.dispose();
    super.dispose();
  }

  List<String> get _imagenes {
    if (widget.espacio.imagenesAssets.isNotEmpty) {
      return widget.espacio.imagenesAssets;
    }
    return [widget.espacio.imagenAsset];
  }

  List<DisponibilidadDia> get _disponibilidad {
    if (widget.disponibilidad != null && widget.disponibilidad!.length >= 7) {
      return widget.disponibilidad!.take(7).toList();
    }

    final hoy = DateTime.now();
    return List<DisponibilidadDia>.generate(7, (indice) {
      final fecha = DateTime(hoy.year, hoy.month, hoy.day + indice);
      return DisponibilidadDia(
        espacioId: widget.espacio.id,
        fecha: fecha,
        franjas: [
          FranjaDisponibilidad(
            inicio: DateTime(fecha.year, fecha.month, fecha.day, 9),
            fin: DateTime(fecha.year, fecha.month, fecha.day, 13),
            disponible: indice.isEven,
          ),
          FranjaDisponibilidad(
            inicio: DateTime(fecha.year, fecha.month, fecha.day, 16),
            fin: DateTime(fecha.year, fecha.month, fecha.day, 20),
            disponible: indice % 3 != 0,
          ),
        ],
      );
    });
  }

  Future<void> _anadirOpinion() async {
    final textoController = TextEditingController();
    var puntuacion = 5;
    final texto = await showDialog<String>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Texto(
            texto: 'Añadir opinión de prueba',
            tipo: TipoTexto.subtitle,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: textoController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Comentario',
                  hintText: 'Comparte tu experiencia',
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<int>(
                initialValue: puntuacion,
                decoration: const InputDecoration(labelText: 'Puntuación'),
                items: List.generate(
                  5,
                  (indice) => DropdownMenuItem(
                    value: indice + 1,
                    child: Texto(texto: '${indice + 1} / 5'),
                  ),
                ),
                onChanged: (valor) {
                  if (valor != null) {
                    setDialogState(() => puntuacion = valor);
                  }
                },
              ),
            ],
          ),
          actions: [
            Boton(
              onPressed: () => Navigator.pop(context),
              texto: 'Cancelar',
              tipo: TipoBoton.secundario,
            ),
            Boton(
              onPressed: () => Navigator.pop(context, textoController.text),
              texto: 'Añadir',
            ),
          ],
        ),
      ),
    );

    if (!mounted || texto == null || texto.trim().isEmpty) return;
    setState(() {
      _comentarios.add(
        Comentario(
          id: 'demo-${DateTime.now().microsecondsSinceEpoch}',
          espacioId: widget.espacio.id,
          autor: const Usuario(
            id: 'demo',
            nombre: 'Usuario demo',
            correo: 'demo@example.com',
          ),
          puntuacion: puntuacion,
          texto: texto.trim(),
          fecha: DateTime.now(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final espacio = widget.espacio;
    final media = espacio.mediaValoraciones(_comentarios);
    final precio = (espacio.precioHoraCentimos / 100).toStringAsFixed(2);

    return Scaffold(
      appBar: AppBar(
        leading: const BotonVolver(),
        title: Texto(texto: espacio.nombre, tipo: TipoTexto.subtitle),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          _Galeria(
            imagenes: _imagenes,
            controller: _galeriaController,
            paginaActual: _paginaGaleria,
            onPaginaCambiada: (pagina) {
              setState(() => _paginaGaleria = pagina);
            },
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Texto(
                  texto: espacio.nombre,
                  tipo: TipoTexto.title,
                  estilo: Theme.of(context).textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                _IconoTexto(
                  icono: Icons.location_on_outlined,
                  texto: espacio.ubicacion,
                ),
                _IconoTexto(
                  icono: Icons.groups_outlined,
                  texto: 'Aforo máximo: ${espacio.aforo} personas',
                ),
                const SizedBox(height: 16),
                Texto(texto: espacio.descripcion),
                const SizedBox(height: 20),
                _Seccion(
                  titulo: 'Actividades admitidas',
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: espacio.actividades
                        .map(
                          (actividad) => Chip(label: Texto(texto: actividad)),
                        )
                        .toList(),
                  ),
                ),
                _Seccion(
                  titulo: 'Equipamiento y servicios',
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      ...espacio.equipamiento.map(
                        (elemento) => _ElementoIcono(
                          icono: Icons.check_circle_outline,
                          texto: elemento,
                        ),
                      ),
                      ...espacio.serviciosDisponibles.map(
                        (servicio) => _ElementoIcono(
                          icono: Icons.add_circle_outline,
                          texto: servicio.nombre,
                        ),
                      ),
                    ],
                  ),
                ),
                _Seccion(
                  titulo: 'Precio y contacto',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Texto(
                        texto: '$precio ${espacio.moneda} / hora',
                        tipo: TipoTexto.subtitle,
                        estilo: Theme.of(context).textTheme.titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      _IconoTexto(
                        icono: Icons.person_outline,
                        texto: espacio.contacto.nombre,
                      ),
                      _IconoTexto(
                        icono: Icons.phone_outlined,
                        texto: espacio.contacto.telefono,
                      ),
                      _IconoTexto(
                        icono: Icons.email_outlined,
                        texto: espacio.contacto.correo,
                      ),
                    ],
                  ),
                ),
                _Seccion(
                  titulo: 'Horario y condiciones',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _IconoTexto(
                        icono: Icons.schedule_outlined,
                        texto: espacio.horario,
                      ),
                      const SizedBox(height: 8),
                      Texto(texto: espacio.condicionesUso),
                      const SizedBox(height: 8),
                      Texto(
                        texto: 'Web: ${espacio.sitioWeb ?? 'Sin sitio web'}',
                      ),
                    ],
                  ),
                ),
                _Seccion(
                  titulo: 'Disponibilidad simulada',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _disponibilidad
                        .map((dia) => _DisponibilidadDia(dia: dia))
                        .toList(),
                  ),
                ),
                _Seccion(
                  titulo: 'Opiniones',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (media == null)
                        const Texto(texto: 'Sin valoraciones')
                      else
                        Texto(
                          texto:
                              '${media.toStringAsFixed(1)} / 5 · '
                              '${_comentarios.length} valoraciones',
                          tipo: TipoTexto.subtitle,
                        ),
                      const SizedBox(height: 12),
                      ..._comentarios.map((comentario) {
                        return _Opinion(comentario: comentario);
                      }),
                      Boton(
                        onPressed: _anadirOpinion,
                        texto: 'Añadir opinión de prueba',
                        tipo: TipoBoton.secundario,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: Boton(onPressed: widget.onReservar, texto: 'Reservar'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Galeria extends StatelessWidget {
  const _Galeria({
    required this.imagenes,
    required this.controller,
    required this.paginaActual,
    required this.onPaginaCambiada,
  });

  final List<String> imagenes;
  final PageController controller;
  final int paginaActual;
  final ValueChanged<int> onPaginaCambiada;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 240,
          child: PageView.builder(
            controller: controller,
            itemCount: imagenes.length,
            onPageChanged: onPaginaCambiada,
            itemBuilder: (context, index) => Image.asset(
              imagenes[index],
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => ColoredBox(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Icon(
                  Icons.image_outlined,
                  size: 64,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            imagenes.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: index == paginaActual ? 22 : 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                color: index == paginaActual
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Seccion extends StatelessWidget {
  const _Seccion({required this.titulo, required this.child});

  final String titulo;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Texto(
            texto: titulo,
            tipo: TipoTexto.subtitle,
            estilo: Theme.of(context).textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

class _IconoTexto extends StatelessWidget {
  const _IconoTexto({required this.icono, required this.texto});

  final IconData icono;
  final String texto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icono, size: 20, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 8),
          Expanded(child: Texto(texto: texto)),
        ],
      ),
    );
  }
}

class _ElementoIcono extends StatelessWidget {
  const _ElementoIcono({required this.icono, required this.texto});

  final IconData icono;
  final String texto;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 145,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icono, size: 20, color: Theme.of(context).colorScheme.secondary),
          const SizedBox(width: 6),
          Expanded(child: Texto(texto: texto)),
        ],
      ),
    );
  }
}

class _DisponibilidadDia extends StatelessWidget {
  const _DisponibilidadDia({required this.dia});

  final DisponibilidadDia dia;

  @override
  Widget build(BuildContext context) {
    final fecha =
        '${dia.fecha.day.toString().padLeft(2, '0')}/'
        '${dia.fecha.month.toString().padLeft(2, '0')}';
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 52, child: Texto(texto: fecha)),
          Expanded(
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: dia.franjas
                  .map(
                    (franja) => Chip(
                      avatar: Icon(
                        franja.disponible
                            ? Icons.check_circle_outline
                            : Icons.block_outlined,
                        size: 18,
                      ),
                      label: Texto(
                        texto:
                            '${_hora(franja.inicio)}–${_hora(franja.fin)} '
                            '${franja.disponible ? 'Libre' : 'Ocupada'}',
                      ),
                      backgroundColor: franja.disponible
                          ? Colors.green.shade100
                          : Colors.red.shade100,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  static String _hora(DateTime fecha) {
    return '${fecha.hour.toString().padLeft(2, '0')}:'
        '${fecha.minute.toString().padLeft(2, '0')}';
  }
}

class _Opinion extends StatelessWidget {
  const _Opinion({required this.comentario});

  final Comentario comentario;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Texto(
              texto: comentario.autor.nombre,
              estilo: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Texto(
              texto:
                  '${'★' * comentario.puntuacion} · ${_fecha(comentario.fecha)}',
            ),
            const SizedBox(height: 6),
            Texto(texto: comentario.texto),
          ],
        ),
      ),
    );
  }

  static String _fecha(DateTime fecha) {
    return '${fecha.day.toString().padLeft(2, '0')}/'
        '${fecha.month.toString().padLeft(2, '0')}/'
        '${fecha.year}';
  }
}
