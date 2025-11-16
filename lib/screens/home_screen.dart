import 'package:flutter/material.dart';
import 'characters_screen.dart';
import 'locations_screen.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guia Rick and Morty'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.emoji_people, size: 100, color: Colors.green),
            const SizedBox(height: 20),
            const Text(
              'Guia Rick and Morty',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Explore personagens e locais do universo de Rick and Morty',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 40),
            _buildNavigationButton(
              context,
              'Personagens',
              Icons.people,
              Colors.blue,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CharactersScreen(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildNavigationButton(
              context,
              'Locais',
              Icons.location_on,
              Colors.orange,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LocationsScreen(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildNavigationButton(
              context,
              'Favoritos',
              Icons.favorite,
              Colors.red,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoritesScreen(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButton(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
