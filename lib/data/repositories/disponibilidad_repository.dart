import '../../domain/models/disponibilidad_dia.dart';
import '../../domain/models/franja_disponibilidad.dart';
import '../models/disponibilidad_dia_dto.dart';
import '../services/datos_simulados_service.dart';
import 'espacios_repository.dart';

class DisponibilidadRepository {
  DisponibilidadRepository({
    required DatosSimuladosService service,
    required EspaciosRepository espacios,
  }) : _dias = _convertirTodos(
         service.leerDisponibilidad(),
         espacios: espacios,
       );

  final List<DisponibilidadDia> _dias;

  List<DisponibilidadDia> obtenerSieteDias(String espacioId, DateTime desde) {
    final inicio = DateTime(desde.year, desde.month, desde.day);
    final resultado = List<DisponibilidadDia>.generate(7, (indice) {
      final fecha = inicio.add(Duration(days: indice));
      final encontrados = _dias.where(
        (dia) => dia.espacioId == espacioId && _mismoDia(dia.fecha, fecha),
      );
      DisponibilidadDia? dia;
      for (final encontrado in encontrados) {
        dia = encontrado;
        break;
      }
      if (dia == null) {
        throw StateError(
          'Falta disponibilidad para $espacioId en ${fecha.toIso8601String()}',
        );
      }
      return dia;
    });
    return List.unmodifiable(resultado);
  }

  static List<DisponibilidadDia> _convertirTodos(
    List<DisponibilidadDiaDto> dtos, {
    required EspaciosRepository espacios,
  }) {
    final claves = <String>{};
    final dias = <DisponibilidadDia>[];
    for (final dto in dtos) {
      if (espacios.obtenerPorId(dto.espacioId) == null) {
        throw StateError('Espacio inexistente en disponibilidad');
      }
      final fecha = DateTime.parse(dto.fechaIso);
      if (fecha.hour != 0 ||
          fecha.minute != 0 ||
          fecha.second != 0 ||
          fecha.millisecond != 0 ||
          fecha.microsecond != 0) {
        throw StateError('La fecha no está normalizada');
      }
      final clave =
          '${dto.espacioId}|${fecha.year}-${fecha.month}-${fecha.day}';
      if (!claves.add(clave)) {
        throw StateError('Día duplicado en disponibilidad: $clave');
      }
      final franjas = dto.franjas.map((franjaDto) {
        final inicio = DateTime.parse(franjaDto.inicioIso);
        final fin = DateTime.parse(franjaDto.finIso);
        if (!fin.isAfter(inicio) || !_mismoDia(inicio, fecha)) {
          throw StateError('Franja inválida en disponibilidad: $clave');
        }
        return FranjaDisponibilidad(
          inicio: inicio,
          fin: fin,
          disponible: franjaDto.disponible,
        );
      }).toList();
      for (var i = 0; i < franjas.length; i++) {
        for (var j = i + 1; j < franjas.length; j++) {
          if (franjas[i].inicio.isBefore(franjas[j].fin) &&
              franjas[j].inicio.isBefore(franjas[i].fin)) {
            throw StateError('Franjas solapadas en disponibilidad: $clave');
          }
        }
      }
      dias.add(
        DisponibilidadDia(
          espacioId: dto.espacioId,
          fecha: DateTime(fecha.year, fecha.month, fecha.day),
          franjas: List.unmodifiable(franjas),
        ),
      );
    }
    return List.unmodifiable(dias);
  }

  static bool _mismoDia(DateTime primero, DateTime segundo) {
    return primero.year == segundo.year &&
        primero.month == segundo.month &&
        primero.day == segundo.day;
  }
}
