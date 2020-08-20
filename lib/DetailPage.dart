import 'package:flutter/material.dart';
import 'package:photosjsonapi/Modal/Data.dart';

class Detail extends StatefulWidget {
  Data data;
  Detail(this.data);
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Data'),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.network(
                  widget.data.url,   
                  height: 250,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: CircleAvatar(
                          child: Text(widget.data.id.toString()),
                        ),
                      ),
                      SizedBox(
                        width: 7.0,
                      ),
                       Expanded(
                        flex: 2,
                        
                          child: Text(widget.data.title,
                        ),
                       ),
                      
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
