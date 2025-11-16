import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';
import '../widgets/character_card.dart';
import '../widgets/loading_widget.dart';
import 'character_detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FavoritesProvider>().loadFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
        backgroundColor: Colors.red,
      ),
      body: Consumer<FavoritesProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const LoadingWidget();
          }

          if (provider.favorites.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Nenhum favorito ainda',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Adicione personagens aos favoritos',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: provider.favorites.length,
            itemBuilder: (context, index) {
              final character = provider.favorites[index];
              return CharacterCard(
                character: character,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CharacterDetailScreen(character: character),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
