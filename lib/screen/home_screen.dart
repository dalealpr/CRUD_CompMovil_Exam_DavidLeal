import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../views/views.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const Color primary = Color.fromRGBO(47, 78, 255, 1);
  int selectedIdex = 0; // Index bottomNavBar

  @override
  Widget build(BuildContext context) {
    // Array de Views
    final views = [
      const ProductosView(),
      const CategoriasView(),
      const ProveedoresView()
    ];

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color.fromARGB(108, 0, 0, 0)), //
        toolbarHeight: 48,
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {
            // Coloca aquí la lógica para abrir el menú
          },
        ),
        backgroundColor: const Color.fromARGB(255, 0, 5, 46),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/logostr.png',
              height: 38,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
              size: 25,
            ),
            onPressed: () {
              Navigator.pushNamed(context, 'login');
            },
          ),
        ],
      ),
      // Views
      body: IndexedStack(
        index: selectedIdex,
        children: views,
      ),
      // Bottom-Nav
      bottomNavigationBar: BottomNavigationBar(
        onTap: (newIndex) {
          setState(() {
            selectedIdex = newIndex;
          });
        },
        selectedItemColor: Color.fromARGB(255, 255, 255, 255),
        unselectedItemColor: Color.fromARGB(255, 255, 255, 255),
        backgroundColor: Color.fromARGB(255, 15, 19, 47),
        currentIndex: selectedIdex,
        items: const [
          BottomNavigationBarItem(
            label: 'Productos',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Categorias',
            icon: Icon(Icons.store),
          ),
          BottomNavigationBarItem(
            label: 'Proveedores',
            icon: Icon(Icons.location_on),
          ),
        ],
      ),
    );
  }
}
