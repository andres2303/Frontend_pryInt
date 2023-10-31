import 'package:flutter/material.dart';
import 'libros.dart'; // Ajusta la ruta a tu archivo 'proveedor.dart'
import 'clientes.dart';
import 'proveedor.dart';

class BotonesNavegacion extends StatefulWidget {
  @override
  _BotonesNavegacionState createState() => _BotonesNavegacionState();
}

class _BotonesNavegacionState extends State<BotonesNavegacion> {
  int _selectedIndex = 0;

  final List<IconData> _icons = [
    Icons.shopping_cart, // Ícono de compras
    Icons.menu_book,     // Ícono de libros
    Icons.person,        // Ícono de perfil
  ];

  final List<String> _labels = [
    'Compras',
    'Libros',
    'Perfil',
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      items: _icons
          .asMap()
          .map((index, icon) => MapEntry(
                index,
                BottomNavigationBarItem(
                  icon: Icon(icon, color: Colors.white),
                  label: _labels[index],
                ),
              ))
          .values
          .toList(),
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
          if (_labels[index] == 'Libros') {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Libro(), // Reemplaza 'Proveedor' con el nombre correcto de tu pantalla
            ));
          }
          if (_labels[index] == 'Perfil') {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Clientes(), // Reemplaza 'Proveedor' con el nombre correcto de tu pantalla
            ));
          }
          if (_labels[index] == 'Compras') {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Proveedor(), // Reemplaza 'Proveedor' con el nombre correcto de tu pantalla
            ));
          }
        });
      },
    );
  }
}
