import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pokeapi/repository/pokemon_repository.dart';
import 'package:pokeapi/model/pokemon.dart';
 
part 'pokemon_state.dart';
part 'pokemon_event.dart';
part 'pokemon_bloc.freezed.dart';
 
@injectable
class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  PokemonBloc(this._pokemonRepository) : super(const PokemonState.initial()) {
    on<_Load>(_onLoad);
    on<_ListenPokemonList>(_onListenPokemonList);
  }
  final PokemonRepository _pokemonRepository;
 
 
  Future<void> _onLoad(_Load event, Emitter<PokemonState> emit) async {
    if (state is LoadInProgress) return;

    emit(const PokemonState.loadInProgress());
    _pokemonRepository.loadMorePokemon();
    // emit(const HomeState.loadInProgress());
    // try {
    //   final pokemonList = await _pokemonRepository.getPokemonList();
    //   emit(HomeState.loadSuccess(pokemonList));
    // } catch (e) {
    //   emit(const HomeState.loadFailure());
    // }
  }


    Future<void> _onListenPokemonList(_ListenPokemonList event, Emitter<PokemonState> emit) async {
    await emit.forEach<List<Pokemon>>(
      _pokemonRepository.getPokemonList,
      onData: PokemonState.loadSuccess,
      onError: (error, stackTrace) => const PokemonState.loadFailure(),
    );
  }
}