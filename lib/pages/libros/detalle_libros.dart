import 'package:flutter/material.dart';
import '../modelos/libros_modelo.dart';

class DetalleLibro extends StatelessWidget {
  final LibroModelo libro;

  DetalleLibro({required this.libro});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 10),
            Text(
              "Detalle Libro",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 31, 30, 30),
              ),
            ),
            SizedBox(height: 25),
            Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      'Titulo: ${libro.titulo}',
                      /*style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),*/
                    ),
                    subtitle: Text(
                      'Codigo: ${libro.codigo}',
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'N° Paginas: ${libro.nPaginas}',
                    ),
                    subtitle: Text(
                      'Precio: ${libro.precio}',
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Stock: ${libro.stock}',
                    ),
                    subtitle: Text(
                      'Autor: ${libro.autor.nombre}',
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Categoria: ${libro.categoria.nombre}',
                    ),
                    subtitle: Text(
                      'Editorial: ${libro.editorial.nombre}',
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Estado: ${libro.estado ? "Disponible" : "No disponible"}',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
