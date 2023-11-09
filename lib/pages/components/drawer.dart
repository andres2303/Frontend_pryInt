import 'package:flutter/material.dart';
import '../clientes.dart';
import '../login.dart';
import '../libros.dart';
import '../proveedor.dart'; 
import '../ventas/venta_prin.dart'; 
import '../compras/compras_prin.dart'; 
import '../trabajadores/trabajadores.dart';

class Draw extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 53, 75, 245),
                  Colors.white,
                ],
              ),
            ),
            height: 200,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 10),
                Image.asset(
                  'assets/perfil.png',
                  width: 70,
                  height: 70,
                ),
                SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tu Nombre',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'tu@email.com',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white, // Fondo blanco
              child: ListView(
                children: <Widget>[
                  for (var option in menuOptions)
                    InkWell(
                      onTap: () {
                        // Lógica para la opción seleccionada
                        if (option.title == 'Libros') {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Libro(), 
                          ));
                        } else if (option.title == 'Proveedores') {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Proveedor(),
                          ));
                        } else if (option.title == 'Clientes') {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Clientes(), 
                          ));
                        }else if (option.title == 'Ventas') {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => VentaPrin(), 
                          ));
                        }else if (option.title == 'Compras') {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CompraPrin(), 
                          ));
                        }else if (option.title == 'Trabajadores') {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Trabajadores(), 
                          ));
                        }
                      },
                      child: ListTile(
                        leading: Icon(option.icon),
                        title: Text(option.title),
                      ),
                      highlightColor: Colors.amber, // Establece el color de sombreado
                    ),
                  Divider(), // Línea separadora
                  InkWell(
                    onTap: () {
                      // Lógica para cerrar la sesión y navegar a la página de inicio de sesión
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => LoginPage(), // Reemplaza 'LoginPage' con el nombre de tu página de inicio de sesión
                      ));
                    },
                    child: ListTile(
                      leading: Icon(Icons.exit_to_app),
                      title: Text('Cerrar Sesión'),
                    ),
                    highlightColor: Colors.amber, // Establece el color de sombreado
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MenuOption {
  final IconData icon;
  final String title;

  MenuOption(this.icon, this.title);
}

final menuOptions = [
  MenuOption(Icons.attach_money, 'Ventas'),
  MenuOption(Icons.people, 'Clientes'),
  MenuOption(Icons.menu_book, 'Libros'),
  MenuOption(Icons.storage, 'Inventario Inicial'),
  MenuOption(Icons.supervisor_account, 'Proveedores'),
  MenuOption(Icons.shopping_cart, 'Compras'),
  MenuOption(Icons.library_books, 'Kardex'),
  MenuOption(Icons.insert_drive_file, 'Reportes'),
  MenuOption(Icons.chrome_reader_mode, 'Informe'),
  MenuOption(Icons.work, 'Trabajadores'),
];
