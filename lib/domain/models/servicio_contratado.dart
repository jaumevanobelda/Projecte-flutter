class ServicioContratado {
  const ServicioContratado({
    required this.servicioId,
    required this.nombre,
    required this.precioCentimos,
  });

  final String servicioId;
  final String nombre;
  final int precioCentimos;
}
