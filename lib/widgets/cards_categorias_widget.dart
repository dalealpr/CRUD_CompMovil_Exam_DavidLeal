import 'package:flutter/material.dart';
import 'package:flutter_api_1/services/categoria_service.dart';
import 'package:flutter_api_1/views/views.dart';
import '../models/models.dart';
import '../widgets/widget.dart';

class CardCategoriaWidget extends StatefulWidget {
  const CardCategoriaWidget({super.key});

  @override
  State<CardCategoriaWidget> createState() => _CardCategoriaWidgetState();
}

class _CardCategoriaWidgetState extends State<CardCategoriaWidget> {
  final CategoriaService _categoriasService = CategoriaService();
  late Future<List<Categoria>> _categoriasFuture;

  Future<void> _fetchCategoriasAndUpdate() async {
    setState(() {
      _categoriasFuture = _categoriasService.fetchCategorias();
    });
  }

  @override
  void initState() {
    super.initState();
    _categoriasFuture = _categoriasService.fetchCategorias();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Categoria>>(
      future: _categoriasFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingView();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Categoria>? categorias = snapshot.data;
          if (categorias != null && categorias.isNotEmpty) {
            return Column(
              children: categorias.map((categoria) {
                return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Id Producto
                            Row(
                              children: [
                                const Text('ID: ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16)),
                                Text(categoria.categoryId.toString(),
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                    textAlign: TextAlign.end),
                              ],
                            ),
                            const SizedBox(height: 5),
                            //  Nombre Producto
                            Row(
                              children: [
                                const Text('Categoria: ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16)),
                                Flexible(
                                  child: Text(
                                    categoria.categoryName,
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            // Estado producto
                            Row(
                              children: [
                                const Text('Estado: ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16)),
                                Text('• ${categoria.categoryState}',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color:
                                            categoria.categoryState == 'Activa'
                                                ? const Color.fromARGB(
                                                    255, 0, 185, 34)
                                                : const Color.fromARGB(
                                                    255, 185, 0, 0)),
                                    textAlign: TextAlign.end),
                              ],
                            ),
                            const SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // boton Editar
                                MaterialButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  disabledColor: Colors.grey,
                                  color: Colors.cyan,
                                  elevation: 0,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 13),
                                    child: const Text('Editar',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14),
                                        textAlign: TextAlign.center),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) =>
                                          EditarCategoriaDialog(
                                        id: categoria.categoryId,
                                        nombre: categoria.categoryName,
                                        estado: categoria.categoryState,
                                        onEditar: (categoria) {
                                          // Llamar al servicio para editar la categoría
                                          _categoriasService
                                              .editarCategoria(categoria)
                                              .then((_) {
                                            _fetchCategoriasAndUpdate();
                                          });
                                        },
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(width: 10),
                                // boton Eliminar
                                MaterialButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  disabledColor: Colors.grey,
                                  color: Color.fromARGB(255, 179, 4, 4),
                                  elevation: 0,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 13),
                                    child: const Text('Eliminar',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14),
                                        textAlign: TextAlign.center),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) =>
                                          EliminarcategoriaDialog(
                                        nombre: categoria.categoryName,
                                        id: categoria.categoryId,
                                        onEditar: (proveedor) {
                                          // Llamar al servicio para eliminar categoria
                                          _categoriasService
                                              .eliminarCategoria(categoria)
                                              .then((_) {
                                            _fetchCategoriasAndUpdate();
                                          });
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ));
              }).toList(),
            );
          } else {
            return const Text('No hay categorías disponibles.');
          }
        }
      },
    );
  }
}
