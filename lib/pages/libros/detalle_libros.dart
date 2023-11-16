import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class DetalleLibros extends StatefulWidget {
  @override
  _DetalleLibrosState createState() => _DetalleLibrosState();
}

class _DetalleLibrosState extends State<DetalleLibros> {



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
