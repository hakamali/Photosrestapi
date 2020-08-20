import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:photosjsonapi/DetailPage.dart';
import 'package:photosjsonapi/Modal/Data.dart';
import 'package:http/http.dart' as http;

import 'dart:async';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<MaterialColor> _color = [
    Colors.deepOrange,
    Colors.amber,
    Colors.red,
    Colors.green,
    Colors.purple,
    Colors.brown
  ];
  Future<List<Data>> getAllData() async {
    var api = "https://jsonplaceholder.typicode.com/photos";
    var data = await http.get(api);
    var jsonData = json.decode(data.body);

    List<Data> listOf = [];

    for (var i in jsonData) {
      Data data = Data(i["id"], i["title"], i["url"], i["thumbnailUrl"]);

      listOf.add(data);
    }
    return listOf;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Json Parsing App'),
        backgroundColor: Colors.deepOrange,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => debugPrint('Search'),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => debugPrint('Add'),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('HakimAli'),
              accountEmail: Text('hakamali1537@gmail.com'),
              decoration: BoxDecoration(
                color: Colors.deepOrange,
              ),
            ),
            ListTile(
              title: Text('first Page'),
              leading: Icon(Icons.search, color: Colors.orange),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text('Second Page'),
              leading: Icon(Icons.add, color: Colors.red),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text('third Page'),
              leading: Icon(Icons.title, color: Colors.purple),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text('Fourth Page'),
              leading: Icon(Icons.list, color: Colors.green),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            Divider(
              height: 5.0,
            ),
            ListTile(
              title: Text('Close'),
              leading: Icon(Icons.close, color: Colors.red),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
           Container(
            margin: EdgeInsets.all(10.0),
            height: 250,
            child: FutureBuilder(
                future: getAllData(),
                builder: (BuildContext c, AsyncSnapshot snapshot) {
                  if (snapshot.data==null) {
                    return Center(
                      child: Text('Loading Data.......'),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext c, int index) {
                          MaterialColor mColor = _color[index % _color.length];

                          return Card(
                            elevation: 10.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Image.network(
                                  snapshot.data[index].url,
                                  height: 150.0,
                                  width: 150.0,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(
                                  height: 7.0,
                                ),
                                Container(
                                  margin: EdgeInsets.all(6.0),
                                  height: 50.0,
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        child: CircleAvatar(
                                          child: Text(snapshot.data[index].id
                                              .toString()),
                                          backgroundColor: mColor,
                                          foregroundColor: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 6.0,
                                      ),
                                      Container(
                                        width: 80.0,
                                        child: Text(
                                          snapshot.data[index].title,
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: Colors.deepOrange),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        } );
                  }
                }),
          ),
          SizedBox(
            height: 7.0,
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.all(10.0),
            child: FutureBuilder(
                future: getAllData(),
                builder: (BuildContext c, AsyncSnapshot snapshot) {
                  if (snapshot.data ==null) {
                    return Center(
                      child: Text('LoadingData....'),
                    );
                  }
                   else {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext c, int index) {
                          MaterialColor mColor = _color[index % _color.length];

                          return Card(
                            elevation: 7.0,
                            child: Container(
                              height: 80.0,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Image.network(
                                      snapshot.data[index].thumnailUrl,
                                      height: 100.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 6.0,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: InkWell(
                                                                          child: Text(
                                        snapshot.data[index].title,
                                        maxLines: 2,
                                        style: TextStyle(fontSize: 16.0,
                                        ),
                                      ),
                                      onTap:(){
                                        Navigator.of(context).push(MaterialPageRoute(builder:(BuildContext c)=>Detail(snapshot.data[index]),),);

                                      } ,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: CircleAvatar(
                                        child: Text(
                                            snapshot.data[index].id.toString()),
                                        backgroundColor: mColor,
                                        foregroundColor: Colors.white,
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          );
                        }
                        );

                   
                  }
                }
                ),
          )

        ],
      ),

    );
  }
}
