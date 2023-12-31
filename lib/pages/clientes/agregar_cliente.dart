import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../modelos/cliente_modelo.dart';

class AgregarCliente extends StatefulWidget {
  @override
  _AgregarClienteState createState() => _AgregarClienteState();
}

class _AgregarClienteState extends State<AgregarCliente> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidosController = TextEditingController();
  final TextEditingController dniController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();

  int? idPersona; // Nueva variable para almacenar el ID de la persona

  Future<void> agregarPersonaYCliente() async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:8080/api/personas/crear'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'nombre': nombreController.text,
          'apellidos': apellidosController.text,
          'dni': dniController.text,
          'telefono': telefonoController.text,
        }),
      );

      print('Respuesta del servidor al agregar persona: ${response.body}');

      if (response.statusCode == 201) {
        setState(() {
          idPersona = jsonDecode(response.body)['idPersona'];
        });
        print('ID de la persona: $idPersona');

        if (idPersona != null) {
          ClienteModelo nuevoCliente = ClienteModelo(
            idCliente: idPersona.toString(),
            persona: Persona(
              nombre: nombreController.text,
              apellidos: apellidosController.text,
              dni: dniController.text,
              telefono: telefonoController.text,
            ),
            estado: true,
          );

          final clienteResponse = await http.post(
            Uri.parse('http://localhost:8080/api/clientes/crear'),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode(nuevoCliente.toJson()),
          );

          print(
              'Respuesta del servidor al agregar cliente: ${clienteResponse.body}');

          if (clienteResponse.statusCode == 201) {
            print('Cliente agregado exitosamente');
          } else {
            print('Error al agregar cliente: ${clienteResponse.body}');
            throw Exception('Error al agregar cliente');
          }
        } else {
          print('Error: No se obtuvo el ID de la persona');
        }
      } else {
        print('Error al agregar persona: ${response.body}');
        throw Exception('Error al agregar persona');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error al agregar persona y cliente');
    }
  }

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
              "Agregar Cliente",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 31, 30, 30),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: nombreController,
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
                labelText: 'Nombre Completo',
                hintText: 'Ingrese los nombres',
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: apellidosController,
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
                labelText: 'Apellido Completo',
                hintText: 'Ingrese los apellidos',
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: dniController,
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
                labelText: 'DNI',
                hintText: 'Ingrese el N° DNI',
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: telefonoController,
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
                hintText: 'Ingrese el n° telefonico',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                agregarPersonaYCliente();
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 53, 75, 245),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Container(
                width: double.infinity,
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
      ),
    );
  }
}
