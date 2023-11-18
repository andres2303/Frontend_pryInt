import 'package:flutter/material.dart';
import '../pages/components/drawer.dart';
import '../pages/components/botones_navegacion.dart';
import '../pages/modelos/ventas_modelo.dart';

class LibroData {
  final String title;
  final String subtitle;

  LibroData({required this.title, required this.subtitle});
}

class Venta2 extends StatefulWidget {
  @override
  _Venta2State createState() => _Venta2State();
}

class _Venta2State extends State<Venta2> {
  final TextEditingController codigoController = TextEditingController();
  final TextEditingController libroController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController cantidadController = TextEditingController();
  final TextEditingController precioventaController = TextEditingController();
  final TextEditingController subtotalController = TextEditingController();
  final TextEditingController dniController = TextEditingController();

  bool mostrarTarjetaBusqueda = false;

  List<LibroData> libros = [
    LibroData(title: 'XXX', subtitle: 'Xxxx'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Ventas',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 50), // Espacio entre el título y la imagen
            Image.asset(
              'assets/logo.png',
              height: 35.0,
            ),
          ],
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
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
                  SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        mostrarTarjetaBusqueda = true;
                      });
                    },
                  ),
                  if (mostrarTarjetaBusqueda)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      child: Card(
                        elevation: 4,
                        margin:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        color: Colors.white,
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                          title: Text(
                            'Cliente de Ejemplo',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'Detalles del cliente de ejemplo',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 8),
              Divider(),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: codigoController,
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
                        hintText: 'Ingrese el codigo',
                      ),
                    ),
                  ),
                  SizedBox(width: 8), // Espacio entre los campos de texto
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: libroController,
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
                        labelText: 'Libro',
                        hintText: 'Ingrese el libro',
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.menu_book),
                    onPressed: () {
                      // Agrega la lógica para mostrar un calendario aquí
                    },
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: stockController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
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
                        hintText: 'Ingrese el codigo',
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: stockController,
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
                        labelText: 'Stock',
                        hintText: 'esta predeterminado',
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: cantidadController,
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
                        labelText: 'Cantidad',
                        hintText: 'Ingrese la cantidad',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 11),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: precioventaController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
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
                        labelText: 'PrecioVenta',
                        hintText: 'es predeterminado',
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: subtotalController,
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
                        labelText: 'SubtTotal',
                        hintText: 'esta predeterminado',
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                      codigoController.clear();
                      stockController.clear();
                      libroController.clear();
                      cantidadController.clear();
                      precioventaController.clear();
                      subtotalController.clear();
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.cleaning_services,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 11),
              ElevatedButton(
                onPressed: () {},
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
                          color: Colors
                              .black, // Cambiamos el color del subtítulo a negro
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit,
                                color: Colors.blue), // Icono de editar azul
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.delete,
                                color: Colors.red), // Icono de eliminar rojo
                            onPressed: () {
                              // Lógica para borrar aquí
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceEvenly, // Alineación espaciada entre los botones
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Lógica para el botón "Cancelar" aquí
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Container(
                      width: 80, // Ancho del botón "Cancelar"
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Center(
                        child: Text(
                          "Cancelar",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return ListView(
                            shrinkWrap: true,
                            children: [
                              Container(
                                padding: EdgeInsets.all(16.0),
                                width: double.infinity,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    SizedBox(height: 10),
                                    Text(
                                      "Generar Venta",
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 31, 30, 30),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start, // Alinea los elementos a la izquierda
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "Fecha: 20/09/2023",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Color.fromARGB(
                                                  255, 31, 30, 30),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "Cliente: Andres Diaz Mendoza",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Color.fromARGB(
                                                  255, 31, 30, 30),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 14),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  columns: [
                                    DataColumn(label: Text('Libro')),
                                    DataColumn(label: Text('Cantidad')),
                                    DataColumn(label: Text('Precio')),
                                    DataColumn(label: Text('SubTotal')),
                                  ],
                                  rows: [
                                    DataRow(cells: [
                                      DataCell(Text('Red Interna')),
                                      DataCell(Text('5')),
                                      DataCell(Text('\$50.00')),
                                      DataCell(Text('\$250.00')),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(Text('Red Interna')),
                                      DataCell(Text('3')),
                                      DataCell(Text('\$30.00')),
                                      DataCell(Text('\$90.00')),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(Text('Red Interna')),
                                      DataCell(Text('2')),
                                      DataCell(Text('\$20.00')),
                                      DataCell(Text('\$60.00')),
                                    ]),
                                  ],
                                ),
                              ),
                              SizedBox(height: 14),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceEvenly, // Alineación espaciada entre los botones
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      // Lógica para el botón "Cancelar" aquí
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary:
                                          Color.fromARGB(255, 228, 170, 11),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Container(
                                      width: 90, // Ancho del botón "Cancelar"
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.0),
                                      child: Center(
                                        child: Text(
                                          "Pagar Venta",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.grey,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Container(
                                      width: 80, // Ancho del botón "Guardar"
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.0),
                                      child: Center(
                                        child: Text(
                                          "Cancelar",
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
                              SizedBox(height: 14),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Container(
                      width: 80, // Ancho del botón "Guardar"
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: BotonesNavegacion(),
    );
  }
}
