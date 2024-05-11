import 'package:flutter/material.dart';
import 'package:flutter_api_1/models/models.dart';

class EliminarProveedorDialog extends StatelessWidget {
  final int id;
  final String nombre;
  final String apellido;
  final Function onEliminar;
  const EliminarProveedorDialog({
    Key? key,
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.onEliminar,
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
            'Esta seguro que desea eliminar el proveedor: "${nombre} ${apellido}"',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10)
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
          color: Color.fromARGB(255, 179, 4, 4),
          elevation: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 13),
            child: const Text('Eliminar',
                style: TextStyle(color: Colors.white, fontSize: 14),
                textAlign: TextAlign.center),
          ),
          onPressed: () {
            final proveedorEliminado = ProveedorDel(
              providerId: id,
            );
            // Llamar a la función de callback con el id del proveedor que se desea eliminar
            onEliminar(proveedorEliminado);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
