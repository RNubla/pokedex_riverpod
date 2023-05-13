import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex_riverpod/models/pokemon_model.dart';
import 'package:pokedex_riverpod/stores/pokemon_store.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage());
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // AsyncValue<Pokemon> pokemon = ref.watch(pokemonStateFuture);
    AsyncValue<List<Pokemon>> pokemons = ref.watch(pokemonListStateFuture);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.fromLTRB(35, 35, 35, 0),
        child: Column(
          children: [
            const Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Pokedex',
                      style: TextStyle(
                          fontSize: 50,
                          height: 1.5,
                          fontWeight: FontWeight.w800),
                    ),
                    Text(
                      'Search for a Pokemon by name or using its National Pokemon number',
                      style: TextStyle(
                          fontSize: 15,
                          height: 1.5,
                          fontWeight: FontWeight.w400),
                    ),
                    TextField(
                      textInputAction: TextInputAction.go,
                      decoration: InputDecoration(
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 0.0),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            size: 30,
                          ),
                          label: Text('Type Pokemon name here')),
                    )
                  ],
                )),
            Expanded(
              flex: 2,
              child: pokemons.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (err, stack) => Center(child: Text(err.toString())),
                data: (pokemons) {
                  return GridView.count(
                    crossAxisCount: 2,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: (1 / 1.5),
                    children: List.generate(
                        pokemons.length,
                        (index) => Center(
                              child: Container(
                                color: Colors.amberAccent.shade100,
                                constraints: const BoxConstraints.expand(),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Image.network(
                                        pokemons[index]
                                            .sprites!
                                            .frontDefault
                                            .toString(),
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Text(
                                          pokemons[index]
                                                  .name
                                                  .toString()[0]
                                                  .toUpperCase() +
                                              pokemons[index]
                                                  .name
                                                  .toString()
                                                  .substring(1)
                                                  .toLowerCase(),
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ))
                                  ],
                                ),
                              ),
                            )),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
