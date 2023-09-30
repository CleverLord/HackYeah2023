import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kryptokasa/main.dart';

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
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.all(12),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black12, // Kolor border w normalnym stanie
                      width: 1.0, // Szerokość border w normalnym stanie
                    ),
                    borderRadius: BorderRadius.circular(1.0), // Usuwanie zaokrąglenia
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black, // Kolor border w stanie zaznaczenia
                      width: 2.0, // Szerokość border w stanie zaznaczenia
                    ),
                    borderRadius: BorderRadius.circular(1.0), // Usuwanie zaokrąglenia
                  ),
                ),
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
              value != null ? padding(8) : const SizedBox.shrink(),
              value != null
                  ? Container(
                      //add border
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                          width: 1.0,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(2.0),
                        ),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          //Add info icon
                          const Icon(Icons.info_outline_rounded),
                          padding(8),
                          Expanded(
                            child: Text(
                              "Obsluguje ${snapshot.data!.firstWhere((element) => element.name == value).description}",
                              textAlign: TextAlign.left,
                              //make text wrap
                              style: GoogleFonts.inter(
                                color: Colors.black54,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
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
