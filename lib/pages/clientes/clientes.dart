import 'package:flutter/material.dart';
import '../components/drawer.dart';
import '../components/botones_navegacion.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../clientes/agregar_cliente.dart';
import '../clientes/editar_cliente.dart';
import '../clientes/detalle_cliente.dart';
import '../modelos/cliente_modelo.dart';

class Clientes extends StatefulWidget {
  @override
  _ClientesState createState() => _ClientesState();
}

class _ClientesState extends State<Clientes> {
  List<ClienteModelo> _clientes = [];
  TextEditingController dniController = TextEditingController();

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

  Future<List<ClienteModelo>> fetchClientesModelo() async {
    final response =
        await http.get(Uri.parse('http://localhost:8080/api/clientes/listar'));

    if (response.statusCode == 200) {
      return clienteModeloFromJson(response.body);
    } else {
      throw Exception('Failed to load clientes');
    }
  }

  Future<void> buscarPorDNI() async {
    final dni = dniController.text;

    if (dni.isNotEmpty) {
      try {
        final response = await http.get(
          Uri.parse('http://localhost:8080/api/clientes/buscarPorDNI/$dni'),
        );

        if (response.statusCode == 200) {
          setState(() {
            _clientes = clienteModeloFromJson(response.body);
          });
        } else {
          throw Exception('Failed to load clientes');
        }
      } catch (e) {
        print('Error: $e');
      }
    }
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
                controller: dniController,
                keyboardType: TextInputType.number,
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
                  labelText: 'Número del DNI',
                  hintText: 'Ingrese el número del DNI',
                ),
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  buscarPorDNI();
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 250, 205, 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 8.0),
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
                    color: Colors.white,
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      title: Text(
                        'DNI: ${cliente.persona.dni}',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${cliente.persona.apellidos} ${cliente.persona.nombre}',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.visibility, color: Colors.black),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  // Aquí debes pasar el cliente específico seleccionado
                                  return DetalleCliente(cliente: cliente);
                                },
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return EditarCliente();
                                },
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
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
