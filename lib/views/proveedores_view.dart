import 'package:flutter/material.dart';
import 'package:flutter_api_1/widgets/cardproveedores_widget.dart';
import '../widgets/widget.dart';

class ProveedoresView extends StatelessWidget {
  const ProveedoresView({super.key});
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(top: 30, bottom: 25, left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Proveedores',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 25),
                //  Cards Proveedores
                CardProveedoresWidget()
              ],
            )));
  }
}
