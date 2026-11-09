import 'dart:async';
import 'dart:convert';
import 'dart:io';
 
import 'package:http/http.dart' as http;
 
import '../dominio/excepciones.dart';
import '../dominio/negocio.dart';
 
class NegociosApi {
  final http.Client _cliente;
  final String baseUrl;
  final Duration espera;
 
  NegociosApi(this._cliente, this.baseUrl,
      {this.espera = const Duration(seconds: 5)});
 
  Uri _uri(String ruta) => Uri.parse('$baseUrl$ruta');
  static const _json = {'Content-Type': 'application/json'};
 
  Future<List<Negocio>> listar({String busqueda = ''}) async {
    final r = await _ejecutar(() => _cliente
        .get(_uri('/negocios${busqueda.isEmpty ? '' : '?q=${Uri.encodeQueryComponent(busqueda)}'}')));
    try {
      final lista = jsonDecode(r.body) as List;
      return lista
          .map((e) => Negocio.desdeJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      throw RespuestaInvalidaException();
    }
  }
 
  Future<Negocio> crear(Negocio n) async {
    final r = await _ejecutar(() =>
        _cliente.post(_uri('/negocios'), headers: _json, body: jsonEncode(n.aJson())));
    return _leerUno(r);
  }
 
  Future<Negocio> actualizar(Negocio n) async {
    final r = await _ejecutar(() => _cliente.put(_uri('/negocios/${n.id}'),
        headers: _json, body: jsonEncode(n.aJson())));
    return _leerUno(r);
  }
 
  Future<void> eliminar(int id) async {
    await _ejecutar(() => _cliente.delete(_uri('/negocios/$id')));
  }
 
  Negocio _leerUno(http.Response r) {
    try {
      return Negocio.desdeJson(jsonDecode(r.body) as Map<String, dynamic>);
    } catch (_) {
      throw RespuestaInvalidaException();
    }
  }
 
  /// Un solo lugar donde se traducen los fallos técnicos a errores del negocio.
  Future<http.Response> _ejecutar(Future<http.Response> Function() peticion) async {
    http.Response r;
    try {
      r = await peticion().timeout(espera);
    } on SocketException {
      throw SinConexionException();
    } on TimeoutException {
      throw SinConexionException();
    } on http.ClientException {
      throw SinConexionException();
    }
    if (r.statusCode < 200 || r.statusCode >= 300) {
      throw ErrorServidorException(r.statusCode);
    }
    return r;
  }
}
