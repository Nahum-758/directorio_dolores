import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'datos/config_api.dart';
import 'datos/negocios_api.dart';
import 'presentacion/negocios_viewmodel.dart';
import 'presentacion/pantalla_negocios.dart';
 
void main() {
  final api = NegociosApi(http.Client(), urlBaseApi()); // composition root
  runApp(MaterialApp(
    title: 'Directorio Dolores',
    theme: ThemeData(colorSchemeSeed: Colors.deepOrange, useMaterial3: true),
    home: PantallaNegocios(vm: NegociosViewModel(api)),
  ));
}
