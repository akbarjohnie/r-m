import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/data/models/character/character.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.status,
    required this.originName,
    this.onFavoriteTap,
    this.isFavorite = false,
    super.key,
  });

  factory CharacterCard.fromModel({
    required CharacterModel model,
    required ValueChanged<int> onFavoriteTap,
    bool isFavorite = false,
  }) =>
      CharacterCard(
        id: model.id,
        imageUrl: model.image,
        name: model.name,
        originName: model.origin.name,
        status: model.status,
        onFavoriteTap: onFavoriteTap,
        isFavorite: isFavorite,
      );

  final int id;

  final String imageUrl;
  final String name;
  final String status;
  final String originName;

  final ValueChanged<int>? onFavoriteTap;

  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      key: ValueKey('CharacterCard: $id'),
      borderRadius: const BorderRadius.all(Radius.circular(24)),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.grey,
        ),
        child: Stack(
          alignment: AlignmentGeometry.topCenter,
          children: [
            Column(
              spacing: 4,
              children: [
                CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.contain,
                ),
                Text(name),
                Text(status),
                Text(originName),
              ],
            ),
            Positioned(
              right: 20,
              bottom: 20,
              child: IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: Colors.grey[400],
                ),
                onPressed: () => onFavoriteTap?.call(id),
                icon: Icon(
                  isFavorite ? Icons.add : Icons.add_outlined,
                  color: Colors.deepPurple,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
