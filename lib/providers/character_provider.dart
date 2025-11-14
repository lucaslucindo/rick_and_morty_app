import 'package:flutter/material.dart';
import '../models/character.dart';
import '../services/api_service.dart';

class CharacterProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Character> _characters = [];
  bool _isLoading = false;
  String? _error;
  int _currentPage = 1;
  int _totalPages = 1;

  List<Character> get characters => _characters;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasMorePages => _currentPage < _totalPages;

  // Carregar personagens
  Future<void> loadCharacters({bool refresh = false}) async {
    if (refresh) {
      _currentPage = 1;
      _characters = [];
    }

    if (_isLoading) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _apiService.getCharacters(page: _currentPage);

      if (refresh) {
        _characters = response.results;
      } else {
        _characters.addAll(response.results);
      }

      _totalPages = response.info.pages;
      _currentPage++;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Buscar personagem por ID
  Future<Character?> getCharacterById(int id) async {
    try {
      return await _apiService.getCharacterById(id);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return null;
    }
  }
}
