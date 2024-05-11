import 'package:flutter/material.dart';
import 'package:flutter_api_1/views/views.dart';
import '../services/producto_service.dart';
import '../models/models.dart';
import '../screen/screen.dart';

class CardsProductoWidget extends StatefulWidget {
  const CardsProductoWidget({super.key});

  @override
  State<CardsProductoWidget> createState() => _CardProductoWidgetState();
}

class _CardProductoWidgetState extends State<CardsProductoWidget> {
  final ProductService _productService = ProductService();
  late Future<List<Producto>> _productosFuture;

  @override
  void initState() {
    super.initState();
    _productosFuture = _productService.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Producto>>(
      future: _productosFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingView();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Producto>? productos = snapshot.data;
          if (productos != null && productos.isNotEmpty) {
            return Column(
              children: productos.map((producto) {
                return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Card(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Imagen Producto
                          Image.network(producto.productImage),
                          const SizedBox(height: 20),
                          // Nombre Producto
                          Row(
                            children: [
                              const Text('Producto: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16)),
                              Flexible(
                                child: Text(
                                  producto.productName,
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 3),
                          // Precio Producto
                          Row(
                            children: [
                              const Text('Precio: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16)),
                              Text('\$${producto.productPrice}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.end),
                            ],
                          ),
                          const SizedBox(height: 3),
                          // Estado producto
                          Row(
                            children: [
                              const Text('Estado: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16)),
                              Text('• ${producto.productState}',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: (producto.productState ==
                                                  'Activo' ||
                                              producto.productState == 'Active')
                                          ? const Color.fromARGB(
                                              255, 0, 185, 34)
                                          : const Color.fromARGB(
                                              255, 185, 0, 0)),
                                  textAlign: TextAlign.end),
                            ],
                          ),
                          const SizedBox(height: 20),
                          // Boton Ver Producto
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            disabledColor: Colors.grey,
                            color: Colors.cyan,
                            elevation: 0,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              child: const Text('Ver Producto',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                  textAlign: TextAlign.center),
                            ),
                            onPressed: () {
                              // Navegar a la pantalla de detalle del producto y pasar los datos del producto
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailProductScreen(producto: producto),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    )));
              }).toList(),
            );
          } else {
            return const Text('No hay productos disponibles.');
          }
        }
      },
    );
  }
}
