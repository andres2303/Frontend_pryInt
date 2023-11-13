import 'package:flutter/material.dart';

import '../pages/components/botones_navegacion.dart';
import '../pages/components/drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../pages/clientes/detalle_cliente.dart';

class LibroModelo {
  final int id;
  final String titulo;
  final int stock;

  LibroModelo({required this.id, required this.titulo, required this.stock});

  factory LibroModelo.fromJson(Map<String, dynamic> json) {
    int id = json['id'] ?? 0;
    String titulo = json['titulo'] ?? '';
    int stock = json['stock'] ?? 0;

    return LibroModelo(
      id: id,
      titulo: titulo,
      stock: stock,
    );
  }
}

// Desde el api service

List<LibroModelo> libroModeloFromJson(String str) {
  final jsonData = json.decode(str);
  return List<LibroModelo>.from(jsonData.map((x) => LibroModelo.fromJson(x)));
}

Future<List<LibroModelo>> fetchLibrosModelo() async {
  final response =
      await http.get(Uri.parse('http://localhost:8080/api/libros/listar'));

  if (response.statusCode == 200) {
    // Parsear JSON
    return libroModeloFromJson(response.body);
  } else {
    // Manejar error
    throw Exception('Failed to load libros');
  }
}

class LibroService {
  Future<void> deleteLibro(int id) async {
    final response = await http
        .delete(Uri.parse('http://localhost:8080/api/libros/eliminar/$id'));

    if (response.statusCode == 204) {
      // El libro se eliminó correctamente
      print('Libro eliminado');
    } else {
      // Ocurrió un error al eliminar el libro
      print('Error al eliminar el libro');
    }
  }
}

class Libro extends StatefulWidget {
  @override
  _LibroState createState() => _LibroState();
}

class LibroData {
  final int id;
  final String title;
  final String subtitle;

  LibroData({required this.id, required this.title, required this.subtitle});
}

class _LibroState extends State<Libro> {
  String? selectedCategory = 'Comedia';
  String? seleccionarCate;
  String? seleccionarEdito;

  List<LibroData> libros = [];
  final LibroService libroService = LibroService();

  @override
  void initState() {
    super.initState();
    fetchLibrosModelo().then((fetchedLibros) {
      setState(() {
        libros = fetchedLibros.map((libroModelo) {
          return LibroData(
            id: libroModelo.id,
            title: libroModelo.titulo,
            subtitle: 'Stock:  ${libroModelo.stock}',
          );
        }).toList();
      });
    });
  }

  Future<void> actualizarLibros() async {
    final fetchedLibros = await fetchLibrosModelo();
    setState(() {
      libros = fetchedLibros.map((libroModelo) {
        return LibroData(
          id: libroModelo.id,
          title: libroModelo.titulo,
          subtitle: 'Stock: ${libroModelo.stock}',
        );
      }).toList();
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
                    'Libros',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                          actualizarLibros();
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
                  labelText: 'Nombre de Libro',
                  hintText: 'Ingrese el nombre del Libro',
                ),
              ),
              SizedBox(height: 16),
              DropdownButton<String>(
                isExpanded:
                    true, // Para que el menú se expanda al ancho del contenedor
                value: selectedCategory,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCategory = newValue;
                  });
                },
                items: <String>['Ficción', 'Romance', 'Comedia']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
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
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SizedBox(height: 10),
                              Text(
                                "Agregar libro",
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
                                      color:
                                          const Color.fromARGB(255, 50, 53, 56),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                      color:
                                          const Color.fromARGB(255, 50, 53, 56),
                                    ),
                                  ),
                                  labelText: 'Codigo',
                                  hintText: 'Ingrese el codigo',
                                ),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(16.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                      color:
                                          const Color.fromARGB(255, 50, 53, 56),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                      color:
                                          const Color.fromARGB(255, 50, 53, 56),
                                    ),
                                  ),
                                  labelText: 'Titulo',
                                  hintText: 'Ingrese el titulo',
                                ),
                              ),
                              SizedBox(height: 10),
                              DropdownButton<String>(
                                isExpanded: true,
                                value:
                                    seleccionarCate, // Valor inicial es null o vacío
                                onChanged: (String? newValue) {
                                  setState(() {
                                    seleccionarCate = newValue;
                                  });
                                },
                                items: <String>[
                                  'Deporte',
                                  'Manga',
                                  'Cocina'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                              SizedBox(height: 10),
                              DropdownButton<String>(
                                isExpanded: true,
                                value:
                                    seleccionarEdito, // Valor inicial es null o vacío
                                onChanged: (String? newValue) {
                                  setState(() {
                                    seleccionarEdito = newValue;
                                  });
                                },
                                items: <String>[
                                  'Chipre',
                                  'Universal',
                                  'Son'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(16.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                      color:
                                          const Color.fromARGB(255, 50, 53, 56),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                      color:
                                          const Color.fromARGB(255, 50, 53, 56),
                                    ),
                                  ),
                                  labelText: 'N° Paginas',
                                  hintText: 'Ingrese el n° paginas',
                                ),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(16.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                      color:
                                          const Color.fromARGB(255, 50, 53, 56),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                      color:
                                          const Color.fromARGB(255, 50, 53, 56),
                                    ),
                                  ),
                                  labelText: 'Stock',
                                  hintText: 'Ingrese el stock',
                                ),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                style: TextStyle(
                                    fontSize:
                                        14), // Reducimos el tamaño de la fuente
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical:
                                          8), // Reducimos el espacio interno
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        4.0), // Reducimos el radio de los bordes
                                    borderSide: BorderSide(
                                      color:
                                          const Color.fromARGB(255, 50, 53, 56),
                                      width: 1, // Reducimos el grosor del borde
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                    borderSide: BorderSide(
                                      color:
                                          const Color.fromARGB(255, 50, 53, 56),
                                      width: 1,
                                    ),
                                  ),
                                  labelText: 'Precio Venta',
                                  hintText: 'Ingrese el precio de venta',
                                ),
                              ),
                              SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  // Agrega la lógica para el botón aquí
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
                                      "Guardar",
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
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return SingleChildScrollView(
                                    child: Container(
                                      padding: EdgeInsets.all(16.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          SizedBox(height: 10),
                                          Text(
                                            "Editar libro",
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 31, 30, 30),
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          TextFormField(
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.all(16.0),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                borderSide: BorderSide(
                                                  color: const Color.fromARGB(
                                                      255, 50, 53, 56),
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                borderSide: BorderSide(
                                                  color: const Color.fromARGB(
                                                      255, 50, 53, 56),
                                                ),
                                              ),
                                              labelText: 'Codigo',
                                              hintText: 'Ingrese el codigo',
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          TextFormField(
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.all(16.0),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                borderSide: BorderSide(
                                                  color: const Color.fromARGB(
                                                      255, 50, 53, 56),
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                borderSide: BorderSide(
                                                  color: const Color.fromARGB(
                                                      255, 50, 53, 56),
                                                ),
                                              ),
                                              labelText: 'Titulo',
                                              hintText: 'Ingrese el titulo',
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          DropdownButton<String>(
                                            isExpanded: true,
                                            value:
                                                seleccionarCate, // Valor inicial es null o vacío
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                seleccionarCate = newValue;
                                              });
                                            },
                                            items: <String>[
                                              'Deporte',
                                              'Manga',
                                              'Cocina'
                                            ].map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                          SizedBox(height: 10),
                                          DropdownButton<String>(
                                            isExpanded: true,
                                            value:
                                                seleccionarEdito, // Valor inicial es null o vacío
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                seleccionarEdito = newValue;
                                              });
                                            },
                                            items: <String>[
                                              'Chipre',
                                              'Universal',
                                              'Son'
                                            ].map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                          SizedBox(height: 10),
                                          TextFormField(
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.all(16.0),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                borderSide: BorderSide(
                                                  color: const Color.fromARGB(
                                                      255, 50, 53, 56),
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                borderSide: BorderSide(
                                                  color: const Color.fromARGB(
                                                      255, 50, 53, 56),
                                                ),
                                              ),
                                              labelText: 'N° Paginas',
                                              hintText: 'Ingrese el n° paginas',
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          TextFormField(
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.all(16.0),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                borderSide: BorderSide(
                                                  color: const Color.fromARGB(
                                                      255, 50, 53, 56),
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                borderSide: BorderSide(
                                                  color: const Color.fromARGB(
                                                      255, 50, 53, 56),
                                                ),
                                              ),
                                              labelText: 'Stock',
                                              hintText: 'Ingrese el stock',
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          TextFormField(
                                            style: TextStyle(
                                                fontSize:
                                                    14), // Reducimos el tamaño de la fuente
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.symmetric(
                                                  horizontal: 12,
                                                  vertical:
                                                      8), // Reducimos el espacio interno
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(
                                                    4.0), // Reducimos el radio de los bordes
                                                borderSide: BorderSide(
                                                  color: const Color.fromARGB(
                                                      255, 50, 53, 56),
                                                  width:
                                                      1, // Reducimos el grosor del borde
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4.0),
                                                borderSide: BorderSide(
                                                  color: const Color.fromARGB(
                                                      255, 50, 53, 56),
                                                  width: 1,
                                                ),
                                              ),
                                              labelText: 'Precio Venta',
                                              hintText:
                                                  'Ingrese el precio de venta',
                                            ),
                                          ),
                                          SizedBox(height: 16),
                                          ElevatedButton(
                                            onPressed: () {
                                              // Agrega la lógica para el botón aquí
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Color.fromARGB(
                                                  255,
                                                  18,
                                                  94,
                                                  25), // Cambiamos el color al valor hexadecimal
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            child: Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8.0),
                                              child: Center(
                                                child: Text(
                                                  "Guardar",
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
                                },
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete,
                                color: Colors.red), // Icono de eliminar rojo
                            onPressed: () {
                              // Lógica para borrar aquí
                              LibroService().deleteLibro(libro.id);
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
