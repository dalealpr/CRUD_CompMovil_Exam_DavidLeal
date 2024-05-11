import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../../services/categoria_service.dart';

class EditarCategoriaDialog extends StatelessWidget {
  final int id;
  final String nombre;
  final String estado;
  final Function(Categoria) onEditar;
  late TextEditingController nombreController;
  late TextEditingController estadoController;

  EditarCategoriaDialog({
    Key? key,
    required this.id,
    required this.nombre,
    required this.estado,
    required this.onEditar,
  }) {
    nombreController = TextEditingController(text: nombre);
    estadoController = TextEditingController(text: estado);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 0, 2, 44),
      title: const Text(
        'Editar Categoría',
        style: TextStyle(color: Colors.white, fontSize: 19),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Nombre Categoria
          TextFormField(
            controller: nombreController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelText: 'Nombre Categoria',
              labelStyle: TextStyle(
                  color: Color.fromARGB(255, 35, 255, 182), fontSize: 13),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
          // Estado Categoria
          TextFormField(
            controller: estadoController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelText: 'Estado (Activa / Inactiva)',
              labelStyle: TextStyle(
                  color: Color.fromARGB(255, 35, 255, 182), fontSize: 13),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
        ],
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
            final categoriaEditada = Categoria(
              categoryId: id,
              categoryName: nombreController.text,
              categoryState: estadoController.text,
            );
            // Llamar a la función de callback con la categoría actualizada
            onEditar(categoriaEditada);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
