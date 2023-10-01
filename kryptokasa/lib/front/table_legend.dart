import 'package:flutter/material.dart';

import 'common.dart';

class TableLegend extends StatelessWidget {
  const TableLegend({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          child: Container(
            height: 32,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black12,
                width: 1.0,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(1.0),
              ),
              color: const Color.fromARGB(18, 0, 0, 0),
            ),
            child: const Center(child: HeaderText("Kryptowaluta")),
          ),
        ),
        Flexible(
          child: Container(
            height: 32,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black12,
                width: 1.0,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(1.0),
              ),
              color: const Color.fromARGB(18, 0, 0, 0),
            ),
            child: const Center(child: HeaderText("Ilosc")),
          ),
        ),
        Container(
          height: 32,
          width: 24,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black12,
              width: 1.0,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(1.0),
            ),
            color: const Color.fromARGB(18, 0, 0, 0),
          ),
          child: const Center(
            //info icon
            child: Icon(
              Icons.info_outline_rounded,
              color: Colors.black,
              size: 16.0,
            ),
          ),
        ),
        Flexible(
          child: Container(
            height: 32,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black12,
                width: 1.0,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(1.0),
              ),
              color: const Color.fromARGB(18, 0, 0, 0),
            ),
            child: const Center(child: HeaderText("Adres")),
          ),
        ),
        Flexible(
          child: Container(
            height: 32,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black12,
                width: 1.0,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(1.0),
              ),
              color: const Color.fromARGB(18, 0, 0, 0),
            ),
            child: const Center(child: HeaderText("Nazwa")),
          ),
        ),
        Flexible(
          child: Container(
            height: 32,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black12,
                width: 1.0,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(1.0),
              ),
              color: const Color.fromARGB(18, 0, 0, 0),
            ),
            child: const Center(child: HeaderText("Kurs")),
          ),
        ),
        Flexible(
          child: Container(
            height: 32,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black12,
                width: 1.0,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(1.0),
              ),
              color: const Color.fromARGB(18, 0, 0, 0),
            ),
            child: const Center(child: HeaderText("Waluta")),
          ),
        ),
        Flexible(
          child: Container(
            height: 32,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black12,
                width: 1.0,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(1.0),
              ),
              color: const Color.fromARGB(18, 0, 0, 0),
            ),
            child: const Center(child: HeaderText("Wartość")),
          ),
        ),
        Flexible(
          child: Container(
            height: 32,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black12,
                width: 1.0,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(1.0),
              ),
              color: const Color.fromARGB(18, 0, 0, 0),
            ),
            child: const Center(child: HeaderText("Kurs na PLN")),
          ),
        ),
        Flexible(
          child: Container(
            height: 32,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black12,
                width: 1.0,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(1.0),
              ),
              color: const Color.fromARGB(18, 0, 0, 0),
            ),
            child: const Center(child: HeaderText("Wartość w PLN")),
          ),
        ),
      ],
    );
  }
}
