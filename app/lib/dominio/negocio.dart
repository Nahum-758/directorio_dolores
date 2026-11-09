class Negocio {
  final int? id;
  final String nombre;
  final String categoria;
  final String telefono;
  final bool favorito;

  const Negocio({
    this.id,
    required this.nombre,
    required this.categoria,
    this.telefono = '',
    this.favorito = false,
  });

  factory Negocio.desdeJson(Map<String, dynamic> json) => Negocio(
        id: json['id'] as int?,
        nombre: json['nombre'] as String,
        categoria: json['categoria'] as String,
        telefono: (json['telefono'] as String?) ?? '',
        favorito: (json['favorito'] as bool?) ?? false,
      );

  Map<String, dynamic> aJson() => {
        if (id != null) 'id': id,
        'nombre': nombre,
        'categoria': categoria,
        'telefono': telefono,
        'favorito': favorito,
      };

  Negocio copiarCon({bool? favorito}) => Negocio(
        id: id,
        nombre: nombre,
        categoria: categoria,
        telefono: telefono,
        favorito: favorito ?? this.favorito,
      );
}