import 'package:flutter/material.dart';

class DetalleVenta extends StatefulWidget {
  @override
  _DetalleVentaState createState() => _DetalleVentaState();
}

class _DetalleVentaState extends State<DetalleVenta> {
  String? seleccionarCate;
  String? seleccionarEdito;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 50, 53, 56),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 50, 53, 56),
                  ),
                ),
                labelText: 'Codigo',
                hintText: 'Ingrese el codigo',
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 50, 53, 56),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 50, 53, 56),
                  ),
                ),
                labelText: 'Titulo',
                hintText: 'Ingrese el titulo',
              ),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              isExpanded: true,
              value: seleccionarCate, // Valor inicial es null o vacío
              onChanged: (String? newValue) {
                setState(() {
                  seleccionarCate = newValue;
                });
              },
              items: <String>['Deporte', 'Manga', 'Cocina']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              isExpanded: true,
              value: seleccionarEdito, // Valor inicial es null o vacío
              onChanged: (String? newValue) {
                setState(() {
                  seleccionarEdito = newValue;
                });
              },
              items: <String>['Chipre', 'Universal', 'Son']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 50, 53, 56),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 50, 53, 56),
                  ),
                ),
                labelText: 'N° Paginas',
                hintText: 'Ingrese el n° paginas',
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 50, 53, 56),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 50, 53, 56),
                  ),
                ),
                labelText: 'Stock',
                hintText: 'Ingrese el stock',
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              style:
                  TextStyle(fontSize: 14), // Reducimos el tamaño de la fuente
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8), // Reducimos el espacio interno
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      4.0), // Reducimos el radio de los bordes
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 50, 53, 56),
                    width: 1, // Reducimos el grosor del borde
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 50, 53, 56),
                    width: 1,
                  ),
                ),
                labelText: 'Precio Venta',
                hintText: 'Ingrese el precio de venta',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Agrega la lógica para el botón aquí
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(
                    255, 18, 94, 25), // Cambiamos el color al valor hexadecimal
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
    );
  }
}

