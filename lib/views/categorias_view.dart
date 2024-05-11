import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_api_1/widgets/cards_categorias_widget.dart';
import '../models/categoria_model.dart';
import '../services/categoria_service.dart';

class CategoriasView extends StatefulWidget {
  const CategoriasView({Key? key}) : super(key: key);

  @override
  State<CategoriasView> createState() => _CategoriasViewState();
}

class _CategoriasViewState extends State<CategoriasView> {
  final CategoriaService _categoriasService = CategoriaService();
  late Future<List<Categoria>> _categoriasFuture;

  @override
  void initState() {
    super.initState();
    _categoriasFuture = _categoriasService.fetchCategorias();
  }

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
        child: Padding(
      padding: EdgeInsets.only(top: 30, bottom: 20, left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Lista de Categorias',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 20),
          // Cards Categorias
          CardCategoriaWidget()
        ],
      ),
    ));
  }
}
