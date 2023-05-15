import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex_riverpod/stores/pokemon_store.dart';
import 'package:pokedex_riverpod/utils/string_transformation.dart';

import '../models/pokemon_model.dart';

final selectedTabIndexProvider = StateProvider((ref) => 0);
final tabTitles = ['Test', 'Sample', '1', '2', '3', '4', '5', '6', '7'];

class PokemonPage extends ConsumerStatefulWidget {
  const PokemonPage({super.key});

  @override
  _PokemonPageState createState() => _PokemonPageState();
}

class _PokemonPageState extends ConsumerState<PokemonPage>
    with TickerProviderStateMixin {
  // late final Pokemon pokemon;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    final selectedTabIndex = ref.read(selectedTabIndexProvider);
    _tabController = TabController(length: tabTitles.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    String name = ModalRoute.of(context)!.settings.arguments.toString();
    AsyncValue<Pokemon> pokemon = ref.watch(getPokemonStateFuture(name));

    final tabs = pokemon.when(data: (data) {return } , error: error, loading: loading)

    String pokemonName = StringTransform(
            inputString: ModalRoute.of(context)!.settings.arguments.toString())
        .capitalizeFirstWord();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        title: Text(
          pokemonName,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
        ),
        leading: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(35, 35, 35, 35),
        child: Column(
          children: [
            Expanded(
                flex: 2,
                child: pokemon.when(
                    data: (pokemon) {
                      return Image.network(
                        pokemon.sprites!.frontDefault.toString(),
                        fit: BoxFit.cover,
                      );
                    },
                    error: (err, stack) => Center(
                          child: Text(err.toString()),
                        ),
                    loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ))),
            Expanded(
              flex: 0,
              child: TabBar(
                  isScrollable: true,
                  controller: _tabController,
                  tabs: tabs.map((e) => Tab(text: e)).toList()),
            ),
            Expanded(
              flex: 1,
              child: TabBarView(
                  controller: _tabController,
                  children:
                      tabTitles.map((e) => Center(child: Text(e))).toList()),
            ),
            Expanded(flex: 1, child: Text('Mega'))
          ],
        ),
      ),
    );
  }
}
