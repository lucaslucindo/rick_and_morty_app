import 'package:flutter/material.dart';
import '../models/character.dart';
import '../services/favorites_service.dart';

class FavoritesProvider with ChangeNotifier {
  final FavoritesService _favoritesService = FavoritesService();

  List<Character> _favorites = [];
  bool _isLoading = false;

  List<Character> get favorites => _favorites;
  bool get isLoading => _isLoading;

  // Carregar favoritos
  Future<void> loadFavorites() async {
    _isLoading = true;
    notifyListeners();

    _favorites = await _favoritesService.loadFavorites();

    _isLoading = false;
    notifyListeners();
  }

  // Adicionar favorito
  Future<void> addFavorite(Character character) async {
    await _favoritesService.addFavorite(character);
    await loadFavorites();
  }

  // Remover favorito
  Future<void> removeFavorite(int characterId) async {
    await _favoritesService.removeFavorite(characterId);
    await loadFavorites();
  }

  // Verificar se é favorito
  bool isFavorite(int characterId) {
    return _favorites.any((fav) => fav.id == characterId);
  }

  // Toggle favorito
  Future<void> toggleFavorite(Character character) async {
    if (isFavorite(character.id)) {
      await removeFavorite(character.id);
    } else {
      await addFavorite(character);
    }
  }
}
