import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../modelos/cliente_modelo.dart';

// Desde el api service

List<ClienteModelo> clienteModeloFromJson(String str) {
  final jsonData = json.decode(str);
  return List<ClienteModelo>.from(
      jsonData.map((x) => ClienteModelo.fromJson(x)));
}

Future<List<ClienteModelo>> fetchClientesModelo() async {
  final response =
      await http.get(Uri.parse('http://localhost:8080/api/clientes/listar'));

  if (response.statusCode == 200) {
    // Parsear JSON
    return clienteModeloFromJson(response.body);
  } else {
    // Manejar error
    throw Exception('Failed to load clientes');
  }
}

class DetalleCliente extends StatefulWidget {
  @override
  _DetalleClienteState createState() => _DetalleClienteState();
}

class _DetalleClienteState extends State<DetalleCliente> {
 List<ClienteModelo> _clientess = [];

  @override
  void initState() {
    super.initState();
    fetchClientesModelo().then((clientes) {
      setState(() {
        _clientess = clientes;
      });
    });
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
              "Detalle Cliente",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 31, 30, 30),
              ),
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Nombre:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 31, 30, 30),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'DNI:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Color.fromARGB(255, 31, 30, 30),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Apellido:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 31, 30, 30),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Estado:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Color.fromARGB(255, 31, 30, 30),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "DNI:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 31, 30, 30),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Estado:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Color.fromARGB(255, 31, 30, 30),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Telefono:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 31, 30, 30),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Estado:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Color.fromARGB(255, 31, 30, 30),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
