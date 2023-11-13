import 'package:flutter/material.dart';
import '../components/drawer.dart';
import '../components/botones_navegacion.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../clientes/agregar_cliente.dart';
import '../clientes/editar_cliente.dart';
import '../clientes/detalle_cliente.dart';
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

class Clientes extends StatefulWidget {
  @override
  _ClientesState createState() => _ClientesState();
}

class _ClientesState extends State<Clientes> {
  List<ClienteModelo> _clientes = [];

  @override
  void initState() {
    super.initState();
    fetchClientesModelo().then((clientes) {
      setState(() {
        _clientes = clientes;
      });
    });
  }

  void actualizarClientes() {
    fetchClientesModelo().then((clientes) {
      setState(() {
        _clientes = clientes;
      });
    });
  }

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
                    'Clientes',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      actualizarClientes();
                    },
                  )
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
                  labelText: 'Nombre del DNI',
                  hintText: 'Ingrese el numero del DNI',
                ),
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  // Agrega la lógica para el botón aquí
                },
                style: ElevatedButton.styleFrom(
                  primary:
                      Color.fromARGB(255, 250, 205, 5), // Color de fondo negro
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
                      "Buscar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 9),
              ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return AgregarCliente(); // Llama al widget del modal
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
                children: _clientes.map((cliente) {
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
                        'DNI: ${cliente.dniPersona}',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${cliente.apellidosPersona} ${cliente.nombrePersona}',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.visibility,
                                color: Colors.black), // Icono de editar negro
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return DetalleCliente(); // Llama al widget del modal
                                },
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.edit,
                                color: Colors.blue), // Icono de editar azul
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return EditarCliente(); // Llama al widget del modal
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
