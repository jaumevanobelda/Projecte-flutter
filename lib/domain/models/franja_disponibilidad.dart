class FranjaDisponibilidad {
  FranjaDisponibilidad({
    required this.inicio,
    required this.fin,
    required this.disponible,
  }) : assert(fin.isAfter(inicio));

  final DateTime inicio;
  final DateTime fin;
  final bool disponible;
}
