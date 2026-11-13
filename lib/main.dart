import 'package:entrega_1/data/repositories/espacios_repository.dart';
import 'package:entrega_1/data/services/datos_demo.dart';
import 'package:entrega_1/data/services/datos_simulados_service.dart';
import 'package:entrega_1/domain/models/espacio.dart';
import 'package:entrega_1/domain/models/usuario.dart';
import 'package:entrega_1/ui/acceso/ui/registro_screen.dart';
import 'package:entrega_1/ui/espacios/ui/espacios_screen.dart';
import 'package:entrega_1/ui/perfil/ui/perfil_screen.dart';
import 'package:entrega_1/ui/reservas/ui/mis_reservas_screen.dart';
import 'package:entrega_1/ui/reservas/ui/nueva_reserva_screen.dart';
import 'package:flutter/material.dart';

import 'ui/acceso/ui/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _sesionIniciada = false;
  var _mostrarRegistro = false;
  final _usuario = const Usuario(
    id: 'u1',
    nombre: 'Alex Lopez',
    correo: 'alex@example.com',
  );

  void _iniciarSesion() {
    setState(() {
      _sesionIniciada = true;
      _mostrarRegistro = false;
    });
  }

  void _cerrarSesion() {
    setState(() {
      _sesionIniciada = false;
      _mostrarRegistro = false;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reservas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2563EB))
            .copyWith(
              primary: const Color(0xFF2563EB),
              onPrimary: const Color(0xFFFFFFFF),
              secondary: const Color(0xFF0EA5E9),
              onSecondary: const Color(0xFF0F172A),
              tertiary: const Color(0xFFF59E0B),
              onTertiary: const Color(0xFF0F172A),
              surface: const Color(0xFFFFFFFF),
              onSurface: const Color(0xFF0F172A),
            ),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        cardColor: const Color(0xFFFFFFFF),
        useMaterial3: true,
      ),
      home: _sesionIniciada
          ? _PrincipalScreen(usuario: _usuario, onCerrarSesion: _cerrarSesion)
          : _mostrarRegistro
          ? Scaffold(
              body: RegistroScreen(
                onRegistrado: _iniciarSesion,
                onVolver: () => setState(() => _mostrarRegistro = false),
              ),
            )
          : Scaffold(
              body: LoginScreen(
                onLogin: _iniciarSesion,
                onRegistro: () => setState(() => _mostrarRegistro = true),
              ),
            ),
    );
  }
}

class _PrincipalScreen extends StatefulWidget {
  const _PrincipalScreen({required this.usuario, required this.onCerrarSesion});

  final Usuario usuario;
  final VoidCallback onCerrarSesion;

  @override
  State<_PrincipalScreen> createState() => _PrincipalScreenState();
}

class _PrincipalScreenState extends State<_PrincipalScreen> {
  var _indiceSeleccionado = 0;
  late final Espacio _espacioInicial;

  @override
  void initState() {
    super.initState();
    final service = DatosSimuladosService(
      espacios: espaciosDemo,
      reservas: reservasDemo,
      usuarios: usuariosDemo,
      comentarios: comentariosDemo,
      disponibilidad: disponibilidadDemo,
    );
    final espacio = EspaciosRepository(service: service)
        .obtenerPorId(espaciosDemo.first.id);
    if (espacio == null) {
      throw StateError('No existe el espacio demo inicial');
    }
    _espacioInicial = espacio;
  }

  @override
  Widget build(BuildContext context) {
    final pantallas = [
      const EspaciosScreen(),
      NuevaReservaScreen(espacio: _espacioInicial),
      const MisReservasScreen(),
      PerfilScreen(
        usuario: widget.usuario,
        onCerrarSesion: widget.onCerrarSesion,
      ),
    ];

    return Scaffold(
      body: IndexedStack(index: _indiceSeleccionado, children: pantallas),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indiceSeleccionado,
        onDestinationSelected: (indice) {
          setState(() => _indiceSeleccionado = indice);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.meeting_room_outlined),
            selectedIcon: Icon(Icons.meeting_room),
            label: 'Espacios',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_box_outlined),
            selectedIcon: Icon(Icons.add_box),
            label: 'Reservar',
          ),
          NavigationDestination(
            icon: Icon(Icons.event_note_outlined),
            selectedIcon: Icon(Icons.event_note),
            label: 'Mis reservas',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

// Boton(texto: "Iniciar sesión",tipo: TipoBoton.principal,),
//             Boton(texto: "Iniciar sesión",tipo: TipoBoton.secundario,)
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body:
          // LoginScreen
          Center(
            child: Column(
              mainAxisAlignment: .center,
              children: [
                // LoginScreen()
              ],
            ),
          ),
      // Center(

      //   child: Column(

      //     mainAxisAlignment: .center,
      //     children: [
      //       const Text('You have pushed the button this many times:'),
      //       Text(
      //         '$_counter',
      //         style: Theme.of(context).textTheme.headlineMedium,
      //       ),
      //     ],
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
