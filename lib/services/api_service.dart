import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character.dart';
import '../models/location.dart';
import '../models/api_response.dart';

class ApiService {
  static const String baseUrl = 'https://rickandmortyapi.com/api';

  // Buscar personagens com paginação
  Future<ApiResponse<Character>> getCharacters({int page = 1}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/character?page=$page'),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return ApiResponse.fromJson(
          jsonData,
          (json) => Character.fromJson(json),
        );
      } else {
        throw Exception('Falha ao carregar personagens');
      }
    } catch (e) {
      throw Exception('Erro na conexão: $e');
    }
  }

  // Buscar personagem específico por ID
  Future<Character> getCharacterById(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/character/$id'));

      if (response.statusCode == 200) {
        return Character.fromJson(json.decode(response.body));
      } else {
        throw Exception('Falha ao carregar personagem');
      }
    } catch (e) {
      throw Exception('Erro na conexão: $e');
    }
  }

  // Buscar múltiplos personagens por IDs
  Future<List<Character>> getCharactersByIds(List<int> ids) async {
    if (ids.isEmpty) return [];

    try {
      final idsString = ids.join(',');
      final response = await http.get(
        Uri.parse('$baseUrl/character/$idsString'),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData is List) {
          return jsonData.map((item) => Character.fromJson(item)).toList();
        } else {
          return [Character.fromJson(jsonData)];
        }
      } else {
        throw Exception('Falha ao carregar personagens');
      }
    } catch (e) {
      throw Exception('Erro na conexão: $e');
    }
  }

  // Buscar localizações com paginação
  Future<ApiResponse<Location>> getLocations({int page = 1}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/location?page=$page'),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return ApiResponse.fromJson(
          jsonData,
          (json) => Location.fromJson(json),
        );
      } else {
        throw Exception('Falha ao carregar localizações');
      }
    } catch (e) {
      throw Exception('Erro na conexão: $e');
    }
  }

  // Extrair ID da URL
  int getIdFromUrl(String url) {
    return int.parse(url.split('/').last);
  }
}
