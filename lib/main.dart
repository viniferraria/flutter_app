import 'package:english_words/english_words.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.indigoAccent[100],
        primaryColorDark: Colors.tealAccent,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.tealAccent,
      ),
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}



class RandomWordsState extends State<RandomWords> {
  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Startup Name Generator'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
          ],
      ),
      body: _buildSuggestions(),
      );
    
  }
  
    final List<WordPair> _suggestions = <WordPair>[];
    final Set<WordPair> _saved = Set<WordPair>();
    final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);
      
    void _pushSaved(){
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (BuildContext context) {
            final Iterable<ListTile> tiles = _saved.map(
              (WordPair pair) {
                return ListTile(
                  title: Text(
                    pair.asPascalCase,
                    style: _biggerFont,
                  ),
                );
              },
            );
            final List<Widget> divided = ListTile
              .divideTiles(
                context: context,
                tiles: tiles,
              )
              .toList();
            
            return Scaffold(
              backgroundColor: Colors.grey,
              appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
            );
          },
        ),
      );
    }


    Widget _buildRow(WordPair pair) {
      final bool alreadySaved = _saved.contains(pair);
      return ListTile(
        title: Text(
          pair.asPascalCase,
          style: _biggerFont,
        ),
        trailing: Icon(
          alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null,
        ),
        onTap: (){
          setState(() {
            if(alreadySaved) {
              _saved.remove(pair);
            } else {
              _saved.add(pair);
            }
          });
        },
      );
    }

    Widget _buildSuggestions(){
      return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i){
          if (i.isOdd) return Divider();

          final index = i ~/ 2; 
          if (index >= _suggestions.length){
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
    }
}