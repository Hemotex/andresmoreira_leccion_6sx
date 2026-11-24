
import 'package:flutter/material.dart';

// Punto de entrada de la aplicación.
void main() {
  runApp(const MiAplicacion());
}

// Configuración general de la aplicación.
class MiAplicacion extends StatelessWidget {
  const MiAplicacion({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Empresa XYZ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF206B40),
        ),
        useMaterial3: true,
      ),
      home: const FormularioRegistro(),
    );
  }
}

// Pantalla principal del formulario de registro.
class FormularioRegistro extends StatefulWidget {
  const FormularioRegistro({super.key});

  @override
  State<FormularioRegistro> createState() =>
      _FormularioRegistroState();
}

class _FormularioRegistroState
    extends State<FormularioRegistro> {

  // Color principal de la aplicación.
  final Color verde = const Color(0xFF206B40);

  // Controladores para recuperar los datos ingresados.
  final TextEditingController nombreController =
  TextEditingController();

  final TextEditingController direccionController =
  TextEditingController();

  final TextEditingController fechaController =
  TextEditingController();

  final TextEditingController cargoController =
  TextEditingController();

  // Variables para almacenar los datos registrados.
  String nombre = '';
  String direccion = '';
  String fecha = '';
  String cargo = '';

  // Controla si el panel debe mostrar los datos.
  bool mostrarDatos = false;

  // Identifica el formulario para realizar validaciones.
  final GlobalKey<FormState> formularioKey =
  GlobalKey<FormState>();

  // Método para abrir el calendario.
  Future<void> seleccionarFecha() async {
    final DateTime? fechaSeleccionada = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      helpText: 'Seleccione su fecha de nacimiento',
      cancelText: 'CANCELAR',
      confirmText: 'ACEPTAR',
    );

    // Comprueba que el usuario seleccionó una fecha.
    if (fechaSeleccionada != null && mounted) {

      // Convierte la fecha al formato dd/mm/aaaa.
      String dia =
      fechaSeleccionada.day.toString().padLeft(2, '0');

      String mes =
      fechaSeleccionada.month.toString().padLeft(2, '0');

      String anio = fechaSeleccionada.year.toString();

      setState(() {
        fechaController.text = '$dia/$mes/$anio';
      });
    }
  }

  // Método que valida y captura los datos del formulario.
  void registrarDatos() {

    // Verifica que todos los campos estén completos.
    if (!formularioKey.currentState!.validate()) {
      setState(() {
        mostrarDatos = false;
      });
      return;
    }

    // Oculta el teclado al presionar el botón.
    FocusScope.of(context).unfocus();

    // Actualiza las variables y la interfaz gráfica.
    setState(() {
      nombre = nombreController.text.trim();
      direccion = direccionController.text.trim();
      fecha = fechaController.text.trim();
      cargo = cargoController.text.trim();

      mostrarDatos = true;
    });
  }

  // Libera los controladores al cerrar la pantalla.
  @override
  void dispose() {
    nombreController.dispose();
    direccionController.dispose();
    fechaController.dispose();
    cargoController.dispose();

    super.dispose();
  }

  // Construcción de la interfaz gráfica.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // Encabezado de la aplicación.
      appBar: AppBar(
        title: const Text(
          'Empresa XYZ - Registro',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: verde,
        foregroundColor: Colors.white,
      ),

      // Permite desplazarse si la pantalla es pequeña.
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          // Formulario que contiene los campos.
          child: Form(
            key: formularioKey,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                // Campo de nombre completo.
                crearCampo(
                  'Nombre completo',
                  'Ej.: Ana María Pérez López',
                  nombreController,
                ),

                const SizedBox(height: 16),

                // Campo de dirección.
                crearCampo(
                  'Dirección',
                  'Ej.: Av. 25 de Julio y Pío Jaramillo',
                  direccionController,
                ),

                const SizedBox(height: 16),

                // Campo de fecha de nacimiento.
                crearCampo(
                  'Fecha de nacimiento',
                  'dd/mm/aaaa',
                  fechaController,
                  esFecha: true,
                ),

                const SizedBox(height: 16),

                // Campo de cargo.
                crearCampo(
                  'Cargo',
                  'Ej.: Asistente administrativo',
                  cargoController,
                ),

                const SizedBox(height: 28),

                // Botón que ejecuta el registro.
                ElevatedButton(
                  onPressed: registrarDatos,

                  style: ElevatedButton.styleFrom(
                    backgroundColor: verde,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(
                      double.infinity, 48,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),

                  child: const Text(
                    'MOSTRAR DATOS',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Panel inferior de resultados.
                crearPanelResultados(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Método reutilizable para crear los campos.
  Widget crearCampo(
      String etiqueta,
      String ejemplo,
      TextEditingController controller, {
        bool esFecha = false,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // Etiqueta superior del campo.
        Text(
          etiqueta,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 6),

        // Campo de entrada con validación.
        TextFormField(
          controller: controller,

          // La fecha se selecciona mediante el calendario.
          readOnly: esFecha,

          onTap: esFecha ? seleccionarFecha : null,

          // Actualiza el color del borde al escribir.
          onChanged: (valor) {
            setState(() {});
          },

          // Validación de campos obligatorios.
          validator: (valor) {
            if (valor == null || valor.trim().isEmpty) {
              return 'Este campo es obligatorio';
            }
            return null;
          },

          decoration: InputDecoration(
            hintText: ejemplo,

            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 13,
            ),

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),

            // Icono exclusivo del campo de fecha.
            suffixIcon: esFecha
                ? IconButton(
              icon: const Icon(Icons.calendar_month),
              onPressed: seleccionarFecha,
            )
                : null,

            // Borde normal o verde si contiene datos.
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: controller.text.trim().isNotEmpty
                    ? verde
                    : Colors.grey.shade400,
              ),
            ),

            // Borde al seleccionar el campo.
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: verde,
                width: 1.5,
              ),
            ),

            // Borde rojo cuando existe un error.
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),

            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Método encargado de mostrar el panel de resultados.
  Widget crearPanelResultados() {
    return Container(
      padding: const EdgeInsets.all(16),

      constraints: const BoxConstraints(
        minHeight: 110,
      ),

      decoration: BoxDecoration(
        color: mostrarDatos
            ? const Color(0xFFEAF4ED)
            : const Color(0xFFF5F5F2),

        borderRadius: BorderRadius.circular(8),

        border: Border.all(
          color: mostrarDatos
              ? verde
              : Colors.grey.shade300,
        ),
      ),

      // Cambia el contenido según el estado del registro.
      child: mostrarDatos
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            'DATOS REGISTRADOS',
            style: TextStyle(
              color: verde,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 8),

          Text('Nombre: $nombre'),
          const SizedBox(height: 4),

          Text('Dirección: $direccion'),
          const SizedBox(height: 4),

          Text('Nacimiento: $fecha'),
          const SizedBox(height: 4),

          Text('Cargo: $cargo'),
        ],
      )

      // Mensaje que aparece antes del registro.
          : const Center(
        child: Text(
          'Aquí se mostrarán los datos\n'
              'al presionar el botón.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
