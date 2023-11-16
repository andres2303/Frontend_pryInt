import 'package:flutter/material.dart';
import 'package:projectfinal/pages/libros/agregar_libros.dart';
import '../components/botones_navegacion.dart';
import '../components/drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../libros/detalle_libros.dart';
import '../libros/editar_libros.dart';
import '../modelos/libros_modelo.dart';

// Desde el api service

List<LibroModelo> libroModeloFromJson(String str) {
  final jsonData = json.decode(str);
  return List<LibroModelo>.from(jsonData.map((x) => LibroModelo.fromJson(x)));
}

Future<List<LibroModelo>> fetchLibrosModelo() async {
  try {
    final response =
        await http.get(Uri.parse('http://localhost:8080/api/libros/listar'));

    if (response.statusCode == 200) {
      // Parsear JSON
      return libroModeloFromJson(response.body);
    } else {
      // Manejar error
      throw Exception(
          'Failed to load libros. Status code: ${response.statusCode}');
    }
  } catch (e) {
    // Manejar errores de red u otros errores
    throw Exception('Error en la solicitud HTTP: $e');
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
  String? seleccionarEdito;
  String? selectedCategory;
  List<String> categoryList = [];
  List<LibroData> libros = [];
  final LibroService libroService = LibroService();

  @override
  void initState() {
    super.initState();

    // Llamar a la función para obtener la lista de categorías
    fetchCategories().then((categories) {
      setState(() {
        categoryList = categories;
      });
    });

    // Obtener la lista de libros
    actualizarLibros();
  }

  Future<List<String>> fetchCategories() async {
    try {
      final response = await http
          .get(Uri.parse('http://localhost:8080/api/categorias/listar'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        // Mapear la lista de categorías desde el JSON
        List<String> categories = jsonData.map((category) {
          return category['nombre'].toString();
        }).toList();
        return categories;
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Error en la solicitud HTTP: $e');
    }
  }

  Future<void> actualizarLibros() async {
    try {
      final fetchedLibros = await fetchLibrosModelo();
      setState(() {
        libros = fetchedLibros.map((libroModelo) {
          return LibroData(
            id: libroModelo.idLibro,
            title: 'Codigo: ${libroModelo.codigo}',
            subtitle: libroModelo.titulo,
          );
        }).toList();
      });
    } catch (e) {
      print('Error al actualizar libros: $e');
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
                isExpanded: true,
                value: selectedCategory,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCategory = newValue;
                  });
                },
                items: [
                  // Placeholder
                  DropdownMenuItem<String>(
                    value: null,
                    child: Text('Seleccionar Categoria'),
                  ),
                  // Categorías reales
                  ...categoryList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ],
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
                      return AgregarLibros();
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
                                  return DetalleLibros();
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
                                  return EditarLibros();
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
