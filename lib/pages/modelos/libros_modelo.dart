import 'dart:convert';

class LibroModelo {
  final int idLibro;
  final String titulo;
  final String codigo;
  final int nPaginas;
  final double precio;
  final int stock;
  final bool estado;
  final CategoriaModelo categoria;
  final EditorialModelo editorial;
  final AutorModelo autor;

  LibroModelo({
    required this.idLibro,
    required this.titulo,
    required this.codigo,
    required this.nPaginas,
    required this.precio,
    required this.stock,
    required this.estado,
    required this.categoria,
    required this.editorial,
    required this.autor,
  });

  factory LibroModelo.fromJson(Map<String, dynamic> json) {
    return LibroModelo(
      idLibro: json['idLibro'] ?? 0,
      titulo: json['titulo'] ?? '',
      codigo: json['codigo'] ?? '',
      nPaginas: json['nPaginas'] ?? 0,
      precio: json['precio'] ?? 0.0,
      stock: json['stock'] ?? 0,
      estado: json['estado'] ?? false,
      categoria: CategoriaModelo.fromJson(json['categoria'] ?? {}),
      editorial: EditorialModelo.fromJson(json['editorial'] ?? {}),
      autor: AutorModelo.fromJson(json['autor'] ?? {}),
    );
  }

    Map<String, dynamic> toJson() {
    return {
      'idLibro': idLibro,
      'titulo': titulo,
      'codigo': codigo,
      'nPaginas': nPaginas,
      'precio': precio,
      'stock': stock,
      'estado': estado,
      'categoria': categoria.toJson(),
      'editorial': editorial.toJson(),
      'autor': autor.toJson(),
    };
  }
}

class CategoriaModelo {
  final int idCategoria;
  final String nombre;
  final bool estado;

  CategoriaModelo({
    required this.idCategoria,
    required this.nombre,
    required this.estado,
  });

  factory CategoriaModelo.fromJson(Map<String, dynamic> json) {
    return CategoriaModelo(
      idCategoria: json['idCategoria'] ?? 0,
      nombre: json['nombre'] ?? '',
      estado: json['estado'] ?? false,
    );
  }

    Map<String, dynamic> toJson() {
    return {
      'idCategoria': idCategoria,
      'nombre': nombre,
      'estado': estado,
    };
  }
}

class EditorialModelo {
  final int idEditorial;
  final String nombre;
  final bool estado;

  EditorialModelo({
    required this.idEditorial,
    required this.nombre,
    required this.estado,
  });

  factory EditorialModelo.fromJson(Map<String, dynamic> json) {
    return EditorialModelo(
      idEditorial: json['idEditorial'] ?? 0,
      nombre: json['nombre'] ?? '',
      estado: json['estado'] ?? false,
    );
  }

    Map<String, dynamic> toJson() {
    return {
      'idEditorial': idEditorial,
      'nombre': nombre,
      'estado': estado,
    };
  }
}

class AutorModelo {
  final int idAutor;
  final String nombre;
  final bool estado;

  AutorModelo({
    required this.idAutor,
    required this.nombre,
    required this.estado,
  });

  factory AutorModelo.fromJson(Map<String, dynamic> json) {
    return AutorModelo(
      idAutor: json['idAutor'] ?? 0,
      nombre: json['nombre'] ?? '',
      estado: json['estado'] ?? false,
    );
  }

    Map<String, dynamic> toJson() {
    return {
      'idAutor': idAutor,
      'nombre': nombre,
      'estado': estado,
    };
  }
}
