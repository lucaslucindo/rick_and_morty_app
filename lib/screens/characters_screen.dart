import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/character_provider.dart';
import '../widgets/character_card.dart';
import '../widgets/loading_widget.dart';
import 'character_detail_screen.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CharacterProvider>().loadCharacters(refresh: true);
    });

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      final provider = context.read<CharacterProvider>();
      if (provider.hasMorePages && !provider.isLoading) {
        provider.loadCharacters();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personagens'),
        backgroundColor: Colors.blue,
      ),
      body: Consumer<CharacterProvider>(
        builder: (context, provider, child) {
          if (provider.characters.isEmpty && provider.isLoading) {
            return const LoadingWidget();
          }

          if (provider.error != null && provider.characters.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 60, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Erro: ${provider.error}', textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => provider.loadCharacters(refresh: true),
                    child: const Text('Tentar novamente'),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => provider.loadCharacters(refresh: true),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: provider.characters.length + 1,
              itemBuilder: (context, index) {
                if (index == provider.characters.length) {
                  return provider.isLoading
                      ? const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: LoadingWidget(),
                        )
                      : const SizedBox.shrink();
                }

                final character = provider.characters[index];
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
            ),
          );
        },
      ),
    );
  }
}
