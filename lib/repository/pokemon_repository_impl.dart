import 'package:injectable/injectable.dart';
import 'package:pokeapi/data/pokemon_api.dart';
import 'package:pokeapi/model/pokemon.dart';
import 'package:pokeapi/repository/pokemon_repository.dart';
import 'package:rxdart/subjects.dart';

@LazySingleton(as: PokemonRepository)
class PokemonRepositoryImpl implements PokemonRepository {
  	final PokemonApi _pokemonApi;

	PokemonRepositoryImpl(this._pokemonApi); 

  final _pokemonStreamController = BehaviorSubject<List<Pokemon>>();
  int offset = 0;
  static const int limit = 100;
  bool hasReachedMax = false;

  @override 
  Future<void> loadMorePokemon() async{
   if (hasReachedMax) return;
    try{
      final response = await _pokemonApi.getPokemonList(offset: offset, limit: limit);
      if(response.results == null){
        _pokemonStreamController.addError('No data');
        return;
      }
      final pokemonList = response.results ?? [];
      final currentList = _pokemonStreamController.hasValue ? _pokemonStreamController.value : [];
      offset += limit;
      hasReachedMax = pokemonList.length < limit;
      _pokemonStreamController.add([...currentList, ...pokemonList]);
    
    }catch(e){
      _pokemonStreamController.addError(e);
    }


  }


  @override 
  Stream<List<Pokemon>> get getPokemonList => _pokemonStreamController.stream;
 
 
	// Future<List<Pokemon>> fetchPokemonList()async {
	// 	final response = await _pokemonApi.getPokemonList();
  //    return response.results ?? [];
	// }
}