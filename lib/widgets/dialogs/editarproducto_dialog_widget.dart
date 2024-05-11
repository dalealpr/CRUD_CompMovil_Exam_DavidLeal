import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../../screen/screen.dart';

class EditarProductoDialog extends StatelessWidget {
  final int id;
  final String nombre;
  final int precio;
  final String img;
  final String estado;
  final Function(Producto) onEditar;
  late TextEditingController nombreController;
  late TextEditingController precioController;
  late TextEditingController imgController;
  late TextEditingController estadoController;

  EditarProductoDialog({
    Key? key,
    required this.id,
    required this.nombre,
    required this.precio,
    required this.img,
    required this.estado,
    required this.onEditar,
  }) {
    nombreController = TextEditingController(text: nombre);
    precioController = TextEditingController(text: precio.toString());
    imgController = TextEditingController(text: img);
    estadoController = TextEditingController(text: estado);
  }
  @override
  Widget build(BuildContext context) {
    bool esEditado = false;

    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 0, 2, 44),
      title: const Text(
        'Editar Producto',
        style: TextStyle(color: Colors.white, fontSize: 19),
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Nombre Producto
            TextFormField(
              controller: nombreController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Nombre Producto',
                labelStyle: TextStyle(
                    color: Color.fromARGB(255, 35, 255, 182), fontSize: 13),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            // Precio Producto
            TextFormField(
              controller: precioController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Precio',
                labelStyle: TextStyle(
                    color: Color.fromARGB(255, 35, 255, 182), fontSize: 13),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            // Imagen Producto
            TextFormField(
              controller: imgController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Imagen (URL)',
                labelStyle: TextStyle(
                    color: Color.fromARGB(255, 35, 255, 182), fontSize: 13),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            // Estado Producto
            TextFormField(
              controller: estadoController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Estado (Activo / Inactivo)',
                labelStyle: TextStyle(
                    color: Color.fromARGB(255, 35, 255, 182), fontSize: 13),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        // Boton cancelar
        MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: const Color.fromARGB(255, 99, 99, 99),
          elevation: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 13),
            child: const Text('Cancelar',
                style: TextStyle(color: Colors.white, fontSize: 14),
                textAlign: TextAlign.center),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        // Boton confirmar edición
        MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: const Color.fromARGB(255, 0, 162, 92),
          elevation: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 13),
            child: const Text('Aceptar',
                style: TextStyle(color: Colors.white, fontSize: 14),
                textAlign: TextAlign.center),
          ),
          onPressed: () {
            final productoEditado = Producto(
              productId: id,
              productName: nombreController.text,
              productPrice: int.parse(precioController.text),
              productImage: imgController.text,
              productState: estadoController.text,
            );
            esEditado = true;
            // Llamar a la función de callback con el producto actualizado
            onEditar(productoEditado);
          },
        ),
      ],
    );
  }
}
