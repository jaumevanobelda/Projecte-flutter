---
name: "Proyecto de reservas Flutter"
description: "Usar al crear o modificar una aplicación Flutter de reservas, sus pantallas, modelos, DTOs, repositorios, datos simulados y estilos visuales."
applyTo: "lib/**/*.dart"
---

# Proyecto de reservas Flutter

## Alcance actual: mockup navegable

- En esta fase el proyecto es únicamente un mockup visual navegable.
- Implementar todas las pantallas necesarias y permitir pasar de una pantalla a otra mediante botones, enlaces y rutas.
- Usar datos estáticos o textos de ejemplo solo para representar la interfaz.
- No implementar todavía autenticación real, persistencia, llamadas a API, lógica de disponibilidad, creación/cancelación de reservas ni validaciones de negocio.
- Las acciones que todavía no tengan funcionalidad pueden mostrar la siguiente pantalla, un estado visual simulado o un mensaje indicativo, pero no deben fingir que se ha guardado información real.
- Mantener una estructura preparada para añadir la lógica en fases posteriores sin introducirla ahora.

## Arquitectura y estructura

- Usar como referencia complementaria para la estructura del proyecto la guía [Proyecto integrador: entrega 1](https://jovisal1.github.io/ApuntesPMDM/proyecto-integrador/entrega-1/), adaptándola a las convenciones y al alcance definidos en estas instrucciones.
- Mantener una separación clara entre `ui`, `domain` y `data`.
- Organizar las pantallas por funcionalidad:
  - `lib/ui/acceso/ui/`: login y registro.
  - `lib/ui/espacios/ui/`: listado y detalle de espacios.
  - `lib/ui/reservas/ui/`: nueva reserva y mis reservas.
  - `lib/ui/perfil/ui/`: perfil del usuario.
- Colocar componentes reutilizables en `lib/ui/core/ui/`.
- Definir entidades de negocio en `lib/domain/models/`.
- Definir DTOs, repositorios y servicios simulados en `lib/data/`.
- Mantener el mapeo DTO-entidad fuera de las pantallas.
- Usar datos simulados de forma determinista y mediante repositorios, evitando acceder directamente a ellos desde la UI.

## Convenciones de código

- Usar nombres en `snake_case` para archivos y nombres descriptivos en español para las entidades del dominio.
- Preferir widgets pequeños, reutilizables y con responsabilidades únicas.
- Mantener las pantallas centradas en composición y estado de UI; extraer tarjetas, formularios y secciones repetidas.
- Modelar estados vacíos, carga y error de forma explícita, sin ocultar errores con valores por defecto silenciosos.
- Validar los formularios y mostrar mensajes claros al usuario.
- Evitar duplicar lógica de reservas, disponibilidad o conversión de modelos.
- Antes de añadir una abstracción, buscar helpers, modelos y patrones ya existentes en el proyecto.

## Flujo visual de reservas

- Representar visualmente la asociación de una reserva con un usuario, un espacio, una fecha, una franja horaria y servicios contratados.
- Mostrar pantallas y controles de disponibilidad como elementos de demostración, sin comprobar datos reales.
- Mantener la selección de fecha, franja y servicios claramente visible en el recorrido del mockup.
- Conectar las pantallas de confirmación, detalle y listado con navegación simulada.

## Diseño visual

Usar esta paleta de forma consistente mediante el `ThemeData` de la aplicación y sus componentes:

- Primary: `#2563EB`.
- Secondary: `#0EA5E9`.
- Accent/CTA: `#F59E0B`.
- Background: `#F8FAFC`.
- Surface: `#FFFFFF`.
- Text: `#0F172A`.

- Usar el color accent principalmente para acciones importantes, confirmaciones y llamadas a la acción.
- Garantizar contraste suficiente entre texto, fondos, botones y estados.
- Preferir superficies blancas, bordes y elevaciones sutiles sobre fondos claros.
- No introducir colores nuevos sin justificar su uso como estado semántico (éxito, advertencia o error).

## Validación

- Ejecutar `dart format` sobre los archivos Dart modificados.
- Ejecutar análisis estático con `flutter analyze` o el comando equivalente configurado.
- Ejecutar las pruebas relevantes cuando existan.
- Después de cambios de código Flutter, realizar un hot reload o hot restart y comprobar que no aparecen errores de ejecución.
