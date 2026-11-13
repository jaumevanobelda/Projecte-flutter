import 'servicio_contratado_dto.dart';

class ReservaDto {
  ReservaDto({
    required this.id,
    required this.espacioId,
    required this.usuarioId,
    required this.actividad,
    required this.inicioIso,
    required this.finIso,
    required this.asistentes,
    required this.codigoEstado,
    required this.tarifaHoraCentimos,
    required this.precioTotalCentimos,
    required this.moneda,
    required List<ServicioContratadoDto> serviciosContratados,
  }) : serviciosContratados = List.unmodifiable(serviciosContratados);

  final String id;
  final String espacioId;
  final String usuarioId;
  final String actividad;
  final String inicioIso;
  final String finIso;
  final int asistentes;
  final String codigoEstado;
  final int tarifaHoraCentimos;
  final int precioTotalCentimos;
  final String moneda;
  final List<ServicioContratadoDto> serviciosContratados;
}
