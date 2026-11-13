# Reservas

## Nombre, autoría y descripción

**Reservas** es un mockup navegable de una aplicación Flutter para descubrir
espacios y preparar solicitudes de reserva. Permite recorrer el acceso,
consultar espacios, ver su detalle, preparar una reserva, consultar reservas
demo y revisar el perfil del usuario.

**Autoría:** Jaume Vanó Belda.

El proyecto corresponde a la primera entrega del proyecto integrador y está
orientado a demostrar la capa de presentación y la navegación entre pantallas.

## Requisitos e instalación

Versiones utilizadas:

- Flutter compatible con Dart `3.13.4` (canal estable).
- Dart SDK `3.13.4`.
- SDK mínimo declarado en `pubspec.yaml`: `^3.13.4`.

Para instalar las dependencias y ejecutar la aplicación:

```bash
flutter pub get
flutter run
```

Para comprobar el proyecto:

```bash
dart format lib
flutter analyze
flutter test
```

La aplicación utiliza Flutter Material 3 y no necesita servicios externos ni
variables de entorno.

## Estructura y arquitectura

```text
lib/
├── main.dart
├── ui/
│   ├── acceso/ui/       # Login y registro
│   ├── espacios/ui/     # Catálogo y detalle de espacios
│   ├── reservas/ui/     # Nueva reserva y mis reservas
│   ├── perfil/ui/       # Perfil y ajustes
│   └── core/ui/         # Widgets reutilizables
├── domain/models/       # Entidades de negocio
└── data/
    ├── models/          # DTOs
    ├── repositories/    # Conversión y acceso a datos
    └── services/        # Datos simulados
```

- `ui` contiene las pantallas, la composición visual y el estado de
  presentación.
- `domain` contiene las entidades `Espacio`, `Reserva`, `Usuario`,
  `Comentario`, disponibilidad y servicios.
- `data` contiene DTOs, repositorios y el servicio de datos demo. Los
  repositorios convierten los DTOs en modelos de dominio antes de entregarlos
  a la interfaz.
- `main.dart` coordina el acceso simulado, la sesión y el `NavigationBar`
  principal.

La estructura sigue como referencia complementaria la guía de [Proyecto
integrador: entrega 1](https://jovisal1.github.io/ApuntesPMDM/proyecto-integrador/entrega-1/).

## Pantallas implementadas y recorrido

La aplicación incluye:

1. **Login:** acceso simulado con correo y contraseña.
2. **Registro:** formulario de alta ficticia.
3. **Espacios:** catálogo desplazable con seis espacios.
4. **Detalle de espacio:** galería, datos, equipamiento, contacto,
   disponibilidad y opiniones.
5. **Nueva reserva:** actividad, fecha, horario, asistentes, servicios extra
   y desglose de precio.
6. **Mis reservas:** reservas demo con horarios, estados, extras, precios y
   contacto.
7. **Perfil y ajustes:** usuario, preferencias, información de la aplicación
   y cierre de sesión.

Recorrido recomendado:

1. Ejecuta la aplicación y pulsa **Iniciar sesión**.
2. En **Espacios**, abre cualquier tarjeta, incluida una de las últimas del
   listado.
3. En el detalle, revisa el carrusel, las franjas, las opiniones y pulsa
   **Reservar**.
4. En **Nueva reserva**, cambia la actividad, fecha, horario, asistentes y
   servicios extra. Pulsa **Confirmar solicitud demo**.
5. Usa el menú inferior para cambiar entre **Espacios**, **Reservar**,
   **Mis reservas** y **Perfil**.
6. En **Perfil**, prueba las notificaciones y pulsa **Cerrar sesión**.

## Datos de acceso y demostración

El acceso es simulado: no se comprueban las credenciales ni se conecta ningún
servidor. Basta con pulsar **Iniciar sesión** sin introducir datos.

También se puede pulsar **Crear una cuenta**, completar visualmente el
formulario y usar **Crear cuenta demo** para entrar.

Usuario demo principal:

- Nombre: `Alex Lopez`
- Correo: `alex@example.com`

Los espacios, reservas, comentarios y disponibilidades se cargan desde
`lib/data/services/datos_demo.dart`.

## Criterios visuales y componentes reutilizables

Se acordó una interfaz clara, con fondos claros, superficies blancas,
contraste suficiente, tarjetas con esquinas y elevación sutil, iconos
descriptivos y navegación consistente. Esta paleta está aplicada en el
`ThemeData` global de `lib/main.dart` y se reutiliza en los componentes.

| Rol | Constante Flutter | Color |
|---|---|---|
| Primary | `Color(0xFF2563EB)` | `#2563EB` |
| Secondary | `Color(0xFF0EA5E9)` | `#0EA5E9` |
| Accent/CTA | `Color(0xFFF59E0B)` | `#F59E0B` |
| Background | `Color(0xFFF8FAFC)` | `#F8FAFC` |
| Surface | `Color(0xFFFFFFFF)` | `#FFFFFF` |
| Text | `Color(0xFF0F172A)` | `#0F172A` |

Componentes reutilizables en `lib/ui/core/ui/`:

- `Texto`: estilos comunes, truncado y límites de líneas.
- `Boton`: botones principales y secundarios.
- `BotonVolver`: retroceso común entre pantallas.
- `EspacioTarjeta`: tarjeta del catálogo de espacios.
- `ReservaTarjeta`: tarjeta de reservas con estados y desglose.
- `OpcionAjustes`: fila reutilizable del perfil y ajustes.

## Funcionalidades simuladas, limitaciones y pendientes

### Funcionalidades simuladas

- Inicio de sesión y registro.
- Navegación entre las secciones principales.
- Catálogo y detalle de espacios.
- Galería de imágenes y disponibilidad de siete días.
- Añadir una opinión local de prueba.
- Selección de fecha, horario, asistentes y servicios extra.
- Cálculo visual del precio total.
- Confirmación visual de una solicitud.
- Cambio local de preferencias.
- Cierre de sesión con limpieza de la navegación.

### Limitaciones y aspectos pendientes

- No hay autenticación real ni validación contra un servidor.
- No existe persistencia de usuarios, opiniones, preferencias o reservas.
- Las reservas no se guardan ni modifican los datos demo.
- La disponibilidad es simulada y no bloquea franjas.
- No hay API, base de datos ni sincronización remota.
- La pestaña **Reservar** parte del espacio demo inicial; el flujo desde el
  detalle conserva el espacio seleccionado.
- Las acciones sin lógica de negocio muestran estados demo y no representan
  una operación guardada.