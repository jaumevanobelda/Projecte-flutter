import 'package:entrega_1/domain/models/contacto_local.dart';
import 'package:entrega_1/domain/models/espacio.dart';
import 'package:entrega_1/domain/models/reserva.dart';
import 'package:entrega_1/domain/models/servicio_contratado.dart';
import 'package:entrega_1/domain/models/servicio_extra.dart';
import 'package:entrega_1/domain/models/usuario.dart';

class ReservasDemo {
  static const usuario = Usuario(
    id: 'u1',
    nombre: 'Alex Garcia',
    correo: 'alex@example.com',
  );

  static const limpieza = ServicioExtra(
    id: 's1',
    nombre: 'Limpieza',
    descripcion: 'Limpieza del espacio al finalizar la actividad.',
    precioCentimos: 1500,
  );

  static const pausaCafe = ServicioExtra(
    id: 's2',
    nombre: 'Pausa de cafe',
    descripcion: 'Servicio de cafe para los asistentes.',
    precioCentimos: 1200,
  );

  static const salaReuniones = Espacio(
    id: 'e1',
    nombre: 'Sala de reuniones Centro',
    descripcion: 'Sala luminosa para reuniones y talleres.',
    ubicacion: 'Valencia',
    horario: '09:00 - 20:00',
    condicionesUso: 'Dejar el espacio recogido.',
    aforo: 12,
    imagenAsset: 'assets/images/sala_reuniones.jpg',
    imagenesAssets: <String>[],
    serviciosDisponibles: <ServicioExtra>[limpieza],
    actividades: <String>['Reunion', 'Taller'],
    equipamiento: <String>['Wi-Fi', 'Pizarra'],
    precioHoraCentimos: 3000,
    moneda: 'EUR',
    contacto: ContactoLocal(
      id: 'c1',
      nombre: 'Laura Martinez',
      telefono: '600000001',
      correo: 'laura@centro.example',
    ),
  );

  static const estudioCreativo = Espacio(
    id: 'e2',
    nombre: 'Estudio creativo Ruzafa',
    descripcion: 'Estudio flexible para sesiones creativas.',
    ubicacion: 'Valencia',
    horario: '10:00 - 22:00',
    condicionesUso: 'Respetar el material del estudio.',
    aforo: 8,
    imagenAsset: 'assets/images/estudio_creativo.jpg',
    imagenesAssets: <String>[],
    serviciosDisponibles: <ServicioExtra>[pausaCafe],
    actividades: <String>['Sesion fotografica', 'Taller'],
    equipamiento: <String>['Wi-Fi', 'Iluminacion'],
    precioHoraCentimos: 4500,
    moneda: 'EUR',
    contacto: ContactoLocal(
      id: 'c2',
      nombre: 'Miguel Soler',
      telefono: '600000002',
      correo: 'miguel@ruzafa.example',
    ),
  );

  static final reservas = <Reserva>[
    Reserva(
      id: 'r1',
      espacio: salaReuniones,
      usuario: usuario,
      actividad: 'Reunion',
      inicio: DateTime(2026, 11, 12, 10),
      fin: DateTime(2026, 11, 12, 12),
      asistentes: 6,
      estado: EstadoReserva.confirmada,
      serviciosContratados: <ServicioContratado>[
        ServicioContratado(
          servicioId: 's1',
          nombre: 'Limpieza',
          precioCentimos: 1500,
        ),
      ],
      tarifaHoraCentimos: 3000,
      precioTotalCentimos: 7500,
      moneda: 'EUR',
    ),
    Reserva(
      id: 'r2',
      espacio: estudioCreativo,
      usuario: usuario,
      actividad: 'Taller',
      inicio: DateTime(2026, 11, 14, 13),
      fin: DateTime(2026, 11, 14, 16),
      asistentes: 4,
      estado: EstadoReserva.confirmada,
      serviciosContratados: <ServicioContratado>[],
      tarifaHoraCentimos: 4500,
      precioTotalCentimos: 13500,
      moneda: 'EUR',
    ),
  ];
}
