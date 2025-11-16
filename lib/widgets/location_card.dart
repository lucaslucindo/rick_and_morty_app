import 'package:flutter/material.dart';
import '../models/location.dart';

class LocationCard extends StatelessWidget {
  final Location location;
  final VoidCallback onTap;

  const LocationCard({super.key, required this.location, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        onTap: onTap,
        leading: const CircleAvatar(
          backgroundColor: Colors.blue,
          child: Icon(Icons.location_on, color: Colors.white),
        ),
        title: Text(
          location.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          '${location.type} • ${location.residents.length} residentes',
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}
