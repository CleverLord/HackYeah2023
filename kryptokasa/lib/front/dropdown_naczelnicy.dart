import 'package:flutter/material.dart';
import 'package:kryptokasa/front/common.dart';
import 'package:kryptokasa/main.dart';

import '../get_NaczelnicyUrzedowSkarbowych_list.dart';

class DropdownNaczelnicy extends StatefulWidget {
  const DropdownNaczelnicy({super.key});

  @override
  _DropdownNaczelnicyState createState() => _DropdownNaczelnicyState();
}

class _DropdownNaczelnicyState extends State<DropdownNaczelnicy> {
  String? value;
  NaczelnikUrzeduSkarbowego? naczelnikUrzeduSkarbowego;

  late Future<List<NaczelnikUrzeduSkarbowego>> naczelnicyFuture;

  @override
  void initState() {
    super.initState();
    naczelnicyFuture = getNaczelnicyUrzedowSkarbowych()!;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NaczelnikUrzeduSkarbowego>>(
      future: naczelnicyFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(
            color: red,
            strokeWidth: 10,
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.all(12),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black12,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(1.0),
                  ),
                ),
                isExpanded: true,
                value: value,
                onChanged: (String? newValue) {
                  setState(() {
                    value = newValue;
                    naczelnikUrzeduSkarbowego = snapshot.data!.firstWhere((element) => element.name == value);
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
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                          width: 1.0,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(1.0),
                        ),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Icon(Icons.info_outline_rounded),
                          padding(8),
                          Expanded(
                            child: TooltipText(
                              "Obsługuje ${naczelnikUrzeduSkarbowego!.description}",
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
