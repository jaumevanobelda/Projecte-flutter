import '../../domain/models/usuario.dart';
import '../models/usuario_dto.dart';
import '../services/datos_simulados_service.dart';

class UsuariosRepository {
  UsuariosRepository({required DatosSimuladosService service})
    : _usuarios = _convertirTodos(service.leerUsuarios());

  final List<Usuario> _usuarios;

  Usuario? obtenerPorId(String id) {
    for (final usuario in _usuarios) {
      if (usuario.id == id) return usuario;
    }
    return null;
  }

  Usuario obtenerUsuarioDemo() {
    final usuario = obtenerPorId('u1');
    if (usuario == null) {
      throw StateError('No existe el usuario demo u1');
    }
    return usuario;
  }

  static List<Usuario> _convertirTodos(List<UsuarioDto> dtos) {
    final ids = <String>{};
    final usuarios = <Usuario>[];
    for (final dto in dtos) {
      if (!ids.add(dto.id)) {
        throw StateError('Identificador duplicado en usuarios: ${dto.id}');
      }
      usuarios.add(Usuario(id: dto.id, nombre: dto.nombre, correo: dto.correo));
    }
    return List.unmodifiable(usuarios);
  }
}
