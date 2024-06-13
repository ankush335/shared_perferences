import 'package:easylug/detail_list.dart';
import 'package:easylug/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();

  //create submit method
  Future<void> _submitdata() async {
    String name = nameController.text;
    String surname = surnameController.text;

    if (name.isEmpty || surname.isEmpty) {
      Fluttertoast.showToast(msg: 'both fields are required');
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> dataList = prefs.getStringList('dataList') ?? []; // add list in shared perf
    dataList.add('$name, $surname');// add data in list
    await prefs.setStringList('dataList', dataList); // update to the shared pref

    Fluttertoast.showToast(msg: "Data submitted");

    nameController.clear();
    surnameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(label: Text('Name')),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: surnameController,
                decoration: InputDecoration(label: Text('surname')),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                 onPressed: _submitdata,
                // onPressed: (nameController.text.isNotEmpty && surnameController.text.isNotEmpty)
                //     ? _submitdata
                //     :(){
                //   Fluttertoast.showToast(msg: 'Both fields are required');
                // },
                child: Text('Submit'),
              ),

              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DetailList()),
                    );
                  },
                  child: Text('nextPage--->',style:TextStyle(fontWeight: FontWeightConstants.size100)),),
            ],
          ),
        ),
      ),
    );
  }
}
