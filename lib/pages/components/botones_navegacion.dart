import 'package:flutter/material.dart';
import '../libros.dart'; // Ajusta la ruta a tu archivo 'libros.dart'
import '../clientes.dart'; // Ajusta la ruta a tu archivo 'clientes.dart'
import '../proveedor.dart'; // Ajusta la ruta a tu archivo 'proveedor.dart'

class BotonesNavegacion extends StatefulWidget {
  @override
  _BotonesNavegacionState createState() => _BotonesNavegacionState();
}

class _BotonesNavegacionState extends State<BotonesNavegacion> {
  int _selectedIndex = 0;

  final List<BottomNavigationBarItem> _navItems = [
    BottomNavigationBarItem(
      icon: Container(
        child: Icon(Icons.shopping_cart),
        width: 30.0,
        height: 30.0,
      ),
      label: 'Compras',
    ),
    BottomNavigationBarItem(
      icon: Container(
        child: Icon(Icons.menu_book),
        width: 30.0,
        height: 30.0,
      ),
      label: 'Libros',
    ),
    BottomNavigationBarItem(
      icon: Container(
        child: Icon(Icons.person),
        width: 30.0,
        height: 30.0,
      ),
      label: 'Perfil',
    ),
  ];

  final List<Widget Function(BuildContext)> _screens = [
    (BuildContext context) => Proveedor(),
    (BuildContext context) => Libro(),
    (BuildContext context) => Clientes(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    Navigator.of(context).push(MaterialPageRoute(
      builder: _screens[index],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      items: _navItems,
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      onTap: _onItemTapped,
    );
  }
}
