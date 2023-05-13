import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex_riverpod/models/pokemon_model.dart';
import 'package:pokedex_riverpod/services/api_service.dart';

final pokemonStateFuture = FutureProvider<Pokemon>((ref) async {
  return fetchPokemon('https://pokeapi.co/api/v2/pokemon/ralts');
});

final pokemonListStateFuture = FutureProvider<List<Pokemon>>((ref) async {
  List<Pokemon> pokemons = [];
  for (var i = 1; i <= 16; i++) {
    await fetchPokemon('https://pokeapi.co/api/v2/pokemon/$i')
        .then((pokemon) => pokemons.add(pokemon));
  }
  return pokemons;
});
