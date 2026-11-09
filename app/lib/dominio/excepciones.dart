/// Errores con nombre propio: la pantalla decide qué mensaje mostrar.
class SinConexionException implements Exception {
  @override
  String toString() =>
      'No se pudo conectar con el servidor. ¿Está encendida la API y estás en la misma red?';
}
 
class ErrorServidorException implements Exception {
  final int codigo;
  ErrorServidorException(this.codigo);
  @override
  String toString() => codigo == 404
      ? 'No se encontró lo que buscabas (404).'
      : codigo == 400
          ? 'El servidor rechazó los datos enviados (400).'
          : 'El servidor respondió con error ($codigo).';
}
 
class RespuestaInvalidaException implements Exception {
  @override
  String toString() => 'El servidor respondió algo que no entiendo.';
}
