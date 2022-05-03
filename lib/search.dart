import 'dart:async';

// import 'package:filter_listview_example/api/books_api.dart';
// import 'package:filter_listview_example/main.dart';
// import 'package:filter_listview_example/model/book.dart';
// import 'package:filter_listview_example/page/detail.dart';
// import 'package:filter_listview_example/widget/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restapi/models/cases.dart';
import 'package:flutter_restapi/services/api_service.dart';
import 'package:flutter_restapi/widget/serach_widget.dart';

class FilterNetworkListPage extends StatefulWidget {
  @override
  FilterNetworkListPageState createState() => FilterNetworkListPageState();
}

class FilterNetworkListPageState extends State<FilterNetworkListPage> {
  List<Cases> cases = [];
  String query = '';
  Timer debouncer;

  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future init() async {
    final ApiService api = ApiService();
    final cases = await api.getBooks(query);

    setState(() => this.cases = cases);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('serach'),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            buildSearch(),
            Expanded(
              child: ListView.builder(
                itemCount: cases.length,
                itemBuilder: (context, index) {
                  final case1 = cases[index];

                  return buildBook(case1);
                },
              ),
            ),
          ],
        ),
      );

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Title or Author Name',
        onChanged: searchBook,
      );

  Future searchBook(String query) async => debounce(() async {
        final ApiService api = ApiService();

        final cases = await api.getBooks(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.cases = cases;
        });
      });

  Widget buildBook(Cases case1) => ListTile(
        leading: GestureDetector(
          onTap: () {
            print('hi ${case1.name}');
            // Navigator.push(
            //                   context,
            //                    PageRouteBuilder(
            //                     pageBuilder: (context, a, b) => DetailsPage(
            //                       Book: book.id
            //                     ),
            //                   ),
            //                   );
          },
          child: Image.network(
            case1.imgUrl,
            fit: BoxFit.cover,
            width: 50,
            height: 50,
          ),
        ),
        title: Text(case1.name),
        subtitle: Text(case1.city),
      );
}
