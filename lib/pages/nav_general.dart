import 'package:flutter/material.dart';

class NavGeneral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Center(
        child: Image.asset(
          'assets/logo.png',
          height: 45.0, // Ajusta la altura de la imagen según tu preferencia
        ),
      ),
      expandedHeight: 50.0,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.grey, Colors.white],
            ),
          ),
        ),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        onPressed: () {
          Scaffold.of(context).openDrawer(); // Abre el CustomDrawer
        },
      ),
    );
  }
}
