import '../models/comentario_dto.dart';
import '../models/disponibilidad_dia_dto.dart';
import '../models/espacio_dto.dart';
import '../models/reserva_dto.dart';
import '../models/usuario_dto.dart';

class DatosSimuladosService {
  DatosSimuladosService({
    required List<EspacioDto> espacios,
    required List<ReservaDto> reservas,
    required List<UsuarioDto> usuarios,
    required List<ComentarioDto> comentarios,
    required List<DisponibilidadDiaDto> disponibilidad,
  }) : _espacios = List.unmodifiable(espacios),
       _reservas = List.unmodifiable(reservas),
       _usuarios = List.unmodifiable(usuarios),
       _comentarios = List.unmodifiable(comentarios),
       _disponibilidad = List.unmodifiable(disponibilidad);

  final List<EspacioDto> _espacios;
  final List<ReservaDto> _reservas;
  final List<UsuarioDto> _usuarios;
  final List<ComentarioDto> _comentarios;
  final List<DisponibilidadDiaDto> _disponibilidad;

  List<EspacioDto> leerEspacios() => _espacios;
  List<ReservaDto> leerReservas() => _reservas;
  List<UsuarioDto> leerUsuarios() => _usuarios;
  List<ComentarioDto> leerComentarios() => _comentarios;
  List<DisponibilidadDiaDto> leerDisponibilidad() => _disponibilidad;
}
