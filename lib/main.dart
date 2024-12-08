import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext(){
    current = WordPair.random();
    notifyListeners();
  }
  var favorites = <WordPair>[];

  void Favoritar() {
    if(favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;


}
  @override

  Widget build(BuildContext context) {
  Widget page:
  switch (selectedIndex) {
    case 0:
      page = GeneratorPage();
      break;
    case 1:
      page = FavoritePage();
      break;
    default:
      throw UnimplementedError('Nenhuma página selecionada para $selectedIndex');
  }
    return Scaffold(
      body: Row(
        children: [
          SafeArea(
            child: NavigationRail(
              extended: false,
              destinations: [
                NavigationRailDestination(
                icon: Icon(Icons.home),
                    label: Text("Principal"),
                    NavigationRailDestination(
                      icon: Icon(Icons.favorite),
                        label: Text('Favoritos'))
      );
                selectedIndex: selectedIndex,
                onDestinationSelected: (value),{
                setState(){
                  selectedIndex = value;

    },
    },

                ].
            ),

          ),
    Expanded(
    child: Container(
    color: Theme.of(context).colorScheme.primaryContainer,
    child: GeneratorPage(),

    ),

    ),

          ],
      ),
    );

  }
//   Widget build(BuildContext context) {
//
//   }
 }

 class GeneratorPage extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
     var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    }else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text('Meu primeiro app Flutter:'),
      BigCard(pair: pair),
      Row(
          mainAxisAlignment: MainAxisAlignment.mim,
          children: [
          ElevatedButton(
          onPressed: (){
    appState.getNext();
    //print("Botão foi pressionado.");
    },
      child:Text("Próxima"),

    ),
     SizedBox(width: 10),
     ElevatedButton.icon(
     onPressed: (){
     appState.Favoritar();
     }
     label: Text('Favoritar')),
     icon: Icon(icon),
     ),],
      )
    ),
   }
 }


class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(color: theme.colorScheme.onPrimary,);

  }
    return Card(
      color: theme.colorScheme.primary,
  child: Padding(
  padding: const EdgeInsets.all(20),
  child: Text(
  pair.asLowerCase,
  style:style,
  semanticsLabel: "${pair.first} ${pair.second}",
  )
  )

    )


  }
}

class FavoritePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty) {
      return Center(
      child: Text('Nenhuma dupla de palavras foi favoritada'),
      );


    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('Você possui ${appState.favorites.length} favoritos'),
        ),
        for (var wordpair in appState.favorites)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(wordpair.asLowerCase),

          )

        ],

    )

  }
}
}