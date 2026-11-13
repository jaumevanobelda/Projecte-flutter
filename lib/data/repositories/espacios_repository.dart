import '../../domain/models/contacto_local.dart';
import '../../domain/models/espacio.dart';
import '../../domain/models/servicio_extra.dart';
import '../models/contacto_local_dto.dart';
import '../models/espacio_dto.dart';
import '../services/datos_simulados_service.dart';

class EspaciosRepository {
  EspaciosRepository({required DatosSimuladosService service})
    : _espacios = _convertirTodos(service.leerEspacios());

  final List<Espacio> _espacios;

  List<Espacio> obtenerTodos() => _espacios;

  Espacio? obtenerPorId(String id) {
    for (final espacio in _espacios) {
      if (espacio.id == id) return espacio;
    }
    return null;
  }

  static List<Espacio> _convertirTodos(List<EspacioDto> dtos) {
    _comprobarIds(dtos.map((dto) => dto.id), 'espacios');
    return List.unmodifiable(dtos.map(_convertir));
  }

  static Espacio _convertir(EspacioDto dto) {
    if (dto.aforo <= 0) {
      throw StateError('El aforo del espacio ${dto.id} no es válido');
    }
    if (dto.precioHoraCentimos < 0 || dto.moneda != 'EUR') {
      throw StateError('La tarifa del espacio ${dto.id} no es válida');
    }

    final servicios = dto.serviciosDisponibles.map((servicio) {
      if (servicio.precioCentimos < 0) {
        throw StateError('El precio del servicio ${servicio.id} no es válido');
      }
      return ServicioExtra(
        id: servicio.id,
        nombre: servicio.nombre,
        descripcion: servicio.descripcion,
        precioCentimos: servicio.precioCentimos,
      );
    }).toList();
    _comprobarIds(servicios.map((servicio) => servicio.id), 'servicios');

    return Espacio(
      id: dto.id,
      nombre: dto.nombre,
      descripcion: dto.descripcion,
      ubicacion: dto.ubicacion,
      horario: dto.horario,
      condicionesUso: dto.condicionesUso,
      aforo: dto.aforo,
      imagenAsset: dto.imagenAsset,
      imagenesAssets: List.unmodifiable(dto.imagenesAssets),
      sitioWeb: dto.sitioWeb,
      serviciosDisponibles: List.unmodifiable(servicios),
      actividades: List.unmodifiable(dto.actividades),
      equipamiento: List.unmodifiable(dto.equipamiento),
      precioHoraCentimos: dto.precioHoraCentimos,
      moneda: dto.moneda,
      contacto: _convertirContacto(dto.contacto),
    );
  }

  static ContactoLocal _convertirContacto(ContactoLocalDto contacto) {
    return ContactoLocal(
      id: contacto.id,
      nombre: contacto.nombre,
      telefono: contacto.telefono,
      correo: contacto.correo,
    );
  }

  static void _comprobarIds(Iterable<String> ids, String tipo) {
    final vistos = <String>{};
    for (final id in ids) {
      if (!vistos.add(id)) {
        throw StateError('Identificador duplicado en $tipo: $id');
      }
    }
  }
}
