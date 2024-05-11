import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../../screen/screen.dart';

class EliminarProductoDialog extends StatelessWidget {
  final int id;
  final String nombre;
  final Function onEditar;

  EliminarProductoDialog({
    Key? key,
    required this.nombre,
    required this.id,
    required this.onEditar,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 0, 2, 44),
      title: const Text(
        'Eliminar Proveedor',
        style: TextStyle(color: Colors.white, fontSize: 19),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Esta seguro que desea eliminar el producto: "${nombre}"',
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10)
        ],
      ),
      actions: [
        // Botón cancelar
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
        // Botón confirmar edición
        MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: const Color.fromARGB(255, 179, 4, 4),
          elevation: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 13),
            child: const Text('Eliminar',
                style: TextStyle(color: Colors.white, fontSize: 14),
                textAlign: TextAlign.center),
          ),
          onPressed: () {
            final productoEliminado = ProductoDel(
              productId: id,
            );
            // Llamar a la función de callback con el id del producto que se desea eliminar
            onEditar(productoEliminado);
          },
        ),
      ],
    );
  }
}
