import 'package:flutter/material.dart';
import 'get_NaczelnicyUrzedowSkarbowych_list.dart';
class NaczelnicyUrzedowSkarbowych_Dropdown extends StatefulWidget {
  @override
  _NaczelnicyUrzedowSkarbowych_DropdownState createState() => _NaczelnicyUrzedowSkarbowych_DropdownState();
}

class _NaczelnicyUrzedowSkarbowych_DropdownState extends State<NaczelnicyUrzedowSkarbowych_Dropdown> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NaczelnikUrzeduSkarbowego>>(
      future: getNaczelnicyUrzedowSkarbowych(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While data is loading, show a loading indicator.
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // If there's an error, display an error message.
          return Text('Error: ${snapshot.error}');
        } else {
          // If data is loaded successfully, create the dropdown.
          return DropdownButton<String>(
            value: null, // Set the initial value or null.
            onChanged: (String? newValue) {
              // Handle dropdown item selection here.
            },
            items: snapshot.data!.map<DropdownMenuItem<String>>((NaczelnikUrzeduSkarbowego value) {
              return DropdownMenuItem<String>(
                value: value.name,
                child: Text(value.name),
              );
            }).toList(),
          );
        }
      },
    );
  }
}