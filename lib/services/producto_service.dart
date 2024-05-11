import 'package:flutter/material.dart';
import 'package:flutter_api_1/models/productdel_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/producto_model.dart';

class ProductService extends ChangeNotifier {
  // Credenciales API
  final String _baseUrl = "143.198.118.203:8050";
  final String _user = 'test';
  final String _pass = 'test2023';

  Future<List<Producto>> fetchProducts() async {
    final url = Uri.http(_baseUrl, 'ejemplos/product_list_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));

    final response = await http.get(url, headers: {'authorization': basicAuth});
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final List<dynamic> productosListJson = responseData['Listado'];

      // Convertir la lista de JSON a lista de objetos Producto
      List<Producto> productosList = productosListJson
          .map((jsonItem) => Producto.fromMap(jsonItem))
          .toList();

      return productosList;
    } else {
      throw Exception('Failed to load products');
    }
  }

  // EDITAR PRODUCTO
  Future<void> editarProducto(Producto producto) async {
    // Construir la URL del endpoint
    final url = Uri.http(_baseUrl, 'ejemplos/product_edit_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));

    // Convertir el objeto Categoria a JSON
    final productoJson = producto.toMap();

    try {
      // Realizar la solicitud POST al servidor con la autenticación básica y el cuerpo JSON
      final response = await http.post(
        url,
        body: jsonEncode(productoJson), // Convertir el objeto JSON a String
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
        throw Exception('Failed to update product');
      }
    } catch (e) {
      throw e;
    }
  }

  // ELIMINAR PRODUCTO
  Future<void> eliminarProducto(ProductoDel producto) async {
    // Construir la URL del endpoint
    final url = Uri.http(_baseUrl, 'ejemplos/product_del_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));

    // Convertir el objeto Categoria a JSON
    final productoJson = producto.toMap();

    try {
      // Realizar la solicitud POST al servidor con la autenticación básica y el cuerpo JSON
      final response = await http.post(
        url,
        body: jsonEncode(productoJson), // Convertir el objeto JSON a String
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
