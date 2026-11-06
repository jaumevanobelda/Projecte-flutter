---
name: flutter-reservas
description: "Crear y evolucionar una aplicación Flutter de reservas con varias pantallas, arquitectura UI/domain/data, disponibilidad, espacios, usuarios, reservas, servicios extra y datos simulados. Usar al implementar funcionalidades de reservas, pantallas, modelos, repositorios o estilos del proyecto."
argument-hint: "Describe la pantalla o funcionalidad de reservas que quieres implementar"
user-invocable: true
---

# Skill de mockup Flutter de reservas

## Objetivo

Crear un mockup visual navegable de una aplicación de reservas, manteniendo la separación prevista entre presentación, dominio y datos para facilitar futuras fases. El objetivo actual son las pantallas y su recorrido; no se implementan funcionalidades reales.

## Alcance actual

- Crear las pantallas del flujo de acceso, espacios, detalle, nueva reserva, mis reservas y perfil.
- Permitir pasar de pantalla en pantalla con navegación Flutter, botones y acciones visuales.
- Usar datos estáticos, placeholders y estados simulados para enseñar el diseño.
- No implementar autenticación real, persistencia, APIs, disponibilidad real, validación de negocio, creación real de reservas ni cancelaciones.
- No mostrar una acción simulada como si hubiera guardado datos reales; usar mensajes como "Demo", "Próximamente" o estados claramente visuales cuando sea necesario.
- Dejar preparados los puntos de extensión para añadir lógica en una fase posterior.

## Estructura esperada

```text
lib/
├── main.dart
├── ui/
│   ├── core/ui/
│   │   ├── espacio_tarjeta.dart
│   │   └── reserva_tarjeta.dart
│   ├── acceso/ui/
│   │   ├── login_screen.dart
│   │   └── registro_screen.dart
│   ├── espacios/ui/
│   │   ├── espacios_screen.dart
│   │   └── espacio_detalle_screen.dart
│   ├── reservas/ui/
│   │   ├── nueva_reserva_screen.dart
│   │   └── mis_reservas_screen.dart
│   └── perfil/ui/perfil_screen.dart
├── domain/models/
└── data/
    ├── models/
    ├── repositories/
    └── services/
```

Los modelos de dominio previstos son `espacio`, `reserva`, `usuario`, `contacto_local`, `servicio_extra`, `servicio_contratado`, `comentario`, `disponibilidad_dia` y `franja_disponibilidad`. Los DTOs y repositorios deben conservar correspondencia con estas entidades.

## Procedimiento

1. Revisar la estructura y el código existente antes de crear archivos.
2. Identificar las pantallas y el recorrido de navegación solicitado.
3. Crear la composición visual con datos estáticos y widgets reutilizables.
4. Conectar rutas, botones y enlaces para que el mockup pueda recorrerse completo.
5. Representar formularios, calendarios, franjas y confirmaciones como controles visuales sin lógica de negocio.
6. Mostrar estados visuales de ejemplo cuando ayuden a presentar la interfaz.
7. Aplicar el tema visual común y verificar la legibilidad.
8. Formatear, analizar, probar y ejecutar hot reload o hot restart.

## Paleta de diseño

Definir la paleta en el tema global:

| Rol | Color |
|---|---|
| Primary | `#2563EB` |
| Secondary | `#0EA5E9` |
| Accent/CTA | `#F59E0B` |
| Background | `#F8FAFC` |
| Surface | `#FFFFFF` |
| Text | `#0F172A` |

Usar `#F59E0B` para acciones destacadas sin convertirlo en el color principal de toda la interfaz. Mantener fondos claros, superficies blancas y texto oscuro con contraste adecuado.

## Reglas de implementación del mockup

- Priorizar la navegación y la fidelidad visual sobre la lógica de negocio.
- No acceder a APIs, bases de datos ni servicios de autenticación.
- No implementar todavía disponibilidad, reservas persistidas ni cambios de estado de negocio.
- No mezclar DTOs con entidades de dominio en widgets aunque se usen modelos de ejemplo.
- Extraer componentes repetidos y mantener los widgets enfocados.
- Indicar claramente las acciones que son solo demostrativas.
- No añadir dependencias si la funcionalidad puede resolverse con las herramientas existentes.

## Verificación

Usar, cuando estén disponibles, estos pasos:

```text
dart format lib
flutter analyze
flutter test
```

Después de cualquier cambio de código Flutter, realizar un hot reload o hot restart y revisar los errores de ejecución antes de dar la tarea por terminada.
