import '../../domain/models/reserva.dart';
import '../../domain/models/servicio_contratado.dart';
import '../../domain/models/servicio_extra.dart';
import '../models/reserva_dto.dart';
import '../services/datos_simulados_service.dart';
import 'espacios_repository.dart';
import 'usuarios_repository.dart';

class ReservasRepository {
  ReservasRepository({
    required DatosSimuladosService service,
    required EspaciosRepository espacios,
    required UsuariosRepository usuarios,
  }) : _reservas = _convertirTodos(
         service.leerReservas(),
         espacios: espacios,
         usuarios: usuarios,
       );

  final List<Reserva> _reservas;

  List<Reserva> obtenerPorUsuario(String usuarioId) {
    return List.unmodifiable(
      _reservas.where((reserva) => reserva.usuario.id == usuarioId),
    );
  }

  Reserva? obtenerPorId(String id) {
    for (final reserva in _reservas) {
      if (reserva.id == id) return reserva;
    }
    return null;
  }

  static List<Reserva> _convertirTodos(
    List<ReservaDto> dtos, {
    required EspaciosRepository espacios,
    required UsuariosRepository usuarios,
  }) {
    final ids = <String>{};
    final reservas = <Reserva>[];
    for (final dto in dtos) {
      if (!ids.add(dto.id)) {
        throw StateError('Identificador duplicado en reservas: ${dto.id}');
      }
      reservas.add(_convertir(dto, espacios: espacios, usuarios: usuarios));
    }
    return List.unmodifiable(reservas);
  }

  static Reserva _convertir(
    ReservaDto dto, {
    required EspaciosRepository espacios,
    required UsuariosRepository usuarios,
  }) {
    final espacio = espacios.obtenerPorId(dto.espacioId);
    final usuario = usuarios.obtenerPorId(dto.usuarioId);
    if (espacio == null || usuario == null) {
      throw StateError('Referencia de reserva inexistente: ${dto.id}');
    }

    final inicio = DateTime.parse(dto.inicioIso);
    final fin = DateTime.parse(dto.finIso);
    if (!fin.isAfter(inicio)) {
      throw StateError('Intervalo de reserva no válido: ${dto.id}');
    }
    final duracion = fin.difference(inicio);
    if (duracion.inMinutes % 60 != 0 || duracion.inHours <= 0) {
      throw StateError('La reserva debe durar horas completas: ${dto.id}');
    }
    if (dto.asistentes <= 0 || dto.asistentes > espacio.aforo) {
      throw StateError('Aforo inválido en la reserva ${dto.id}');
    }
    if (!espacio.admiteActividad(dto.actividad)) {
      throw StateError('Actividad no admitida en la reserva ${dto.id}');
    }
    if (dto.tarifaHoraCentimos < 0 ||
        dto.precioTotalCentimos < 0 ||
        dto.moneda != espacio.moneda) {
      throw StateError('Importe o moneda inválidos en la reserva ${dto.id}');
    }

    final servicioIds = <String>{};
    var totalServicios = 0;
    final servicios = <ServicioContratado>[];
    for (final servicioDto in dto.serviciosContratados) {
      if (!servicioIds.add(servicioDto.servicioId) ||
          servicioDto.precioCentimos < 0) {
        throw StateError('Servicios inválidos en la reserva ${dto.id}');
      }
      ServicioExtra? servicio;
      for (final extra in espacio.serviciosDisponibles) {
        if (extra.id == servicioDto.servicioId) {
          servicio = extra;
          break;
        }
      }
      if (servicio == null) {
        throw StateError('Servicio inexistente en la reserva ${dto.id}');
      }
      totalServicios += servicioDto.precioCentimos;
      servicios.add(
        ServicioContratado(
          servicioId: servicioDto.servicioId,
          nombre: servicioDto.nombre,
          precioCentimos: servicioDto.precioCentimos,
        ),
      );
    }
    final totalEsperado =
        dto.tarifaHoraCentimos * duracion.inHours + totalServicios;
    if (dto.precioTotalCentimos != totalEsperado) {
      throw StateError('Total inválido en la reserva ${dto.id}');
    }

    final estado = switch (dto.codigoEstado) {
      'CONF' => EstadoReserva.confirmada,
      'PEND' => EstadoReserva.pendiente,
      'CANC' => EstadoReserva.cancelada,
      _ => throw FormatException('Estado de reserva desconocido'),
    };

    return Reserva(
      id: dto.id,
      espacio: espacio,
      usuario: usuario,
      actividad: dto.actividad,
      inicio: inicio,
      fin: fin,
      asistentes: dto.asistentes,
      estado: estado,
      serviciosContratados: List.unmodifiable(servicios),
      tarifaHoraCentimos: dto.tarifaHoraCentimos,
      precioTotalCentimos: dto.precioTotalCentimos,
      moneda: dto.moneda,
    );
  }
}
