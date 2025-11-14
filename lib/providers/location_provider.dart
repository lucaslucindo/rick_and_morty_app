import 'package:flutter/material.dart';
import '../models/location.dart';
import '../models/character.dart';
import '../services/api_service.dart';

class LocationProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Location> _locations = [];
  List<Character> _residents = [];
  bool _isLoading = false;
  bool _isLoadingResidents = false;
  String? _error;
  int _currentPage = 1;
  int _totalPages = 1;

  List<Location> get locations => _locations;
  List<Character> get residents => _residents;
  bool get isLoading => _isLoading;
  bool get isLoadingResidents => _isLoadingResidents;
  String? get error => _error;
  bool get hasMorePages => _currentPage < _totalPages;

  // Carregar localizações
  Future<void> loadLocations({bool refresh = false}) async {
    if (refresh) {
      _currentPage = 1;
      _locations = [];
    }

    if (_isLoading) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _apiService.getLocations(page: _currentPage);

      if (refresh) {
        _locations = response.results;
      } else {
        _locations.addAll(response.results);
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

  // Carregar residentes de uma localização
  Future<void> loadResidents(Location location) async {
    _isLoadingResidents = true;
    _residents = [];
    notifyListeners();

    try {
      if (location.residents.isEmpty) {
        _residents = [];
      } else {
        final residentIds = location.residents
            .map((url) => _apiService.getIdFromUrl(url))
            .toList();

        _residents = await _apiService.getCharactersByIds(residentIds);
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoadingResidents = false;
      notifyListeners();
    }
  }
}
