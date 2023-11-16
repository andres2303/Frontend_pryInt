import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AgregarLibros extends StatefulWidget {
  @override
  _AgregarLibrosState createState() => _AgregarLibrosState();
}

class _AgregarLibrosState extends State<AgregarLibros> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidosController = TextEditingController();
  final TextEditingController dniController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();

  String? selectedCategory;
  String? selectedEditorial;
  String? selectedAuthor;
  List<String> categoryList = [];
  List<String> editorialList = [];
  List<String> authorList = [];

  @override
  void initState() {
    super.initState();
    // Llamar a la función para obtener la lista de categorías, editoriales y autores
    fetchCategories().then((categories) {
      setState(() {
        categoryList = categories;
      });
    });

    fetchEditorials().then((editorials) {
      setState(() {
        editorialList = editorials;
      });
    });

    fetchAuthors().then((authors) {
      setState(() {
        authorList = authors;
      });
    });
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

  Future<List<String>> fetchEditorials() async {
    final response = await http
        .get(Uri.parse('http://localhost:8080/api/editoriales/listar'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<String> editorials = jsonData.map((editorial) {
        return editorial['nombre'].toString();
      }).toList();
      return editorials;
    } else {
      throw Exception('Failed to load editorials');
    }
  }

    Future<List<String>> fetchAuthors() async {
    final response = await http.get(Uri.parse('http://localhost:8080/api/autores/listar'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<String> authors = jsonData.map((author) {
        return author['nombre'].toString();
      }).toList();
      return authors;
    } else {
      throw Exception('Failed to load authors');
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
              isExpanded: true,
              value: selectedCategory,
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue;
                });
              },
              items: [
                DropdownMenuItem<String>(
                  value: null,
                  child: Text('Seleccionar Categoría'),
                ),
                ...categoryList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ],
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              isExpanded: true,
              value: selectedEditorial,
              onChanged: (String? newValue) {
                setState(() {
                  selectedEditorial = newValue;
                });
              },
              items: [
                DropdownMenuItem<String>(
                  value: null,
                  child: Text('Seleccionar Editorial'),
                ),
                ...editorialList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ],
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              isExpanded: true,
              value: selectedAuthor,
              onChanged: (String? newValue) {
                setState(() {
                  selectedAuthor = newValue;
                });
              },
              items: [
                DropdownMenuItem<String>(
                  value: null,
                  child: Text('Seleccionar Autor'),
                ),
                ...authorList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ],
            ),
            SizedBox(height: 10),
            TextFormField(
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
              style:
                  TextStyle(fontSize: 14), // Reducimos el tamaño de la fuente
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8), // Reducimos el espacio interno
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
  }
}
