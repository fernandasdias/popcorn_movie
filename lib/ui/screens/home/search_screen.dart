import 'package:PopcornMovie/domain/entities/show.dart';
import 'package:PopcornMovie/domain/entities/showList.dart';
import 'package:PopcornMovie/presentation/search_presenter.dart';
import 'package:PopcornMovie/ui/screens/home/widgets/movie_card.dart';
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
    Presenter searchPresenter = SearchPresenter();
    return Scaffold(
      // appBar: AppBar(
      //   leading: ElevatedButton(
      //     onPressed: () => showSearch(context: context, delegate: Search()),
      //     child: Icon(Icons.search),
      //   ),
      // ),
      body: SafeArea(
        minimum: EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                child: TextField(
                  controller: _filter,
                  onChanged: (value) => searchPresenter.onChanged(value),
                  decoration: new InputDecoration(
                      prefixIcon: new Icon(Icons.search),
                      hintText: 'Search...'),
                ),
              ),
            ),
            StreamBuilder<List<Show>>(
                stream: searchPresenter.searchValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print('snapshot has data');
                    List<Show> shows = snapshot.data!;
                    return Container(
                      child: Expanded(
                        flex: 3,
                        child: ListView.builder(
                          // controller: _scrollViewController,

                          itemCount: shows.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return MovieCard(
                              show: shows[index],
                              context: context,
                            );
                          },
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                }),
          ],
        ),
      ),
    );
  }
}
