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
  List<LibroModelo> libros = [];
  TextEditingController codigoController = TextEditingController();
  final LibroService libroService = LibroService();  

    @override
  void initState() {
    super.initState();

    fetchCategories().then((categories) {
      setState(() {
        categoryList = categories;
      });
    });

    actualizarLibros();
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

    Future<void> buscarPorCodigo() async {
    final codigo = codigoController.text;

    if (codigo.isNotEmpty) {
      try {
        final response = await http.get(
          Uri.parse(
              'http://localhost:8080/api/libros/buscarPorCodigo?codigo=$codigo'),
        );

        if (response.statusCode == 200) {
          List<LibroModelo> librosEncontrados =
              libroModeloFromJson(response.body);
          _filtrarLibros(librosEncontrados);
        } else {
          throw Exception('Failed to load libro');
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }

    Future<void> _filtrarLibros(List<LibroModelo> librosFiltrados) {
    setState(() {
      libros = librosFiltrados;
    });
    return Future.value();
  }

    Future<void> actualizarLibros() async {
    try {
      final fetchedLibros = await fetchLibrosModelo();
      setState(() {
        libros = fetchedLibros;
      });
    } catch (e) {
      print('Error al actualizar libros: $e');
    }
  }

    Future<List<String>> fetchCategories() async {
    try {
      final response = await http
          .get(Uri.parse('http://localhost:8080/api/categorias/listar'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);

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

  Future<void> eliminarLibro(int id) async {
    try {
      await libroService.deleteLibro(id);
      // Actualizar la lista de libros después de eliminar
      actualizarLibros();
      print('Libro eliminado correctamente');
    } catch (e) {
      print('Error al eliminar el libro: $e');
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
                  Spacer(),
                  InkWell(
                    onTap: () {
                      codigoController.clear();
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
                    onPressed: () {
                      codigoController.clear(); 
                      actualizarLibros();
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: codigoController,
                keyboardType:
                    TextInputType.number, // Configurar el tipo de teclado
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
                  labelText: 'Codigo',
                  hintText: 'Ingrese el codigo del Libro',
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
                  buscarPorCodigo();
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
                        'Código: ${libro.codigo}',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        libro.titulo,
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
                                  return DetalleLibro(libro: libro);
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
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              // Mostrar un diálogo de confirmación antes de eliminar
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Eliminar Libro'),
                                    content: Text(
                                        '¿Está seguro de que desea eliminar este libro?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(
                                              context); // Cerrar el diálogo de confirmación
                                        },
                                        child: Text('Cancelar'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          eliminarLibro(libro.idLibro);
                                          Navigator.pop(
                                              context); // Cerrar el diálogo de confirmación
                                        },
                                        child: Text('Eliminar'),
                                      ),
                                    ],
                                  );
                                },
                              );
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
