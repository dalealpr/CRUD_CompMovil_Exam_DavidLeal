import 'package:flutter/material.dart';
import 'package:flutter_api_1/views/views.dart';
import '../models/proveedor_model.dart';
import '../services/proveedores_service.dart';
import '../widgets/widget.dart';

class CardProveedoresWidget extends StatefulWidget {
  const CardProveedoresWidget({super.key});

  @override
  State<CardProveedoresWidget> createState() => _CardProveedoresWidgetState();
}

class _CardProveedoresWidgetState extends State<CardProveedoresWidget> {
  final ProveedorService _proveedorService = ProveedorService();
  late Future<List<Proveedor>> _proveedoresFuture;

  Future<void> _fetchProveedoresAndUpdate() async {
    setState(() {
      _proveedoresFuture = _proveedorService.fetchProveedores();
    });
  }

  @override
  void initState() {
    super.initState();
    _proveedoresFuture = _proveedorService.fetchProveedores();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Proveedor>>(
      future: _proveedoresFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingView();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Proveedor>? proveedores = snapshot.data;
          if (proveedores != null && proveedores.isNotEmpty) {
            return Column(
              children: proveedores.map((proveedor) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Id Proveedor
                          Row(
                            children: [
                              const Text(
                                'ID: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '${proveedor.providerId}',
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          // Nombre Proveedor
                          Row(
                            children: [
                              const Text(
                                'Nombre: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                proveedor.providerName,
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          // Apellido Proveedor
                          Row(
                            children: [
                              const Text(
                                'Apellido: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                proveedor.providerLastName,
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          // Email Proveedor
                          Row(
                            children: [
                              const Text(
                                'Email: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                proveedor.providerMail,
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          // Estado Proveedor
                          Row(
                            children: [
                              const Text(
                                'Estado: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '• ${proveedor.providerState}',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: (proveedor.providerState == 'Activo' ||
                                          proveedor.providerState == 'Active')
                                      ? const Color.fromARGB(255, 0, 185, 34)
                                      : const Color.fromARGB(255, 185, 0, 0),
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Botón Editar
                              MaterialButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                disabledColor: Colors.grey,
                                color: Colors.cyan,
                                elevation: 0,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 13,
                                  ),
                                  child: const Text(
                                    'Editar',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        EditarProveedoresDialog(
                                      id: proveedor.providerId,
                                      nombre: proveedor.providerName,
                                      apellido: proveedor.providerLastName,
                                      mail: proveedor.providerMail,
                                      estado: proveedor.providerState,
                                      onEditar: (proveedor) {
                                        // Llamar al servicio para editar el proveedor
                                        _proveedorService
                                            .editarProveedor(proveedor)
                                            .then((_) {
                                          _fetchProveedoresAndUpdate();
                                        });
                                      },
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(width: 10),
                              // Botón Eliminar
                              MaterialButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                disabledColor: Colors.grey,
                                color: const Color.fromARGB(255, 179, 4, 4),
                                elevation: 0,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 13,
                                  ),
                                  child: const Text(
                                    'Eliminar',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        EliminarProveedorDialog(
                                      id: proveedor.providerId,
                                      nombre: proveedor.providerName,
                                      apellido: proveedor.providerLastName,
                                      onEliminar: (proveedor) {
                                        // Llamar al servicio para eliminar categoria
                                        _proveedorService
                                            .eliminarProveedor(proveedor)
                                            .then((_) {
                                          _fetchProveedoresAndUpdate();
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
                  ),
                );
              }).toList(),
            );
          } else {
            return const Text('No hay proveedores disponibles.');
          }
        }
      },
    );
  }
}
