import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'get_NaczelnicyUrzedowSkarbowych_list.dart';

class NaczelnicyUrzedowSkarbowych_Dropdown extends StatefulWidget {
  const NaczelnicyUrzedowSkarbowych_Dropdown({super.key});

  @override
  _NaczelnicyUrzedowSkarbowych_DropdownState createState() => _NaczelnicyUrzedowSkarbowych_DropdownState();
}

class _NaczelnicyUrzedowSkarbowych_DropdownState extends State<NaczelnicyUrzedowSkarbowych_Dropdown> {
  String? value;

  late Future<List<NaczelnikUrzeduSkarbowego>> naczelnicyFuture;

  @override
  void initState() {
    super.initState();
    naczelnicyFuture = getNaczelnicyUrzedowSkarbowych()!; // cache the Future here
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NaczelnikUrzeduSkarbowego>>(
      future: naczelnicyFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While data is loading, show a loading indicator.
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // If there's an error, display an error message.
          return Text('Error: ${snapshot.error}');
        } else {
          // If data is loaded successfully, create the dropdown.
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButton<String>(
                isExpanded: true, // This will make the dropdown expanded and remove the weird padding.
                value: value, // Set the initial value or null.
                onChanged: (String? newValue) {
                  setState(() {
                    value = newValue;
                  });
                },
                items: snapshot.data!.map<DropdownMenuItem<String>>((NaczelnikUrzeduSkarbowego value) {
                  return DropdownMenuItem<String>(
                    value: value.name,
                    child: Text(value.name),
                  );
                }).toList(),
              ),
              value != null
                  ? Text(
                      "Obsluguje ${snapshot.data!.firstWhere((element) => element.name == value).description}",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.inter(
                        color: Colors.black54,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          );
        }
      },
    );
  }
}
