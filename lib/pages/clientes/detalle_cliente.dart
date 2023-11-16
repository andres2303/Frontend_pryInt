import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../modelos/cliente_modelo.dart';

class DetalleCliente extends StatefulWidget {
  final ClienteModelo cliente;

  DetalleCliente({required this.cliente});

  @override
  _DetalleClienteState createState() => _DetalleClienteState();
}

class _DetalleClienteState extends State<DetalleCliente> {
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
            _buildDetalleRow("Nombre", widget.cliente.persona.nombre),
            _buildDetalleRow("Apellido", widget.cliente.persona.apellidos),
            _buildDetalleRow("DNI", widget.cliente.persona.dni),
            _buildDetalleRow("Telefono", widget.cliente.persona.telefono),
          ],
        ),
      ),
    );
  }

  Widget _buildDetalleRow(String label, String value) {
    return Column(
      children: [
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              label + ":",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 31, 30, 30),
              ),
            ),
            SizedBox(height: 2),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Color.fromARGB(255, 31, 30, 30),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

