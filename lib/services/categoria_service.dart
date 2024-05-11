import 'package:flutter/material.dart';
import 'package:flutter_api_1/models/categoria_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CategoriaService extends ChangeNotifier {
  // Credenciales API
  final String _baseUrl = "143.198.118.203:8050";
  final String _user = 'test';
  final String _pass = 'test2023';

  // LISTAR CATEGORIAS
  Future<List<Categoria>> fetchCategorias() async {
    final url = Uri.http(_baseUrl, 'ejemplos/category_list_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));

    final response = await http.get(url, headers: {'authorization': basicAuth});
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final List<dynamic> categoriasListJson =
          responseData['Listado Categorias'];

      // Convertir la lista de JSON a lista de objetos Categoria
      List<Categoria> categoriasList = categoriasListJson
          .map((jsonItem) => Categoria.fromMap(jsonItem))
          .toList();

      return categoriasList;
    } else {
      throw Exception('Failed to load categories');
    }
  }

  // EDITAR CATEGORIAS
  Future<void> editarCategoria(Categoria categoria) async {
    // Construir la URL del endpoint
    final url = Uri.http(_baseUrl, 'ejemplos/category_edit_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));

    // Convertir el objeto Categoria a JSON
    final categoriaJson = categoria.toMap();

    try {
      // Realizar la solicitud POST al servidor con la autenticación básica y el cuerpo JSON
      final response = await http.post(
        url,
        body: jsonEncode(categoriaJson), // Convertir el objeto JSON a String
        headers: {
          'authorization': basicAuth,
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      // Verificar la respuesta
      if (response.statusCode == 200) {
        // La solicitud se realizó con éxito
        final decodeResp = response.body;
        print(decodeResp);
      } else {
        throw Exception('Failed to update category');
      }
    } catch (e) {
      throw e;
    }
  }

  // ELIMINAR CATEGORIAS
  Future<void> eliminarCategoria(Categoria categoria) async {
    // Construir la URL del endpoint
    final url = Uri.http(_baseUrl, 'ejemplos/category_del_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));

    // Convertir el objeto Categoria a JSON
    final categoriaJson = categoria.toMap();

    try {
      // Realizar la solicitud POST al servidor con la autenticación básica y el cuerpo JSON
      final response = await http.post(
        url,
        body: jsonEncode(categoriaJson), // Convertir el objeto JSON a String
        headers: {
          'authorization': basicAuth,
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      // Verificar el código de estado de la respuesta
      if (response.statusCode == 200) {
        final decodeResp = response.body;
        print(decodeResp);
      } else {
        throw Exception('Failed to update category');
      }
    } catch (e) {
      throw e;
    }
  }
}
