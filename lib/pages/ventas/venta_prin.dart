import 'package:flutter/material.dart';
import '../components/drawer.dart';
import '../components/botones_navegacion.dart';
import 'dart:convert';
import '../ventas/ventas2.dart';
import 'package:http/http.dart' as http;
import '../modelos/ventas_modelo.dart';
import '../ventas/detalle_venta.dart';
import 'package:flutter/services.dart';

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
  final countController = TextEditingController(text: '0/8');

  @override
  void initState() {
    super.initState();
    _fetchVentas();
    dniController.addListener(updateCount);
  }

  void updateCount() {
    setState(() {
      countController.text = '${dniController.text.length}/8';
    });
  }

  @override
  void dispose() {
    dniController.dispose();
    super.dispose();
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

  void actualizarVentas() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:8080/api/ventas/listar'),
      );

      if (response.statusCode == 200) {
        setState(() {
          _clientes.clear(); // Limpiar la lista de clientes
          ventas = (json.decode(response.body) as List)
              .map((json) => VentaModel.fromJson(json))
              .toList();
        });
      } else {
        throw Exception('Failed to load ventas');
      }
    } catch (e) {
      print('Error: $e');
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
                  // Primera columna para TextFormField y su contador
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment
                          .center, // Centra los elementos verticalmente
                      children: [
                        TextFormField(
                          controller: dniController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(8),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
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
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                countController.text,
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  Align(
                    alignment:
                        Alignment.topCenter, // Alineación en la parte superior
                    child: Row(
                      mainAxisSize: MainAxisSize
                          .min, // Importante para mantener el tamaño adecuado de la fila
                      mainAxisAlignment: MainAxisAlignment
                          .center, // Alinea los íconos horizontalmente
                      children: [
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
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.cleaning_services,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.refresh),
                          onPressed: () {
                            dniController.clear();
                            actualizarVentas();
                          },
                        ),
                      ],
                    ),
                  ),
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
                children: (_clientes.isNotEmpty
                    ? _clientes.map((cliente) {
                        return Card(
                          elevation: 4,
                          margin:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          color: Colors.white,
                          child: ListTile(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16),
                            title: Text(
                              '${cliente.persona.apellidos}, ${cliente.persona.nombre}',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'DNI: ${cliente.persona.dni}',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.visibility,
                                      color: Colors.black),
                                  onPressed: () {
                                    // Agrega la lógica para visualizar la venta
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
                      }).toList()
                    : ventas.map((venta) {
                        return Card(
                          elevation: 4,
                          margin:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          color: Colors.white,
                          child: ListTile(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16),
                            title: Text(
                              '${venta.cliente.persona.apellidos}, ${venta.cliente.persona.nombre}',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'DNI: ${venta.cliente.persona.dni}',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.visibility,
                                      color: Colors.black),
                                  onPressed: () {
                                    DetalleVenta();
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
                      }).toList()),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BotonesNavegacion(),
    );
  }
}
