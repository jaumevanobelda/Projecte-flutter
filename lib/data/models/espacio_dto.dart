import 'contacto_local_dto.dart';
import 'servicio_extra_dto.dart';

class EspacioDto {
  EspacioDto({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.ubicacion,
    required this.horario,
    required this.condicionesUso,
    required this.aforo,
    required this.imagenAsset,
    required List<String> imagenesAssets,
    this.sitioWeb,
    required List<ServicioExtraDto> serviciosDisponibles,
    required List<String> actividades,
    required List<String> equipamiento,
    required this.precioHoraCentimos,
    required this.moneda,
    required this.contacto,
  }) : imagenesAssets = List.unmodifiable(imagenesAssets),
       serviciosDisponibles = List.unmodifiable(serviciosDisponibles),
       actividades = List.unmodifiable(actividades),
       equipamiento = List.unmodifiable(equipamiento);

  final String id;
  final String nombre;
  final String descripcion;
  final String ubicacion;
  final String horario;
  final String condicionesUso;
  final int aforo;
  final String imagenAsset;
  final List<String> imagenesAssets;
  final String? sitioWeb;
  final List<ServicioExtraDto> serviciosDisponibles;
  final List<String> actividades;
  final List<String> equipamiento;
  final int precioHoraCentimos;
  final String moneda;
  final ContactoLocalDto contacto;
}
