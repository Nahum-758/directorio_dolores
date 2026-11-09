import 'package:flutter/foundation.dart';
import '../datos/negocios_api.dart';
import '../dominio/negocio.dart';
 
enum Estado { inicial, cargando, listo, vacio, error }
 
class NegociosViewModel extends ChangeNotifier {
  final NegociosApi api;
  Estado estado = Estado.inicial;
  List<Negocio> negocios = [];
  String? mensajeError;
 
  NegociosViewModel(this.api);
 
  Future<void> cargar({String busqueda = ''}) async {
    estado = Estado.cargando;
    mensajeError = null;
    notifyListeners();
    try {
      negocios = await api.listar(busqueda: busqueda);
      estado = negocios.isEmpty ? Estado.vacio : Estado.listo;
    } catch (e) {
      mensajeError = e.toString();
      estado = Estado.error;
    }
    notifyListeners();
  }
 
  Future<void> agregar(Negocio n) async {
    try {
      await api.crear(n);
      await cargar();
    } catch (e) {
      mensajeError = e.toString();
      estado = Estado.error;
      notifyListeners();
    }
  }
 
  Future<void> eliminar(Negocio n) async {
    try {
      await api.eliminar(n.id!);
      negocios = negocios.where((x) => x.id != n.id).toList();
      estado = negocios.isEmpty ? Estado.vacio : Estado.listo;
    } catch (e) {
      mensajeError = e.toString();
      estado = Estado.error;
    }
    notifyListeners();
  }
 
  Future<void> alternarFavorito(Negocio n) async {
    try {
      final nuevo = await api.actualizar(n.copiarCon(favorito: !n.favorito));
      negocios = [for (final x in negocios) x.id == nuevo.id ? nuevo : x];
    } catch (e) {
      mensajeError = e.toString();
    }
    notifyListeners();
  }
}
