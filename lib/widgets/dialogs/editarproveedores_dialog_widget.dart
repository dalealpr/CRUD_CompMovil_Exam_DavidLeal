import 'package:flutter/material.dart';
import '../../models/models.dart';

class EditarProveedoresDialog extends StatelessWidget {
  final int id;
  final String nombre;
  final String apellido;
  final String mail;
  final String estado;
  final Function(ProveedorEdit) onEditar;
  late TextEditingController nombreController;
  late TextEditingController apellidoController;
  late TextEditingController mailController;
  late TextEditingController estadoController;

  EditarProveedoresDialog({
    Key? key,
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.mail,
    required this.estado,
    required this.onEditar,
  }) {
    nombreController = TextEditingController(text: nombre);
    apellidoController = TextEditingController(text: apellido);
    mailController = TextEditingController(text: mail);
    estadoController = TextEditingController(text: estado);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 0, 2, 44),
      title: const Text(
        'Editar Proveedor',
        style: TextStyle(color: Colors.white, fontSize: 19),
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Nombre Proveedor
            TextFormField(
              controller: nombreController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Nombre Proveedor',
                labelStyle: TextStyle(
                    color: Color.fromARGB(255, 35, 255, 182), fontSize: 13),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            // Apellido Proveedor
            TextFormField(
              controller: apellidoController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Apellido Proveedor',
                labelStyle: TextStyle(
                    color: Color.fromARGB(255, 35, 255, 182), fontSize: 13),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            // Email Proveedor
            TextFormField(
              controller: mailController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(
                    color: Color.fromARGB(255, 35, 255, 182), fontSize: 13),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            // Estado Proveedor
            TextFormField(
              controller: estadoController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Estado',
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
          color: const Color.fromARGB(255, 0, 162, 92),
          elevation: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 13),
            child: const Text('Aceptar',
                style: TextStyle(color: Colors.white, fontSize: 14),
                textAlign: TextAlign.center),
          ),
          onPressed: () {
            final proveedorActualizado = ProveedorEdit(
              providerId: id,
              providerName: nombreController.text,
              providerLastName: apellidoController.text,
              providerMail: mailController.text,
              providerState: estadoController.text,
            );
            // Llamar a la función de callback con el proveedor actualizado
            onEditar(proveedorActualizado);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
