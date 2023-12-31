import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../modelos/libros_modelo.dart';
import 'dart:convert';

class AgregarLibros extends StatefulWidget {
  @override
  _AgregarLibrosState createState() => _AgregarLibrosState();
}

class _AgregarLibrosState extends State<AgregarLibros> {
  final TextEditingController codigoController = TextEditingController();
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController paginasController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController precioController = TextEditingController();

  String? selectedCategoriaId;
  String? selectedEditorialId;
  String? selectedAutorId;

  List<CategoriaModelo> categorias = [];
  List<EditorialModelo> editoriales = [];
  List<AutorModelo> autores = [];

  @override
  void initState() {
    super.initState();
    obtenerCategorias();
    obtenerEditoriales();
    obtenerAutores();
  }

  Future<List<String>> fetchCategories() async {
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
  }

  Future<void> obtenerCategorias() async {
    try {
      // Realiza la solicitud a tu API de categorías
      var response = await http
          .get(Uri.parse('http://localhost:8080/api/categorias/listar'));

      if (response.statusCode == 200) {
        setState(() {
          categorias = (json.decode(response.body) as List)
              .map((data) => CategoriaModelo.fromJson(data))
              .toList();
        });
      } else {
        print('Error del servidor: ${response.statusCode}');
      }
    } on FormatException {
      print('Formato de respuesta no válido');
    } catch (e) {
      print('Ocurrió un error inesperado: $e');
    }
  }

  Future<void> obtenerEditoriales() async {
    try {
      // Realiza la solicitud a tu API de categorías
      var response = await http
          .get(Uri.parse('http://localhost:8080/api/editoriales/listar'));

      if (response.statusCode == 200) {
        setState(() {
          categorias = (json.decode(response.body) as List)
              .map((data) => CategoriaModelo.fromJson(data))
              .toList();
        });
      } else {
        print('Error del servidor: ${response.statusCode}');
      }
    } on FormatException {
      print('Formato de respuesta no válido');
    } catch (e) {
      print('Ocurrió un error inesperado: $e');
    }
  }

  Future<void> obtenerAutores() async {
    try {
      // Realiza la solicitud a tu API de categorías
      var response =
          await http.get(Uri.parse('http://localhost:8080/api/autores/listar'));

      if (response.statusCode == 200) {
        setState(() {
          categorias = (json.decode(response.body) as List)
              .map((data) => CategoriaModelo.fromJson(data))
              .toList();
        });
      } else {
        print('Error del servidor: ${response.statusCode}');
      }
    } on FormatException {
      print('Formato de respuesta no válido');
    } catch (e) {
      print('Ocurrió un error inesperado: $e');
    }
  }

  LibroModelo crearLibroModelo() {
    CategoriaModelo categoriaSeleccionada = categorias.firstWhere(
      (categoria) => categoria.idCategoria.toString() == selectedCategoriaId,
    );

    EditorialModelo editorialSeleccionada = editoriales.firstWhere(
      (editorial) => editorial.idEditorial.toString() == selectedEditorialId,
    );

    // Encuentra el autor seleccionado basado en el ID
    AutorModelo autorSeleccionado = autores.firstWhere(
      (autor) => autor.idAutor.toString() == selectedAutorId,
    );

    return LibroModelo(
      idLibro: 0, // Si el ID se genera automáticamente en el backend
      titulo: tituloController.text,
      codigo: codigoController.text,
      nPaginas: int.tryParse(paginasController.text) ?? 0,
      precio: double.tryParse(precioController.text) ?? 0.0,
      stock: int.tryParse(stockController.text) ?? 0,
      estado: true,
      categoria: categoriaSeleccionada,
      editorial: editorialSeleccionada,
      autor: autorSeleccionado,
    );
  }

  Future<void> enviarLibro(LibroModelo libro) async {
    var url = Uri.parse('http://localhost:8080/api/libros/crear');
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(libro.toJson()),
    );

    if (response.statusCode == 200) {
      // El libro se agregó correctamente
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Libro agregado con éxito')),
      );
    } else {
      // Hubo un problema al agregar el libro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al agregar el libro')),
      );
    }
  }

  Widget build(BuildContext context) {
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
              controller: codigoController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 50, 53, 56),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 50, 53, 56),
                  ),
                ),
                labelText: 'Codigo',
                hintText: 'Ingrese el codigo',
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: tituloController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 50, 53, 56),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 50, 53, 56),
                  ),
                ),
                labelText: 'Titulo',
                hintText: 'Ingrese el titulo',
              ),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: selectedCategoriaId,
              hint: Text(
                  "Seleccionar Categoría"), // Mostrar esto cuando el valor sea null
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategoriaId = newValue;
                });
              },
              items: categorias
                  .map<DropdownMenuItem<String>>((CategoriaModelo categoria) {
                return DropdownMenuItem<String>(
                  value: categoria.idCategoria.toString(),
                  child: Text(categoria.nombre),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: selectedEditorialId,
              hint: Text(
                  "Seleccionar Editorial"), // Mostrar esto cuando el valor sea null
              onChanged: (String? newValue) {
                setState(() {
                  selectedEditorialId = newValue;
                });
              },
              items: editoriales
                  .map<DropdownMenuItem<String>>((EditorialModelo editorial) {
                return DropdownMenuItem<String>(
                  value: editorial.idEditorial.toString(),
                  child: Text(editorial.nombre),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: selectedAutorId,
              hint: Text(
                  "Seleccionar Autor"), // Mostrar esto cuando el valor sea null
              onChanged: (String? newValue) {
                setState(() {
                  selectedAutorId = newValue;
                });
              },
              items: autores.map<DropdownMenuItem<String>>((AutorModelo autor) {
                return DropdownMenuItem<String>(
                  value: autor.idAutor.toString(),
                  child: Text(autor.nombre),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: paginasController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 50, 53, 56),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 50, 53, 56),
                  ),
                ),
                labelText: 'N° Paginas',
                hintText: 'Ingrese el n° paginas',
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: stockController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 50, 53, 56),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 50, 53, 56),
                  ),
                ),
                labelText: 'Stock',
                hintText: 'Ingrese el stock',
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: precioController,
              style: TextStyle(fontSize: 14),
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      4.0), // Reducimos el radio de los bordes
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 50, 53, 56),
                    width: 1, // Reducimos el grosor del borde
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 50, 53, 56),
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
                LibroModelo nuevoLibro = crearLibroModelo();
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
  }
}
