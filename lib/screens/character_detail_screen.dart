import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/character.dart';
import '../providers/favorites_provider.dart';

class CharacterDetailScreen extends StatelessWidget {
  final Character character;

  const CharacterDetailScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
        backgroundColor: Colors.blue,
        actions: [
          Consumer<FavoritesProvider>(
            builder: (context, provider, child) {
              final isFavorite = provider.isFavorite(character.id);
              return IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.white,
                ),
                onPressed: () {
                  provider.toggleFavorite(character);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isFavorite
                            ? 'Removido dos favoritos'
                            : 'Adicionado aos favoritos',
                      ),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: 'character-${character.id}',
              child: CachedNetworkImage(
                imageUrl: character.image,
                height: 300,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildInfoRow(
                    'Status',
                    character.status,
                    _getStatusColor(character.status),
                  ),
                  _buildInfoRow('Espécie', character.species, Colors.black87),
                  _buildInfoRow('Gênero', character.gender, Colors.black87),
                  _buildInfoRow(
                    'Origem',
                    character.origin.name,
                    Colors.black87,
                  ),
                  _buildInfoRow(
                    'Localização Atual',
                    character.location.name,
                    Colors.black87,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, Color valueColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: valueColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'alive':
        return Colors.green;
      case 'dead':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
