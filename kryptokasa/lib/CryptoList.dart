import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kryptokasa/main.dart';

class CryptoList extends StatefulWidget {
  const CryptoList({super.key});

  @override
  _CryptoListState createState() => _CryptoListState();
}

class _CryptoListState extends State<CryptoList> {
  List<CryptoRow> cryptoRows = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2.0),
//drop fancy shadow
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(4.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ...cryptoRows,
          ElevatedButton(
            onPressed: () {
              setState(() {
                cryptoRows.add(CryptoRow(
                  key: UniqueKey(), // using keys to identify rows uniquely
                  onDelete: (key) {
                    setState(() {
                      cryptoRows.removeWhere((row) => row.key == key);
                    });
                  },
                ));
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 0, 82, 164), // Set the background color to blue
            ),
            child: Text(
              'Nowy wiersz',
              style: GoogleFonts.inter(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class CryptoRow extends StatefulWidget {
  @override
  final Key key;
  final ValueChanged<Key> onDelete;

  const CryptoRow({required this.key, required this.onDelete}) : super(key: key);

  @override
  _CryptoRowState createState() => _CryptoRowState();
}

class _CryptoRowState extends State<CryptoRow> {
  String? selectedCrypto;
  String? amount;
  List<String> cryptos = ['BTC', 'ETH', 'LTC']; // Example list of cryptocurrencies.

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          DropdownButton<String>(
            hint: const Text('Select Crypto'),
            value: selectedCrypto,
            onChanged: (newValue) {
              setState(() {
                selectedCrypto = newValue;
              });
            },
            items: cryptos.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          padding(8),
          Expanded(
            child: TextField(
              onChanged: (value) {
                amount = value;
              },
            ),
          ),
          padding(8),
          ElevatedButton(
            onPressed: () {
              widget.onDelete(widget.key);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 220, 0, 50), // Set the background color to blue
            ),
            child: Text(
              'Usuń',
              style: GoogleFonts.inter(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
