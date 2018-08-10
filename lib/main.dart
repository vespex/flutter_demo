import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.red,
      ),
      home: new RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = new Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);
  int _newList = 1;

  Widget _buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return new Divider();
        final index = i ~/ 2;
        if (index >= _suggestions.length / 2) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          final tiles = _saved.map(
            (pair) {
              return new ListTile(
                title: new Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile
            .divideTiles(
              context: context,
              tiles: tiles,
            )
            .toList();

          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Saved Suggestions'),
              actions: <Widget>[
                new IconButton(icon: new Icon(Icons.next_week), onPressed: () {Navigator.push(context, new MaterialPageRoute(builder: (context) => new NewPage()));},)
              ]
            ),
            body: new ListView(children: divided),
          );
        },
      ),
    );
  }

  Widget _button (int num) {
    return new Text('click me ${num.toString()}');
  }

  void _newPage () {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return new Scaffold(
            appBar: new AppBar(
              title: new Text('this is a new page'),
            ),
            body: new Column(
              children: <Widget>[
                new Container(
                  child: new Center(
                    child: new FlatButton(
                      child: new Text('ahaha', style: new TextStyle(color: Colors.white),),
                      color: Colors.red,
                      onPressed: () {
                        setState(() {
                          _newList += 1;         
                        });
                      },
                    ),
                  ),
                  height: 100.0,
                  decoration: new BoxDecoration(color: Colors.blue[500])
                ),
                new Expanded(
                  child: new Center(
                  ),
                )
              ],
            )
          );
        }
      )
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('startup Name Generator'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
      body: new Column(
        children: <Widget>[
          new Container(
            child: new Center(
              child: new RaisedButton(
                child: _button(_newList),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  setState(() {
                    _newList += 2;
                  });
                },
              ),
            ),
            height: 50.0,
          ),
          new Expanded(
            child:  _buildSuggestions(), 
          )
        ]
      ),
    );
  }
}



class NewPage extends StatefulWidget {
  @override
 createState() => new NewPageState();
}

class NewPageState extends State<NewPage> {
  final _list = [1, 2, 3, 4, 5];

  @override
  Widget build(BuildContext context) {
    final tiles = _list.map(
      (item) {
        return new ListTile(
          title: new Text(
            item.toString(),
          ),
        );
      },
    );
    final divided = ListTile
      .divideTiles(
        context: context,
        tiles: tiles,
      )
      .toList();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('test')
      ),
      body: new Column(
        children: <Widget>[
          new Container(
            child: new Center(
              child: new FlatButton(
                child: new Text('click'),
                onPressed: () {
                  setState(() {
                    _list.add(_list.length + 1);
                  });
                },
              ),
            ),
          ),
          new Expanded(
            child: new ListView(
              children: divided,
            ),
          )
        ],
      ),
    );
  }
}