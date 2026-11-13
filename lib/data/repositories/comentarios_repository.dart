import '../../domain/models/comentario.dart';
import '../models/comentario_dto.dart';
import '../services/datos_simulados_service.dart';
import 'espacios_repository.dart';
import 'usuarios_repository.dart';

class ComentariosRepository {
  ComentariosRepository({
    required DatosSimuladosService service,
    required UsuariosRepository usuarios,
    required EspaciosRepository espacios,
  }) : _comentarios = _convertirTodos(
         service.leerComentarios(),
         usuarios: usuarios,
         espacios: espacios,
       );

  final List<Comentario> _comentarios;

  List<Comentario> obtenerPorEspacio(String espacioId) {
    final resultado =
        _comentarios
            .where((comentario) => comentario.espacioId == espacioId)
            .toList()
          ..sort((a, b) => b.fecha.compareTo(a.fecha));
    return List.unmodifiable(resultado);
  }

  double? obtenerMedia(String espacioId) {
    final comentarios = obtenerPorEspacio(espacioId);
    if (comentarios.isEmpty) return null;
    final suma = comentarios.fold<int>(
      0,
      (total, comentario) => total + comentario.puntuacion,
    );
    return suma / comentarios.length;
  }

  static List<Comentario> _convertirTodos(
    List<ComentarioDto> dtos, {
    required UsuariosRepository usuarios,
    required EspaciosRepository espacios,
  }) {
    final ids = <String>{};
    final comentarios = <Comentario>[];
    for (final dto in dtos) {
      if (!ids.add(dto.id)) {
        throw StateError('Identificador duplicado en comentarios: ${dto.id}');
      }
      if (espacios.obtenerPorId(dto.espacioId) == null) {
        throw StateError('Espacio inexistente en comentario ${dto.id}');
      }
      final autor = usuarios.obtenerPorId(dto.autorId);
      if (autor == null) {
        throw StateError('Autor inexistente en comentario ${dto.id}');
      }
      if (dto.puntuacion < 1 ||
          dto.puntuacion > 5 ||
          dto.texto.trim().isEmpty) {
        throw StateError('Comentario inválido: ${dto.id}');
      }
      comentarios.add(
        Comentario(
          id: dto.id,
          espacioId: dto.espacioId,
          autor: autor,
          puntuacion: dto.puntuacion,
          texto: dto.texto,
          fecha: DateTime.parse(dto.fechaIso),
        ),
      );
    }
    return List.unmodifiable(comentarios);
  }
}
