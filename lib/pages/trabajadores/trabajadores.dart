import 'package:flutter/material.dart';
import '../components/drawer.dart';
import '../components/botones_navegacion.dart';
import '../trabajadores/agre_traba.dart';
import '../trabajadores/edi_traba.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

class Trabajadoress {
  final String title;
  final String subtitle;

  Trabajadoress({required this.title, required this.subtitle});
}

List<Trabajadoress> libros = [
  Trabajadoress(title: 'Xxxx', subtitle: 'Xxxxx'),
];

class Persona {
  final String nombre;
  final String dni;
  final String apellidos;
  final String codigo;

  Persona({
    required this.nombre,
    required this.apellidos,
    required this.dni,
    required this.codigo,
  });
}

class TrabajadorModelo {
  final int idTrabajador;
  final String nombrePersona;
  final String apellidosPersona;
  final String codigoTrabajador;

  TrabajadorModelo(
      {required this.idTrabajador,
      required this.nombrePersona,
      required this.apellidosPersona,
      required this.codigoTrabajador});

  factory TrabajadorModelo.fromJson(Map<String, dynamic> json) {
    print(json);
    return TrabajadorModelo(
      idTrabajador: json['idTrabajador'] as int,
      nombrePersona: json['persona']['nombre'] as String,
      apellidosPersona: json['persona']['apellidos'] as String,
      codigoTrabajador: json['persona']['codigo'] as String,
    );
  }
}

List<TrabajadorModelo> clienteModeloFromJson(String str) {
  final jsonData = json.decode(str);
  return List<TrabajadorModelo>.from(
      jsonData.map((x) => TrabajadorModelo.fromJson(x)));
}

Future<List<TrabajadorModelo>> fetchClientesModelo() async {
  final response =
      await http.get(Uri.parse('http://localhost:8080/api/trabajadores/listar'));

  if (response.statusCode == 200) {
    // Parsear JSON
    return clienteModeloFromJson(response.body);
  } else {
    // Manejar error
    throw Exception('Failed to load clientes');
  }
}

class Trabajadores extends StatelessWidget{

    int _selectedOption = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Image.asset(
            'assets/logo.png',
            height: 40.0,
          ),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.grey, Colors.white],
            ),
          ),
        ),
      ),
      drawer: Draw(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Trabajadores',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      // Agrega la lógica de refresco aquí
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: const Color.fromARGB(255, 40, 42, 43),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: const Color.fromARGB(255, 40, 42, 43),
                    ),
                  ),
                  labelText: 'Codigo del Trabajador',
                  hintText: 'Ingrese el codigo del Trabajador',
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 250, 205, 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                      vertical:
                          8.0), // Ajusta el valor vertical para cambiar la altura del botón
                  child: Center(
                    child: Text(
                      "Buscar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return ModalAgregar(); // Llama al widget del modal
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 53, 75, 245),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Container(
                  width: double.infinity, // Ancho máximo
                  padding: EdgeInsets.symmetric(
                      vertical:
                          8.0), // Ajusta el valor vertical para cambiar la altura del botón
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
              SizedBox(height: 16),
              Column(
                children: libros.map((libro) {
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    color: Colors.white, // Cambiamos el color de fondo a blanco
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      title: Text(
                        libro.title,
                        style: TextStyle(
                          color: Colors
                              .black, // Cambiamos el color del título a negro
                          fontWeight:
                              FontWeight.bold, // Hacemos el título en negrita
                        ),
                      ),
                      subtitle: Text(
                        libro.subtitle,
                        style: TextStyle(
                          color: Colors
                              .black, // Cambiamos el color del subtítulo a negro
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit,
                                color: Colors.blue), // Icono de editar azul
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return ModalEditarTraba(); // Llama al widget del modal
                                },
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete,
                                color: Colors.red), // Icono de eliminar rojo
                            onPressed: () {
                              // Lógica para borrar aquí
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BotonesNavegacion(),
    );
  }
}
