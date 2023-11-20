import 'package:flutter/material.dart';
import '../modelos/libros_modelo.dart';

class DetalleVenta extends StatefulWidget {
  @override
  _DetalleVentaState createState() => _DetalleVentaState();
}

class _DetalleVentaState extends State<DetalleVenta> {
  final TextEditingController codigoController = TextEditingController();
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController nPaginasController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController precioVentaController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _guardarCambios() {
    // Aquí puedes implementar la lógica para guardar los cambios
    if (_formKey.currentState?.validate() ?? false) {
      // Validación exitosa, guarda los cambios
      // Accede a los valores de los controladores para obtener la información
      String codigo = codigoController.text;
      String titulo = tituloController.text;
      // ... (agrega el resto de los campos)

      // Implementa la lógica para guardar los cambios según tus necesidades
      // Por ejemplo, puedes enviar los datos al servidor o actualizar tu modelo

      // Una vez que hayas guardado los cambios, puedes realizar acciones adicionales
      // como mostrar un mensaje de éxito, navegar a otra pantalla, etc.
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 10),
              Text(
                "Editar libro",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 31, 30, 30),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: codigoController,
                // ... (otras propiedades)
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: tituloController,
                // ... (otras propiedades)
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: nPaginasController,
                // ... (otras propiedades)
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: stockController,
                // ... (otras propiedades)
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: precioVentaController,
                style: TextStyle(fontSize: 14),
                // ... (otras propiedades)
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _guardarCambios,
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 18, 94, 25),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Center(
                    child: Text(
                      "Guardar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
