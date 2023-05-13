import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:pokedex_riverpod/models/pokemon_model.dart';

Pokemon parsePokemon(String responseBody) {
  var poke = json.decode(responseBody) as dynamic;
  Pokemon pokemon = Pokemon.fromJson(poke);
  return pokemon;
}

Future<Pokemon> fetchPokemon(String url) async {
  final response = await get(Uri.parse(url));
  if (response.statusCode == 200) {
    return compute(parsePokemon, response.body);
  } else {
    throw Exception('Cannot fetch Pokemon');
  }
}
