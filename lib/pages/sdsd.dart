import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AgregarLibros extends StatefulWidget {
  @override
  _AgregarLibrosState createState() => _AgregarLibrosState();
}

class _AgregarLibrosState extends State<AgregarLibros> {
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
    final response =
        await http.get(Uri.parse('http://localhost:8080/api/categorias/listar'));

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
    final response = await http.get(Uri.parse('http://localhost:8080/api/editoriales/listar'));

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 20),
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
            SizedBox(height: 20),
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
            SizedBox(height: 20),
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
          ],
        ),
      ),
    );
  }
}
