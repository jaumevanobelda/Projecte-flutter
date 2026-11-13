class FranjaDisponibilidadDto {
  const FranjaDisponibilidadDto({
    required this.inicioIso,
    required this.finIso,
    required this.disponible,
  });

  final String inicioIso;
  final String finIso;
  final bool disponible;
}
