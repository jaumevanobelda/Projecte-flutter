import 'package:entrega_1/domain/models/espacio.dart';
import 'package:entrega_1/domain/models/servicio_extra.dart';
import 'package:entrega_1/ui/core/ui/boton.dart';
import 'package:entrega_1/ui/core/ui/boton_volver.dart';
import 'package:entrega_1/ui/core/ui/texto.dart';
import 'package:flutter/material.dart';

class NuevaReservaScreen extends StatefulWidget {
  const NuevaReservaScreen({
    super.key,
    required this.espacio,
    this.onConfirmada,
  });

  final Espacio espacio;
  final VoidCallback? onConfirmada;

  @override
  State<NuevaReservaScreen> createState() => _NuevaReservaScreenState();
}

class _NuevaReservaScreenState extends State<NuevaReservaScreen> {
  late String _actividad;
  late DateTime _fecha;
  late TimeOfDay _inicio;
  late TimeOfDay _fin;
  var _asistentes = 1;
  final _serviciosSeleccionados = <String>{};

  @override
  void initState() {
    super.initState();
    _actividad = widget.espacio.actividades.first;
    _fecha = DateTime.now();
    _inicio = const TimeOfDay(hour: 10, minute: 0);
    _fin = const TimeOfDay(hour: 12, minute: 0);
  }

  int get _duracionHoras {
    final inicio = _inicio.hour * 60 + _inicio.minute;
    final fin = _fin.hour * 60 + _fin.minute;
    return ((fin - inicio) / 60).round().clamp(1, 24);
  }

  int get _extrasCentimos => widget.espacio.serviciosDisponibles
      .where((servicio) => _serviciosSeleccionados.contains(servicio.id))
      .fold(0, (total, servicio) => total + servicio.precioCentimos);

  int get _totalCentimos =>
      widget.espacio.precioHoraCentimos * _duracionHoras + _extrasCentimos;

  Future<void> _seleccionarFecha() async {
    final fecha = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDate: _fecha.isBefore(DateTime.now()) ? DateTime.now() : _fecha,
    );
    if (fecha != null) setState(() => _fecha = fecha);
  }

  Future<void> _seleccionarHora({required bool inicio}) async {
    final hora = await showTimePicker(
      context: context,
      initialTime: inicio ? _inicio : _fin,
    );
    if (hora == null) return;
    setState(() {
      if (inicio) {
        _inicio = hora;
      } else {
        _fin = hora;
      }
    });
  }

  void _confirmar() {
    if (_fin.hour * 60 + _fin.minute <= _inicio.hour * 60 + _inicio.minute) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Texto(texto: 'La hora de fin debe ser posterior al inicio.'),
        ),
      );
      return;
    }

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Texto(
          texto: 'Solicitud preparada',
          tipo: TipoTexto.subtitle,
        ),
        content: Texto(
          texto:
              'Demo: ${widget.espacio.nombre} · ${_fechaTexto(_fecha)} · '
              '$_duracionHoras horas · ${_precio(_totalCentimos)} '
              '${widget.espacio.moneda}. No se ha guardado ninguna reserva.',
        ),
        actions: [
          Boton(
            texto: 'Cerrar',
            tipo: TipoBoton.secundario,
            onPressed: () => Navigator.pop(context),
          ),
          Boton(
            texto: 'Continuar',
            onPressed: () {
              Navigator.pop(context);
              widget.onConfirmada?.call();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final espacio = widget.espacio;
    return Scaffold(
      appBar: AppBar(
        leading: const BotonVolver(),
        title: const Texto(texto: 'Nueva reserva', tipo: TipoTexto.subtitle),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
        children: [
          Texto(texto: espacio.nombre, tipo: TipoTexto.title),
          const SizedBox(height: 8),
          Texto(texto: espacio.ubicacion, tipo: TipoTexto.secondary),
          const SizedBox(height: 24),
          const _TituloFormulario(texto: 'Datos de la reserva'),
          DropdownButtonFormField<String>(
            initialValue: _actividad,
            decoration: const InputDecoration(labelText: 'Actividad'),
            items: espacio.actividades
                .map(
                  (actividad) => DropdownMenuItem(
                    value: actividad,
                    child: Texto(texto: actividad),
                  ),
                )
                .toList(),
            onChanged: (valor) {
              if (valor != null) setState(() => _actividad = valor);
            },
          ),
          const SizedBox(height: 12),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.calendar_today_outlined),
            title: Texto(texto: _fechaTexto(_fecha)),
            subtitle: const Texto(
              texto: 'Fecha de la actividad',
              tipo: TipoTexto.secondary,
            ),
            onTap: _seleccionarFecha,
          ),
          Row(
            children: [
              Expanded(
                child: _SelectorHora(
                  etiqueta: 'Inicio',
                  hora: _inicio,
                  onTap: () => _seleccionarHora(inicio: true),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _SelectorHora(
                  etiqueta: 'Fin',
                  hora: _fin,
                  onTap: () => _seleccionarHora(inicio: false),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<int>(
            initialValue: _asistentes,
            decoration: InputDecoration(
              labelText: 'Asistentes (máximo ${espacio.aforo})',
            ),
            items: List.generate(
              espacio.aforo,
              (indice) => DropdownMenuItem(
                value: indice + 1,
                child: Texto(texto: '${indice + 1}'),
              ),
            ),
            onChanged: (valor) {
              if (valor != null) setState(() => _asistentes = valor);
            },
          ),
          const SizedBox(height: 24),
          const _TituloFormulario(texto: 'Servicios extra'),
          if (espacio.serviciosDisponibles.isEmpty)
            const Texto(texto: 'Sin servicios extra disponibles')
          else
            ...espacio.serviciosDisponibles.map(_servicioSelector),
          const SizedBox(height: 24),
          _ResumenReserva(
            espacio: espacio,
            duracionHoras: _duracionHoras,
            extrasCentimos: _extrasCentimos,
            totalCentimos: _totalCentimos,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: Boton(
              texto: 'Confirmar solicitud demo',
              onPressed: _confirmar,
            ),
          ),
        ],
      ),
    );
  }

  Widget _servicioSelector(ServicioExtra servicio) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: _serviciosSeleccionados.contains(servicio.id),
      title: Texto(texto: servicio.nombre),
      subtitle: Texto(texto: '${_precio(servicio.precioCentimos)} EUR'),
      onChanged: (seleccionado) {
        setState(() {
          if (seleccionado == true) {
            _serviciosSeleccionados.add(servicio.id);
          } else {
            _serviciosSeleccionados.remove(servicio.id);
          }
        });
      },
    );
  }
}

class _TituloFormulario extends StatelessWidget {
  const _TituloFormulario({required this.texto});

  final String texto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Texto(texto: texto, tipo: TipoTexto.subtitle),
    );
  }
}

class _SelectorHora extends StatelessWidget {
  const _SelectorHora({
    required this.etiqueta,
    required this.hora,
    required this.onTap,
  });

  final String etiqueta;
  final TimeOfDay hora;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Texto(texto: etiqueta, tipo: TipoTexto.secondary),
      subtitle: Texto(texto: hora.format(context), tipo: TipoTexto.subtitle),
      leading: const Icon(Icons.schedule_outlined),
      onTap: onTap,
    );
  }
}

class _ResumenReserva extends StatelessWidget {
  const _ResumenReserva({
    required this.espacio,
    required this.duracionHoras,
    required this.extrasCentimos,
    required this.totalCentimos,
  });

  final Espacio espacio;
  final int duracionHoras;
  final int extrasCentimos;
  final int totalCentimos;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Texto(texto: 'Desglose', tipo: TipoTexto.subtitle),
            const SizedBox(height: 10),
            Texto(
              texto:
                  '${_precio(espacio.precioHoraCentimos)} EUR × '
                  '$duracionHoras horas',
            ),
            Texto(texto: 'Servicios extra: ${_precio(extrasCentimos)} EUR'),
            const Divider(height: 20),
            Texto(
              texto: 'Total: ${_precio(totalCentimos)} ${espacio.moneda}',
              tipo: TipoTexto.subtitle,
            ),
          ],
        ),
      ),
    );
  }
}

String _fechaTexto(DateTime fecha) {
  return '${fecha.day.toString().padLeft(2, '0')}/'
      '${fecha.month.toString().padLeft(2, '0')}/${fecha.year}';
}

String _precio(int centimos) => (centimos / 100).toStringAsFixed(2);
