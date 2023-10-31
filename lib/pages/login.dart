import 'package:flutter/material.dart';
import 'package:projectfinal/pages/my_textfield.dart';
import 'package:projectfinal/pages/my_buttom.dart';
import 'package:projectfinal/pages/Inicio.dart'; // Importa el archivo Proveedores.dart

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

// Controladores de edición de texto
final usernameController = TextEditingController();
final passwordController = TextEditingController();

class _LoginPageState extends State<LoginPage> {
  bool _isChecked = false;

  void _toggleCheckbox(bool? value) {
    setState(() {
      _isChecked = value ?? false;
    });
  }

  // Función para realizar la navegación a la pantalla de Proveedores
  void signUserIn() {
    // Realiza aquí cualquier lógica de autenticación que puedas necesitar.

    // Navega a la pantalla de Proveedores cuando el usuario inicia sesión.
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Inicio()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo de la imagen
          Image.asset(
            'assets/fondo-biblio.jpg',
            fit: BoxFit.cover, // Ajustar la imagen al tamaño del contenedor
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85, // 85% de ancho
              height: MediaQuery.of(context).size.height * 0.8, // 80% de alto
              decoration: BoxDecoration(
                color: Colors.white, // Color de fondo del contenido
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity, // Ocupa todo el ancho del contenedor
                      height: 150.0, // Tamaño estático de la imagen
                      child: Image.asset(
                        'assets/logo.png',
                        fit: BoxFit.contain, // Ajustar la imagen al tamaño del contenedor
                      ),
                    ),
                    SizedBox(height: 15.0), // Aumenta el espacio entre la imagen y los campos de entrada
                    MyTextField(
                      controller: usernameController,
                      hintText: 'Email',
                      obscureText: false, // No ocultar texto
                    ),
                    const SizedBox(height: 12),
                    MyTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: !_isChecked, // Ocultar texto si _isChecked es falso
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Checkbox(
                          value: _isChecked,
                          onChanged: _toggleCheckbox,
                          visualDensity: VisualDensity(vertical: -4), // Elimina el espacio entre el checkbox y el texto
                        ),
                        Text('Show Password', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 25),
                    MyButton(
                      onTap: signUserIn, // Llama a la función signUserIn al hacer clic en el botón
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
