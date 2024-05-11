import 'package:flutter/material.dart';
import 'package:flutter_api_1/screen/home_screen.dart';
import '../models/models.dart';
import '../widgets/widget.dart';
import '../services/producto_service.dart';
import '../screen/screen.dart';

class DetailProductScreen extends StatefulWidget {
  final Producto producto;

  const DetailProductScreen({super.key, required this.producto});

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  final ProductService _productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detalles del Producto',
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
        backgroundColor: const Color.fromARGB(255, 0, 5, 46),
        titleTextStyle: const TextStyle(color: Colors.white),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          // Navegar al home, vuelve a cargar la lista de productos
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              children: [
                Container(
                  constraints: const BoxConstraints(
                    maxHeight: 320,
                  ),
                  child: Image.network(
                    widget.producto.productImage,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      // Nombre Producto
                      const Row(
                        children: [
                          Text(
                            'Nombre Producto: ',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 17),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              widget.producto.productName,
                              style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      // ID Producto
                      Row(
                        children: [
                          const Text(
                            'ID: ',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 17),
                          ),
                          Text(
                            widget.producto.productId.toString(),
                            style: const TextStyle(fontSize: 17),
                            textAlign: TextAlign.end,
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      // Precio Producto
                      Row(
                        children: [
                          const Text(
                            'Precio: ',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 18),
                          ),
                          Text(
                            '\$${widget.producto.productPrice}',
                            style: const TextStyle(fontSize: 18),
                            textAlign: TextAlign.end,
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      // Estado Producto
                      Row(
                        children: [
                          const Text(
                            'Estado: ',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 18),
                          ),
                          Text(
                            '• ${widget.producto.productState}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: (widget.producto.productState ==
                                          'Activo' ||
                                      widget.producto.productState == 'Active')
                                  ? const Color.fromARGB(255, 0, 185, 34)
                                  : const Color.fromARGB(255, 185, 0, 0),
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      // Botones
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 15),
                          //Boton Editar Producto
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            disabledColor: Colors.grey,
                            color: Colors.cyan,
                            elevation: 0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              child: const Text(
                                'Editar',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => EditarProductoDialog(
                                  id: widget.producto.productId,
                                  nombre: widget.producto.productName,
                                  precio: widget.producto.productPrice,
                                  img: widget.producto.productImage,
                                  estado: widget.producto.productState,
                                  onEditar: (producto) {
                                    _productService
                                        .editarProducto(producto)
                                        .then((_) {
                                      // Navigator.of(context).pop();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailProductScreen(
                                                  producto: producto),
                                        ),
                                      );
                                    });
                                  },
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 15),
                          //Boton Eliminar Producto
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            disabledColor: Colors.grey,
                            color: Color.fromARGB(255, 179, 4, 4),
                            elevation: 0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              child: const Text(
                                'Eliminar',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => EliminarProductoDialog(
                                  nombre: widget.producto.productName,
                                  id: widget.producto.productId,
                                  onEditar: (producto) {
                                    _productService
                                        .eliminarProducto(producto)
                                        .then((_) {
                                      Navigator.of(context).pop();

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const HomeScreen(),
                                        ),
                                      );
                                    });
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
