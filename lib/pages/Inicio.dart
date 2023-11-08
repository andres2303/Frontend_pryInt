import 'package:flutter/material.dart';
import 'components/drawer.dart';
import 'components/botones_navegacion.dart';
import 'package:lottie/lottie.dart'; // Importa la librería Lottie

class Inicio extends StatelessWidget {
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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverFillRemaining(
            child: Center(
              child: Lottie.asset(
                'assets/ini_anima.json', // Ruta a tu archivo JSON Lottie
                width: 200, // Ajusta el tamaño según tus necesidades
                height: 200,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BotonesNavegacion(),
    );
  }
}
