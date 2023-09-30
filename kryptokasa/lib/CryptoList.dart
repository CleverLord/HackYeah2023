import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          color: Colors.black12,
          width: 1.0,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(2.0),
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
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Ilość",
                hintStyle: GoogleFonts.inter(color: Colors.black38, fontSize: 14, fontWeight: FontWeight.w400),
                isDense: true,
                contentPadding: const EdgeInsets.all(12),
                // Ustawianie border dla normalnego stanu
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black12, // Kolor border
                    width: 1.0, // Szerokość border w normalnym stanie
                  ),
                  borderRadius: BorderRadius.circular(1), // Usuwanie zaokrąg
                ),
                // Ustawianie border dla stanu zaznaczenia
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black, // Kolor border w stanie zaznaczenia
                    width: 2.0, // Szerokość border w stanie zaznaczenia
                  ),
                  borderRadius: BorderRadius.circular(1), // Usuwanie zaokrąg
                ),
              ),
              onChanged: (value) {
                amount = value;
              },
              cursorColor: Colors.black, // This changes the caret color.

              inputFormatters: [
                // Allow only numbers, and ,.
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\,]')),
              ],
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
