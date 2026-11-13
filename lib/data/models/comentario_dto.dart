class ComentarioDto {
  const ComentarioDto({
    required this.id,
    required this.espacioId,
    required this.autorId,
    required this.puntuacion,
    required this.texto,
    required this.fechaIso,
  });

  final String id;
  final String espacioId;
  final String autorId;
  final int puntuacion;
  final String texto;
  final String fechaIso;
}
