import 'usuario.dart';

class Comentario {
  Comentario({
    required this.id,
    required this.espacioId,
    required this.autor,
    required this.puntuacion,
    required this.texto,
    required this.fecha,
  }) : assert(puntuacion >= 1),
       assert(puntuacion <= 5),
       assert(texto.trim().isNotEmpty);

  final String id;
  final String espacioId;
  final Usuario autor;
  final int puntuacion;
  final String texto;
  final DateTime fecha;
}
