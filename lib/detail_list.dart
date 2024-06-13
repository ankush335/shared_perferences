import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class DetailList extends StatefulWidget {
  const DetailList({super.key});

  @override
  State<DetailList> createState() => _DetailListState();
}

class _DetailListState extends State<DetailList> {
  List<String> dataList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      dataList = prefs.getStringList('dataList') ?? [];
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(itemCount: dataList.length ,itemBuilder: (context,index) {
          return ListTile(
              leading: Text('${index +1}'),
              title: Text(dataList[index]));
        }),
      ),
    );

  }
}
