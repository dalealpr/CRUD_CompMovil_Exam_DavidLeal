import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/provider.dart';
import '../services/auth_service.dart';

class RegisterUserScreen extends StatelessWidget {
  const RegisterUserScreen({super.key});
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
                padding: EdgeInsets.symmetric(vertical: 80.0, horizontal: 70.0),
                child: Column(children: [
                  Text(
                    'Registrate',
                    style: TextStyle(
                        color: primary,
                        fontSize: 24,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Crea una cuenta para disfrutar de nuestros beneficios ',
                    style: TextStyle(
                        color: Color.fromARGB(255, 214, 214, 214),
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  )
                ]),
              ),
              Container(
                  decoration: const BoxDecoration(color: secondary),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          ChangeNotifierProvider(
                            create: (_) => LoginFormProvider(),
                            child: RegisterForm(),
                          ),
                          const SizedBox(height: 50),
                          // Texto loguearse
                          TextButton(
                            onPressed: () => Navigator.pushReplacementNamed(
                                context, 'login'),
                            style: ButtonStyle(
                                shape:
                                    MaterialStateProperty.all(StadiumBorder())),
                            child: const Text(
                                '¿Ya tienes una cuenta?, autentificate'),
                          )
                        ],
                      ))),
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

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

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
                borderSide: BorderSide.none, // Sin borde lateral
              ),
              focusedBorder: OutlineInputBorder(
                // Borde al estar enfocado
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                    color: tertiary), // Color del borde al estar enfocado
              ),
            ),
            onChanged: (value) => LoginForm.email = value,
            validator: (value) {
              return (value != null && value.length >= 4)
                  ? null
                  : 'El usuario no puede estar vacio';
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.text,
            style: const TextStyle(color: secondary),
            decoration: InputDecoration(
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
                borderSide: BorderSide.none, // Sin borde lateral
              ),
              focusedBorder: OutlineInputBorder(
                // Borde al estar enfocado
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                    color: tertiary), // Color del borde al estar enfocado
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
              padding: const EdgeInsets.symmetric(vertical: 13),
              child: Text('Registrar',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center),
            ),
            onPressed: LoginForm.isLoading
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final authService =
                        Provider.of<AuthService>(context, listen: false);
                    if (!LoginForm.isValidForm()) return;
                    LoginForm.isLoading = true;
                    final String? errorMessage = await authService.create_user(
                        LoginForm.email, LoginForm.password);
                    if (errorMessage == null) {
                      Navigator.pushNamed(context, 'login');
                    } else {
                      print(errorMessage);
                    }
                  },
          )
        ]),
      ),
    );
  }
}
