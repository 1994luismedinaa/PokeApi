import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pokeapi/bloc/pokemon_bloc.dart';
import 'package:pokeapi/view/widgets/pokemons_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon'),
      ),
      body: BlocProvider(
        create: (context) {
          return GetIt.I.get<PokemonBloc>()
            ..add(const PokemonEvent.listenPokemonList())
            ..add(const PokemonEvent.load());
        },
        child: Stack(
          children: [
            BlocBuilder<PokemonBloc, PokemonState>(
              buildWhen: (previous, current) => current != const LoadInProgress(),
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () => const SizedBox.shrink(),
                  // loadInProgress: () => const Center(child: CircularProgressIndicator()),
                  loadSuccess: PokemonGrid.new,
                  // equivalente a:
                  // loadSuccess: (items) => PokemonsGrid(items),
                  loadFailure: () => const Center(child: Text('Failed to load data')),
                );
              },
            ),
            BlocBuilder<PokemonBloc, PokemonState>(
              builder: (context, state) {
                if (state is LoadInProgress) {
                  return const Center(child: CircularProgressIndicator());
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
