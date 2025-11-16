import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/location.dart';
import '../providers/location_provider.dart';
import '../widgets/character_card.dart';
import '../widgets/loading_widget.dart';
import 'character_detail_screen.dart';

class LocationResidentsScreen extends StatefulWidget {
  final Location location;

  const LocationResidentsScreen({super.key, required this.location});

  @override
  State<LocationResidentsScreen> createState() =>
      _LocationResidentsScreenState();
}

class _LocationResidentsScreenState extends State<LocationResidentsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LocationProvider>().loadResidents(widget.location);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.location.name),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.orange.shade50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.location.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tipo: ${widget.location.type}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Dimensão: ${widget.location.dimension}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Residentes: ${widget.location.residents.length}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<LocationProvider>(
              builder: (context, provider, child) {
                if (provider.isLoadingResidents) {
                  return const LoadingWidget();
                }

                if (provider.residents.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.people_outline,
                          size: 80,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Nenhum residente conhecido',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: provider.residents.length,
                  itemBuilder: (context, index) {
                    final character = provider.residents[index];
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
          ),
        ],
      ),
    );
  }
}
