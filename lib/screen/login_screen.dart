import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../providers/provider.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primary = Color.fromARGB(255, 255, 255, 255);
    const Color secondary = Color.fromARGB(255, 13, 15, 30);
    const Color tertiary = Color.fromARGB(255, 82, 212, 154);
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(color: secondary),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 80.0, horizontal: 70.0),
                  child: Column(
                    children: [
                      Text(
                        'Inicia sesión',
                        style: TextStyle(
                            color: primary,
                            fontSize: 24,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '¡Qué bueno verte de nuevo! inicia sesión para continuar',
                        style: TextStyle(
                            color: Color.fromARGB(255, 216, 216, 216),
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )),
              Container(
                decoration: const BoxDecoration(color: secondary),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(children: [
                      const SizedBox(height: 20),
                      ChangeNotifierProvider(
                        create: (_) => LoginFormProvider(),
                        child: LoginForm(),
                      ),
                      const SizedBox(height: 50),
                      // Texto registrarse
                      TextButton(
                        onPressed: () =>
                            Navigator.pushReplacementNamed(context, 'add_user'),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(StadiumBorder())),
                        child: const Text(
                          'No tienes una cuenta?, creala',
                          style: TextStyle(color: tertiary),
                        ),
                      )
                    ])),
              ),
              const SizedBox(height: 80),
              const Text(
                'StreetStyleChile todos los derechos reservados ©',
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 11,
                    fontWeight: FontWeight.w300),
                textAlign: TextAlign.center,
              ),
              const Text(
                'Santiago de Chile.',
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 11,
                    fontWeight: FontWeight.w300),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    const Color secondary = Color.fromRGBO(241, 243, 255, 1);
    const Color tertiary = Color.fromARGB(255, 82, 212, 154);
    const Color quaternary = Color.fromARGB(255, 23, 26, 52);
    final LoginForm = Provider.of<LoginFormProvider>(context);
    return Container(
      child: Form(
        key: LoginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(children: [
          // Email
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.text,
            style: const TextStyle(color: secondary),
            decoration: InputDecoration(
              filled: true,
              fillColor: quaternary, // Color de fondo del TextFormField
              hintText: 'Email',
              hintStyle: const TextStyle(color: secondary),
              prefixIcon: const Icon(
                Icons.people,
                color: Colors.grey,
              ),
              border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // Radio de los bordes
                  borderSide: LoginForm.invalidCredentials
                      ? const BorderSide(
                          color: Colors.red,
                          width: BorderSide.strokeAlignCenter)
                      : BorderSide.none),
              focusedBorder: OutlineInputBorder(
                // Borde al estar enfocado
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: tertiary,
                ), // Color del borde al estar enfocado
              ),
            ),
            onChanged: (value) => LoginForm.email = value,
            validator: (value) {
              return (value != null && value.length >= 4)
                  ? null
                  : 'El usuario no puede estar vacío';
            },
          ),
          const SizedBox(height: 30),
          // Password
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.text,
            style: const TextStyle(color: secondary),
            decoration: InputDecoration(
              focusColor: Colors.red,
              iconColor: Colors.red,
              hoverColor: Colors.red,
              filled: true,
              fillColor: quaternary, // Color de fondo del TextFormField
              hintText: 'Contraseña',
              hintStyle: const TextStyle(color: secondary),
              prefixIcon: const Icon(
                Icons.password,
                color: Colors.grey,
              ),
              border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // Radio de los bordes
                  borderSide: LoginForm.invalidCredentials
                      ? const BorderSide(color: Colors.red, width: 1.0)
                      : BorderSide.none),
              focusedBorder: OutlineInputBorder(
                // Borde al estar enfocado
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: tertiary,
                ), // Color del borde al estar enfocado
              ),
            ),
            onChanged: (value) => LoginForm.password = value,
            validator: (value) {
              return (value != null && value.length >= 4)
                  ? null
                  : 'La contraseña no puede estar vacio';
            },
          ),

          const SizedBox(height: 40),
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            disabledColor: Colors.grey,
            color: tertiary,
            elevation: 0,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 13),
              child: Text('Ingresar',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center),
            ),
            onPressed: LoginForm.isLoading
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final authService =
                        Provider.of<AuthService>(context, listen: false);
                    if (!LoginForm.isValidForm()) return;
                    final String? errorMessage = await authService.login(
                        LoginForm.email, LoginForm.password);
                    LoginForm.invalidCredentials = false; // ¡Ajuste necesario!
                    if (errorMessage == null) {
                      // Si las credenciales son válidas, navegar a la siguiente pantalla
                      Navigator.pushNamed(context, 'home');
                    } else {
                      // Si hay un error, imprimirlo y marcar las credenciales como inválidas
                      print(errorMessage);
                      LoginForm.invalidCredentials = true;
                    }
                    LoginForm.isLoading = false;
                  },
          ),
          const SizedBox(height: 15),
          Visibility(
              visible: LoginForm.invalidCredentials,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 168, 168, 1),
                    borderRadius: BorderRadius.circular(4.0)),
                child: const Text(
                  'Credenciales inválidas',
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              )),
        ]),
      ),
    );
  }
}
