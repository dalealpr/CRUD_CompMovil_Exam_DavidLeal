import 'package:flutter/material.dart';
import 'package:flutter_api_1/models/proveedordel_model.dart';
import 'package:flutter_api_1/models/proveedoredit_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/proveedor_model.dart';

class ProveedorService extends ChangeNotifier {
  // Credenciales API
  final String _baseUrl = "143.198.118.203:8050";
  final String _user = 'test';
  final String _pass = 'test2023';

  Future<List<Proveedor>> fetchProveedores() async {
    final url = Uri.http(_baseUrl, 'ejemplos/provider_list_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));

    final response = await http.get(url, headers: {'authorization': basicAuth});
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final List<dynamic> proveedoresListJson =
          responseData['Proveedores Listado'];

      // Convertir la lista de JSON a lista de objetos Proveedor
      List<Proveedor> proveedorList = proveedoresListJson
          .map((jsonItem) => Proveedor.fromMap(jsonItem))
          .toList();

      return proveedorList;
    } else {
      throw Exception('Failed to load providers');
    }
  }

  // EDITAR PROVEEDOR
  Future<void> editarProveedor(ProveedorEdit proveedor) async {
    // Construir la URL del endpoint
    final url = Uri.http(_baseUrl, 'ejemplos/provider_edit_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));

    // Convertir el objeto Categoria a JSON
    final proveedorJson = proveedor.toMap();

    try {
      // Realizar la solicitud POST al servidor con la autenticación básica y el cuerpo JSON
      final response = await http.post(
        url,
        body: jsonEncode(proveedorJson), // Convertir el objeto JSON a String
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

  // ELIMINAR PROVEEDOR
  Future<void> eliminarProveedor(ProveedorDel proveedor) async {
    // Construir la URL del endpoint
    final url = Uri.http(_baseUrl, 'ejemplos/provider_del_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));

    // Convertir el objeto Categoria a JSON
    final proveedorJson = proveedor.toMap();

    try {
      // Realizar la solicitud POST al servidor con la autenticación básica y el cuerpo JSON
      final response = await http.post(
        url,
        body: jsonEncode(proveedorJson), // Convertir el objeto JSON a String
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
