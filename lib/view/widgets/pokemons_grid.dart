import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokeapi/bloc/pokemon_bloc.dart';
import 'package:pokeapi/model/pokemon.dart';
import 'package:pokeapi/view/widgets/pokemon_item.dart';

class PokemonGrid extends StatefulWidget {
  const PokemonGrid(
    this.pokemonList, {
    super.key,
  });
  final List<Pokemon> pokemonList;

  @override
  State<PokemonGrid> createState() => _PokemonsGridState();
}

class _PokemonsGridState extends State<PokemonGrid> {
  final _scrollController = ScrollController();

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void initState() {
    _scrollController.addListener(() => _onScroll(context));
    super.initState();
  }

  _onScroll(BuildContext context) {
    if (_isBottom) {
      context.read<PokemonBloc>().add(const PokemonEvent.load());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        childAspectRatio: 0.8,
        mainAxisSpacing: 10,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      itemCount: widget.pokemonList.length,
      itemBuilder: (context, index) =>
          PokemonItem(pokemon: widget.pokemonList[index]),
      controller: _scrollController,
    );
  }
}
