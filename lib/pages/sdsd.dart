import 'package:flutter/material.dart';

class ModalAgregar extends StatefulWidget {
  @override
  _ModalAgregarState createState() => _ModalAgregarState();
}

class _ModalAgregarState extends State<ModalAgregar> {
  bool _checkBoxValue1 = false;
  bool _checkBoxValue2 = false;

    int _selectedOption = 1;

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
              "Agregar Trabajador",
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
                labelText: 'Nombre',
                hintText: 'Ingrese el Nombre',
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
                labelText: 'Apellidos',
                hintText: 'Ingrese los apellidos',
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
                labelText: 'Telefono',
                hintText: 'Ingrese el telefono',
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
                labelText: 'Correo',
                hintText: 'Ingrese el correo',
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Estado:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Color.fromARGB(255, 31, 30, 30),
                  ),
                ),
                SizedBox(
                    width:
                        10), // Añade un espacio entre el texto y el DropdownButton
                Expanded(
                  child: DropdownButton<int>(
                    value: _selectedOption,
                    onChanged: (int? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedOption = newValue;
                        });
                      }
                    },
                    items: [
                      DropdownMenuItem<int>(
                        value: 1,
                        child: Text("Opción 1"),
                      ),
                      DropdownMenuItem<int>(
                        value: 2,
                        child: Text("Opción 2"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Estado:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Color.fromARGB(255, 31, 30, 30),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Checkbox(
                      value: _checkBoxValue1,
                      onChanged: (bool? value) {
                        if (value != null) {
                          setState(() {
                            _checkBoxValue1 = value;
                            _checkBoxValue2 = !value;
                          });
                        }
                      },
                    ),
                    Text("Activo"),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Checkbox(
                      value: _checkBoxValue2,
                      onChanged: (bool? value) {
                        if (value != null) {
                          setState(() {
                            _checkBoxValue2 = value;
                            _checkBoxValue1 = !value;
                          });
                        }
                      },
                    ),
                    Text("Inactivo"),
                  ],
                ),
              ],
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
                labelText: 'Contraseña',
                hintText: 'Ingrese la contraseña',
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceEvenly, // Alineación espaciada entre los botones
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Lógica para el botón "Cancelar" aquí
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Container(
                    width: 80, // Ancho del botón "Cancelar"
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Center(
                      child: Text(
                        "Cancelar",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 9, 80, 128),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Container(
                    width: 80, // Ancho del botón "Guardar"
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Center(
                      child: Text(
                        "Agregar",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
