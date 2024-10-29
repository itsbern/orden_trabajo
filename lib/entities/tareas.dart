import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Tarea>> fetchTareas() async {
  final url = Uri.parse('https://teknia.app/api3/obtener_planes_trabajo_por_orden/10');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => Tarea.fromJson(json)).toList();
  } else {
    throw Exception('Error al cargar las tareas');
  }
}

class Tarea {
  final int id;
  final String titulo;
  final String categoria;
  final String? objetivo;
  final int tiempoEstimado;
  final int posicion;
  final int noFormulario;
  bool completada;
  final DateTime fechaCreacion;

  // Nuevos campos para guardar datos de los formularios
  String? componente;      // Nombre del componente o equipo limpiado
  String? estatus;          // Estado del trabajo realizado
  String? opcionDanio;      // Opción seleccionada para daño
  String? estadoEstetico;   // Estado estético
  String? fueraDeRango;     // ¿Está fuera de rango?
  double? limiteSuperior;   // Límite superior (numérico)
  double? limiteInferior;   // Límite inferior (numérico)
  String? unidadMedida;     // Unidad de medida
  String? estadoConexion;
  String? incompleto;  
  String? estadoCalibracion;
  String? estadoDesgaste;
  String? estadoFugas; // Estado de las fugas
  


  Tarea({
    required this.id,
    required this.titulo,
    required this.categoria,
    this.objetivo,
    this.tiempoEstimado = 0,
    required this.posicion,
    required this.noFormulario,
    this.completada = false,
    required this.fechaCreacion,
    this.componente,
    this.estatus,
    this.opcionDanio,
    this.estadoEstetico,
    this.fueraDeRango,
    this.limiteSuperior,
    this.limiteInferior,
    this.unidadMedida,
    this.estadoConexion,
    this.incompleto,
    this.estadoCalibracion,
    this.estadoDesgaste,
    this.estadoFugas,
  });

  // Deserialización de JSON a Tarea.
  factory Tarea.fromJson(Map<String, dynamic> json) {
    return Tarea(
      id: json['id'],
      titulo: json['titulo'],
      categoria: json['clasificacion'],
      objetivo: json['objetivo'],
      tiempoEstimado: json['tiempo_estimado'] ?? 0,
      posicion: json['posicion'],
      noFormulario: json['no_formulario'],
      completada: json['completada'] ?? false,
      fechaCreacion: DateTime.parse(json['fecha_creacion']),
      componente: json['componente'],
      estatus: json['estatus'],
      opcionDanio: json['opcion_danio'],
      estadoEstetico: json['estado_estetico'],
      fueraDeRango: json['fuera_de_rango'],
      limiteSuperior: (json['limite_superior'] != null)
          ? double.parse(json['limite_superior'].toString())
          : null,
      limiteInferior: (json['limite_inferior'] != null)
          ? double.parse(json['limite_inferior'].toString())
          : null,
      unidadMedida: json['unidad_medida'],
      estadoConexion: json['estado_conexion'],
      incompleto: json['incompleto'],
      estadoCalibracion: json['estado_calibracion'],
      estadoDesgaste: json['estado_desgaste'],
       estadoFugas: json['estado_fugas'],
    );
  }

  // Serialización de Tarea a JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'clasificacion': categoria,
      'objetivo': objetivo,
      'tiempo_estimado': tiempoEstimado,
      'posicion': posicion,
      'no_formulario': noFormulario,
      'completada': completada,
      'fecha_creacion': fechaCreacion.toIso8601String(),
      'componente': componente,
      'estatus': estatus,
      'opcion_danio': opcionDanio,
      'estado_estetico': estadoEstetico,
      'fuera_de_rango': fueraDeRango,
      'limite_superior': limiteSuperior,
      'limite_inferior': limiteInferior,
      'unidad_medida': unidadMedida,
      'estado_conexion': estadoConexion,
      'incompleto': incompleto,
      'estado_calibracion': estadoCalibracion,
       'estado_fugas': estadoFugas,
    };
  }
}
