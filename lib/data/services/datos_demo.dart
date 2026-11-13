import '../models/servicio_extra_dto.dart';
import '../models/servicio_contratado_dto.dart';
import '../models/comentario_dto.dart';
import '../models/disponibilidad_dia_dto.dart';
import '../models/franja_disponibilidad_dto.dart';
import '../models/contacto_local_dto.dart';
import '../models/espacio_dto.dart';
import '../models/reserva_dto.dart';
import '../models/usuario_dto.dart';

const contactoCentro = ContactoLocalDto(
  id: 'c1',
  nombre: 'Ana Soler',
  telefono: '600 000 101',
  correo: 'ana@example.com',
);

const contactoParque = ContactoLocalDto(
  id: 'c2',
  nombre: 'Pau Vidal',
  telefono: '600 000 102',
  correo: 'pau@example.com',
);

const contactoMirador = ContactoLocalDto(
  id: 'c3',
  nombre: 'Nora Ferrer',
  telefono: '600 000 103',
  correo: 'nora@example.com',
);

const e1_limpieza = ServicioExtraDto(
  id: 'e1_limpieza',
  nombre: 'Limpieza final',
  descripcion: 'Limpieza del espacio al terminar.',
  precioCentimos: 1500,
);

const e1_cafe = ServicioExtraDto(
  id: 'e1_cafe',
  nombre: 'Pausa cafe',
  descripcion: 'Bebidas calientes para el grupo.',
  precioCentimos: 1200,
);

const e2_decoracion = ServicioExtraDto(
  id: 'e2_decoracion',
  nombre: 'Decoracion',
  descripcion: 'Preparacion decorativa del patio.',
  precioCentimos: 6000,
);

const e2_limpieza = ServicioExtraDto(
  id: 'e2_limpieza',
  nombre: 'Limpieza final',
  descripcion: 'Recogida y limpieza posterior.',
  precioCentimos: 2500,
);

const e3_materiales = ServicioExtraDto(
  id: 'e3_materiales',
  nombre: 'Material de taller',
  descripcion: 'Material consumible para la actividad.',
  precioCentimos: 1000,
);

const e3_limpieza = ServicioExtraDto(
  id: 'e3_limpieza',
  nombre: 'Limpieza final',
  descripcion: 'Limpieza de mesas y utensilios.',
  precioCentimos: 1200,
);

const e4_cafe = ServicioExtraDto(
  id: 'e4_cafe',
  nombre: 'Pausa cafe',
  descripcion: 'Servicio de bebidas para la reunion.',
  precioCentimos: 1000,
);

const e4_grabacion = ServicioExtraDto(
  id: 'e4_grabacion',
  nombre: 'Grabacion',
  descripcion: 'Grabacion local de la sesion.',
  precioCentimos: 2000,
);

const e5_montaje = ServicioExtraDto(
  id: 'e5_montaje',
  nombre: 'Montaje especial',
  descripcion: 'Distribucion del mobiliario antes del acto.',
  precioCentimos: 8000,
);

const e5_limpieza = ServicioExtraDto(
  id: 'e5_limpieza',
  nombre: 'Limpieza final',
  descripcion: 'Limpieza al terminar la celebracion.',
  precioCentimos: 4500,
);

const e6_carpa = ServicioExtraDto(
  id: 'e6_carpa',
  nombre: 'Carpa',
  descripcion: 'Instalacion de una carpa de sombra.',
  precioCentimos: 4000,
);

const e6_limpieza = ServicioExtraDto(
  id: 'e6_limpieza',
  nombre: 'Limpieza final',
  descripcion: 'Recogida del jardin tras la actividad.',
  precioCentimos: 2000,
);

const usuariosDemo = <UsuarioDto>[
  UsuarioDto(id: 'u1', nombre: 'Alex Lopez', correo: 'alex@example.com'),
  UsuarioDto(id: 'u2', nombre: 'Cris Marin', correo: 'cris@example.com'),
  UsuarioDto(id: 'u3', nombre: 'Sam Roca', correo: 'sam@example.com'),
];

 var espaciosDemo = [
  EspacioDto(
    id: 'e1',
    nombre: 'Sala Ágora',
    descripcion: 'Sala luminosa para reuniones de equipo y talleres de pequeño formato.',
    ubicacion: 'Centro · Calle del Encuentro, 12',
    horario: '09:00–20:00',
    condicionesUso: 'No fumar. Recoger el material al finalizar.',
    imagenAsset: 'assets/images/sala_agora.png',
    imagenesAssets: ['assets/images/sala_agora.png', 'assets/images/sala_agora_02.png', 'assets/images/sala_agora_03.png'],
    sitioWeb: 'https://example.com/espacios/e1',
    serviciosDisponibles: [e1_limpieza, e1_cafe],
    aforo: 20,
    precioHoraCentimos: 3000,
    actividades: ['Reunion', 'Taller'],
    equipamiento: ['Wi-Fi', 'Proyector', 'Acceso sin escalones'],
    contacto: contactoCentro,
    moneda: 'EUR',
  ),
  EspacioDto(
    id: 'e2',
    nombre: 'Patio Llum',
    descripcion: 'Patio exterior con zona cubierta para celebraciones y actividades en grupo.',
    ubicacion: 'Barrio del Parque · Plaza de la Luz, 4',
    horario: '10:00–22:00',
    condicionesUso: 'Respetar el horario y evitar musica amplificada.',
    imagenAsset: 'assets/images/patio_llum.png',
    imagenesAssets: ['assets/images/patio_llum.png', 'assets/images/patio_llum_02.png', 'assets/images/patio_llum_03.png'],
    sitioWeb: 'https://example.com/espacios/e2',
    serviciosDisponibles: [e2_decoracion, e2_limpieza],
    aforo: 40,
    precioHoraCentimos: 4500,
    actividades: ['Celebracion', 'Taller'],
    equipamiento: ['Mesas', 'Zona cubierta', 'Aseos accesibles'],
    contacto: contactoParque,
    moneda: 'EUR',
  ),
  EspacioDto(
    id: 'e3',
    nombre: 'Aula Crea',
    descripcion: 'Aula flexible para talleres creativos y encuentros de grupos reducidos.',
    ubicacion: 'Centro · Calle del Encuentro, 12',
    horario: '09:00–20:00',
    condicionesUso: 'Proteger las mesas y limpiar los utensilios utilizados.',
    imagenAsset: 'assets/images/aula_crea.png',
    imagenesAssets: ['assets/images/aula_crea.png', 'assets/images/aula_crea_02.png', 'assets/images/aula_crea_03.png'],
    sitioWeb: null,
    serviciosDisponibles: [e3_materiales, e3_limpieza],
    aforo: 16,
    precioHoraCentimos: 2000,
    actividades: ['Taller', 'Reunion'],
    equipamiento: ['Pizarra', 'Mesas moviles', 'Fregadero'],
    contacto: contactoCentro,
    moneda: 'EUR',
  ),
  EspacioDto(
    id: 'e4',
    nombre: 'Sala Mirador',
    descripcion: 'Espacio tranquilo con vistas para reuniones y presentaciones.',
    ubicacion: 'Barrio Alto · Paseo del Mirador, 8',
    horario: '08:00–19:00',
    condicionesUso: 'Mantener el volumen bajo y dejar las sillas ordenadas.',
    imagenAsset: 'assets/images/sala_mirador.png',
    imagenesAssets: ['assets/images/sala_mirador.png', 'assets/images/sala_mirador_02.png', 'assets/images/sala_mirador_03.png'],
    sitioWeb: 'https://example.com/espacios/e4',
    serviciosDisponibles: [e4_cafe, e4_grabacion],
    aforo: 12,
    precioHoraCentimos: 2500,
    actividades: ['Reunion'],
    equipamiento: ['Pantalla', 'Wi-Fi', 'Aire acondicionado'],
    contacto: contactoMirador,
    moneda: 'EUR',
  ),
  EspacioDto(
    id: 'e5',
    nombre: 'Salon Nexo',
    descripcion: 'Salon amplio para celebraciones, reuniones y talleres colectivos.',
    ubicacion: 'Barrio Alto · Paseo del Mirador, 10',
    horario: '10:00–23:00',
    condicionesUso: 'No utilizar confeti. Devolver el mobiliario a su posicion.',
    imagenAsset: 'assets/images/salon_nexo.png',
    imagenesAssets: ['assets/images/salon_nexo.png', 'assets/images/salon_nexo_02.png', 'assets/images/salon_nexo_03.png'],
    sitioWeb: 'https://example.com/espacios/e5',
    serviciosDisponibles: [e5_montaje, e5_limpieza],
    aforo: 60,
    precioHoraCentimos: 6000,
    actividades: ['Celebracion', 'Reunion', 'Taller'],
    equipamiento: ['Equipo de sonido', 'Sillas', 'Aseos accesibles'],
    contacto: contactoMirador,
    moneda: 'EUR',
  ),
  EspacioDto(
    id: 'e6',
    nombre: 'Jardin Brisa',
    descripcion: 'Jardin con sombra para talleres y celebraciones al aire libre.',
    ubicacion: 'Barrio del Parque · Camino de la Brisa, 3',
    horario: '09:00–21:00',
    condicionesUso: 'Cuidar la vegetacion y retirar todos los residuos.',
    imagenAsset: 'assets/images/jardin_brisa.png',
    imagenesAssets: ['assets/images/jardin_brisa.png', 'assets/images/jardin_brisa_02.png', 'assets/images/jardin_brisa_03.png'],
    sitioWeb: null,
    serviciosDisponibles: [e6_carpa, e6_limpieza],
    aforo: 30,
    precioHoraCentimos: 3500,
    actividades: ['Taller', 'Celebracion'],
    equipamiento: ['Bancos', 'Zona de sombra', 'Punto de agua'],
    contacto: contactoParque,
    moneda: 'EUR',
  ),
];

var reservasDemo = <ReservaDto>[
  ReservaDto(
    id: 'r1',
    espacioId: 'e1',
    usuarioId: 'u1',
    actividad: 'Reunion',
    inicioIso: '2026-11-12T10:00:00',
    finIso: '2026-11-12T12:00:00',
    asistentes: 12,
    codigoEstado: 'CONF',
    tarifaHoraCentimos: 3000,
    precioTotalCentimos: 7500,
    moneda: 'EUR',
    serviciosContratados: [
      ServicioContratadoDto(
        servicioId: 'e1_limpieza',
        nombre: 'Limpieza final',
        precioCentimos: 1500,
      ),
    ],
  ),
  ReservaDto(
    id: 'r2',
    espacioId: 'e2',
    usuarioId: 'u1',
    actividad: 'Celebracion',
    inicioIso: '2026-11-20T17:00:00',
    finIso: '2026-11-20T20:00:00',
    asistentes: 25,
    codigoEstado: 'PEND',
    tarifaHoraCentimos: 4500,
    precioTotalCentimos: 19500,
    moneda: 'EUR',
    serviciosContratados: [
      ServicioContratadoDto(
        servicioId: 'e2_decoracion',
        nombre: 'Decoracion',
        precioCentimos: 6000,
      ),
    ],
  ),
  ReservaDto(
    id: 'r3',
    espacioId: 'e3',
    usuarioId: 'u1',
    actividad: 'Taller',
    inicioIso: '2026-11-08T16:00:00',
    finIso: '2026-11-08T18:00:00',
    asistentes: 10,
    codigoEstado: 'CANC',
    tarifaHoraCentimos: 2000,
    precioTotalCentimos: 4000,
    moneda: 'EUR',
    serviciosContratados: [],
  ),
  ReservaDto(
    id: 'r4',
    espacioId: 'e4',
    usuarioId: 'u2',
    actividad: 'Reunion',
    inicioIso: '2026-11-15T09:00:00',
    finIso: '2026-11-15T12:00:00',
    asistentes: 8,
    codigoEstado: 'CONF',
    tarifaHoraCentimos: 2500,
    precioTotalCentimos: 8500,
    moneda: 'EUR',
    serviciosContratados: [
      ServicioContratadoDto(
        servicioId: 'e4_cafe',
        nombre: 'Pausa cafe',
        precioCentimos: 1000,
      ),
    ],
  ),
];

const comentariosDemo = <ComentarioDto>[
  ComentarioDto(
    id: 'co1',
    espacioId: 'e1',
    autorId: 'u2',
    puntuacion: 5,
    texto: 'Sala comoda y luminosa. El contacto nos atendio muy bien.',
    fechaIso: '2026-10-20T18:00:00',
  ),
  ComentarioDto(
    id: 'co2',
    espacioId: 'e1',
    autorId: 'u3',
    puntuacion: 4,
    texto: 'Buen espacio para reuniones; se oye algo de ruido al entrar.',
    fechaIso: '2026-10-21T18:00:00',
  ),
  ComentarioDto(
    id: 'co3',
    espacioId: 'e2',
    autorId: 'u1',
    puntuacion: 4,
    texto: 'Patio amplio y agradable para una celebracion.',
    fechaIso: '2026-10-22T18:00:00',
  ),
  ComentarioDto(
    id: 'co4',
    espacioId: 'e3',
    autorId: 'u2',
    puntuacion: 5,
    texto: 'Las mesas moviles facilitan mucho los talleres.',
    fechaIso: '2026-10-23T18:00:00',
  ),
  ComentarioDto(
    id: 'co5',
    espacioId: 'e4',
    autorId: 'u3',
    puntuacion: 3,
    texto: 'Buenas vistas; resulta justo para grupos grandes.',
    fechaIso: '2026-10-24T18:00:00',
  ),
  ComentarioDto(
    id: 'co6',
    espacioId: 'e5',
    autorId: 'u1',
    puntuacion: 5,
    texto: 'El montaje especial nos ahorro mucho trabajo.',
    fechaIso: '2026-10-25T18:00:00',
  ),
];

// Fecha de referencia compartida por toda la demostracion.
final fechaReferenciaDemo = DateTime.now();
final disponibilidadDemo = crearDisponibilidadDemo(fechaReferenciaDemo);

List<DisponibilidadDiaDto> crearDisponibilidadDemo(DateTime referencia) {
  final resultado = <DisponibilidadDiaDto>[];
  for (var espacioIndex = 0; espacioIndex < espaciosDemo.length; espacioIndex++) {
    for (var diaIndex = 0; diaIndex < 7; diaIndex++) {
      final dia = DateTime(
        referencia.year,
        referencia.month,
        referencia.day + diaIndex,
      );
      final franjas = <FranjaDisponibilidadDto>[];
      const horasInicio = [10, 13, 17];
      for (var franjaIndex = 0; franjaIndex < horasInicio.length; franjaIndex++) {
        final hora = horasInicio[franjaIndex];
        franjas.add(
          FranjaDisponibilidadDto(
            inicioIso: DateTime(dia.year, dia.month, dia.day, hora).toIso8601String(),
            finIso: DateTime(dia.year, dia.month, dia.day, hora + 2).toIso8601String(),
            disponible: (espacioIndex + diaIndex + franjaIndex) % 4 != 0,
          ),
        );
      }
      resultado.add(
        DisponibilidadDiaDto(
          espacioId: espaciosDemo[espacioIndex].id,
          fechaIso: dia.toIso8601String(),
          franjas: List.unmodifiable(franjas),
        ),
      );
    }
  }
  return List.unmodifiable(resultado);
}
