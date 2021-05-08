import 'package:PopcornMovie/presentation/bloc/show_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/models/show.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShowBloc>(
      create: (context) => ShowBloc()..add(ShowIndexEvent()),
      child: Body(widget: widget),
    );
  }
}

class Body extends StatefulWidget {
  const Body({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final MyHomePage widget;

  @override
  _BodyState createState() => _BodyState();
}

@override
void initState() {}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.widget.title),
      ),
      body: BlocBuilder<ShowBloc, ShowState>(
        builder: (context, state) {
          if (state is IndexLoadedState) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridViewShowList(
                showList: state.show.showList,
              ),
            );
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Nothing to show here'),
              ],
            ),
          );
        },
      ),
    );
  }
}

class GridViewShowList extends StatelessWidget {
  final List<ShowModel> showList;
  const GridViewShowList({
    Key key,
    @required this.showList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 0.8,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemCount: showList.length,
        itemBuilder: (BuildContext ctx, index) {
          return Container(
            // color: Colors.amber,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  showList[index].name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  // color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 2.0, 0, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        showList[index].image,
                        fit: BoxFit.fitWidth,
                        height: 200,
                        width: 145,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
