import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:pokeapi/model/pokemon.dart';

class PokemonItem extends StatelessWidget {
  const PokemonItem({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        // border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
          ),
        ],
      ),
      child: ListTile(
        title: Row(
          children: [
            BadgeNumber(pokemon.pokemonId.toString()),
            Text(pokemon.name ?? ''),
          ],
        ),
        subtitle: pokemon.image != null
            ? Image(
                image: CachedNetworkImageProvider(pokemon.image!),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}

class BadgeNumber extends StatelessWidget {
  const BadgeNumber(this.number, {super.key});
  final String number;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(number, style: const TextStyle(color: Colors.white)),
          )),
    );
  }
}
