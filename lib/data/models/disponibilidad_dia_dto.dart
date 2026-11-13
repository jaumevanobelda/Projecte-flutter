import 'franja_disponibilidad_dto.dart';

class DisponibilidadDiaDto {
  DisponibilidadDiaDto({
    required this.espacioId,
    required this.fechaIso,
    required List<FranjaDisponibilidadDto> franjas,
  }) : franjas = List.unmodifiable(franjas);

  final String espacioId;
  final String fechaIso;
  final List<FranjaDisponibilidadDto> franjas;
}
