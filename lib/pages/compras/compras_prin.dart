import 'package:flutter/material.dart';
import '../components/drawer.dart';
import '../components/botones_navegacion.dart';
import '../clientes/clientes.dart';
import '../compras/compras2.dart';

class LibroData {
  final String title;
  final String subtitle;

  LibroData({required this.title, required this.subtitle});
}

List<LibroData> libros = [
  LibroData(title: 'Xxx', subtitle: 'Xxxxx'),
];

class CompraPrin extends StatelessWidget {
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
                    'Compras',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () {
                          // Agrega la lógica de refresco aquí
                        },
                      ),
                      SizedBox(
                        width: 11, // Espacio entre los botones
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Clientes(), 
                          ));
                        },
                        child: Container(
                          padding: EdgeInsets.all(
                              7), // Ajusta el relleno según tus necesidades
                          decoration: BoxDecoration(
                            color: Colors.grey, // Color del botón
                            borderRadius: BorderRadius.circular(
                                8), // Ajusta según tu preferencia
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.add,
                                  color: Colors.white), // Icono "más"
                              Text(
                                'Cliente',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
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
                        labelText: 'Numero de Compra',
                        hintText: 'Ingrese el numero de compra',
                      ),
                    ),
                  ),
                  SizedBox(
                      width: 8), // Espacio entre el TextFormField y los iconos
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      // Agrega la lógica de refresco aquí
                    },
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () {
                      // Agrega la lógica de refresco aquífolutter
                    },
                  ),
                ],
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Compra2(),
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
                      "Comprar",
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
                                            "Editar Cliente",
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
                                              labelText: 'Nombre Completo',
                                              hintText: 'Ingrese los nombres',
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
                                              labelText: 'Apellido Completo',
                                              hintText: 'Ingrese los apellidos',
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
                                              labelText: 'DNI',
                                              hintText: 'Ingrese el N° DNI',
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
                                              labelText: 'Telefono',
                                              hintText:
                                                  'Ingrese el n° telefonico',
                                            ),
                                          ),
                                          SizedBox(height: 16),
                                          ElevatedButton(
                                            onPressed: () {
                                              // Agrega la lógica para el botón aquí
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Color.fromARGB(
                                                  255, 18, 94, 25),
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
