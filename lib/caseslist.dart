import 'package:flutter/material.dart';
import 'package:flutter_restapi/models/cases.dart';
import 'detailwidget.dart';

class CasesList extends StatelessWidget {
  final List<Cases> cases;
  CasesList({Key key, this.cases}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: cases == null ? 0 : cases.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              child: InkWell(
            onTap: () {
              print('index $index');
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailWidget(cases[index])),
              );
            },
            child: Container(
              padding: EdgeInsets.all(2),
              height: 140,
              child: Card(
                elevation: 5,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Image.network(
                        this.cases[index].imgUrl,
                        width: 200,
                      ),
                      Expanded(
                          child: Container(
                              padding: EdgeInsets.all(5),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(this.cases[index].name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text("id:${this.cases[index].age}"),
                                  Text("quantity:${this.cases[index].city}"),
                                ],
                              )))
                    ]),

                // Container(
                //     padding: EdgeInsets.all(25),
                //     alignment: Alignment.topRight,
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.end,
                //       children: <Widget>[
                //         Text('name:${cases[index].name}',
                //             style: TextStyle(fontWeight: FontWeight.bold)),
                //         Text("countery:${cases[index].country}"),
                //         Text("age:${cases[index].age}"),
                //       ],
                //     ))
                // ListTile(
                //   leading: Icon(Icons.person),
                //   title: Text(cases[index].name),
                //   subtitle: Text(cases[index].age.toString()),
              ),
            ),
          ));
        });
  }
}
