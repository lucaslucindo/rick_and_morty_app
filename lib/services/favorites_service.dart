import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/character.dart';

class FavoritesService {
  static const String _favoritesKey = 'favorites';

  // Salvar favoritos
  Future<void> saveFavorites(List<Character> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = favorites.map((char) => char.toJson()).toList();
    await prefs.setString(_favoritesKey, json.encode(favoritesJson));
  }

  // Carregar favoritos
  Future<List<Character>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesString = prefs.getString(_favoritesKey);

    if (favoritesString == null) return [];

    final List<dynamic> favoritesJson = json.decode(favoritesString);
    return favoritesJson.map((json) => Character.fromJson(json)).toList();
  }

  // Adicionar favorito
  Future<void> addFavorite(Character character) async {
    final favorites = await loadFavorites();
    if (!favorites.any((fav) => fav.id == character.id)) {
      favorites.add(character);
      await saveFavorites(favorites);
    }
  }

  // Remover favorito
  Future<void> removeFavorite(int characterId) async {
    final favorites = await loadFavorites();
    favorites.removeWhere((fav) => fav.id == characterId);
    await saveFavorites(favorites);
  }

  // Verificar se é favorito
  Future<bool> isFavorite(int characterId) async {
    final favorites = await loadFavorites();
    return favorites.any((fav) => fav.id == characterId);
  }
}
