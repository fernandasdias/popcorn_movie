import 'package:flutter/material.dart';

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  String selectedResult = "";
  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Fernanda'),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return (Container());
  }
}

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _filter = new TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: ElevatedButton(
          onPressed: () => showSearch(context: context, delegate: Search()),
          child: Icon(Icons.search),
        ),
      ),
      body: SafeArea(
        minimum: EdgeInsets.all(12),
        child: Container(
          child: TextField(
            controller: _filter,
            decoration: new InputDecoration(
                prefixIcon: new Icon(Icons.search), hintText: 'Search...'),
          ),
        ),
      ),
    );
  }
}
