import 'package:flutter/material.dart';
import '../components/drawer.dart';
import '../components/botones_navegacion.dart';
import '../clientes/clientes.dart';
import 'dart:convert';
import '../ventas/ventas2.dart';
import 'package:http/http.dart' as http;
import '../modelos/ventas_modelo.dart';

class VentaPrin extends StatefulWidget {
  @override
  _VentaPrinState createState() => _VentaPrinState();
}

class _VentaPrinState extends State<VentaPrin> {
  List<LibroData> libros = [
    LibroData(title: 'Xxxx', subtitle: 'Xxxx'),
  ];

  List<ClienteModel> _clientes = [];
  List<VentaModel> ventas = [];
  TextEditingController dniController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchVentas();
  }

  Future<void> _fetchVentas() async {
    final response =
        await http.get(Uri.parse('http://localhost:8080/api/ventas/listar'));

    if (response.statusCode == 200) {
      // La solicitud fue exitosa, analiza el JSON
      List<dynamic> jsonData = json.decode(response.body);

      setState(() {
        ventas = jsonData.map((json) => VentaModel.fromJson(json)).toList();
      });
    } else {
      // Si la solicitud no fue exitosa, muestra un mensaje de error
      print(
          'Error al cargar las ventas. Código de estado: ${response.statusCode}');
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
                    'Ventas',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
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
                        labelText: 'DNI',
                        hintText: 'Ingrese N° DNI del Cliente',
                      ),
                    ),
                  ),
                  SizedBox(
                      width: 8), // Espacio entre el TextFormField y los iconos
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      buscarPorDNI();
                    },
                  ),
                  InkWell(
                    onTap: () {
                      dniController.clear();
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, // Forma de círculo
                        color: Colors
                            .transparent, // Fondo transparente por defecto
                      ),
                      child: Center(
                        child: Icon(
                          Icons.cleaning_services,
                          color: Colors.black, // Color gris por defecto
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {},
                  ),
                  /*SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () {
                      // Agrega la lógica del calendario aquí
                    },
                  ),*/
                ],
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Venta2(),
                  ));
                },
                style: ElevatedButton.styleFrom(
                  primary:
                      Color.fromARGB(255, 53, 75, 245), // Color de fondo negro
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
                      "Vender",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Column(
                children: ventas.map((venta) {
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
                         '${venta.cliente.persona.apellidos}, ${venta.cliente.persona.nombre}',
                        style: TextStyle(
                          color: Colors
                              .black, // Cambiamos el color del título a negro
                          fontWeight:
                              FontWeight.bold, // Hacemos el título en negrita
                        ),
                      ),
                      subtitle: Text(
                        'DNI: ${venta.cliente.persona.dni}',
                        style: TextStyle(
                          color: Colors
                              .black, // Cambiamos el color del subtítulo a negro
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.visibility,
                                color: Colors.black), // Icono de editar negro
                            onPressed: () {
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              // Agrega la lógica para editar la venta
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              // Agrega la lógica para eliminar la venta
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
