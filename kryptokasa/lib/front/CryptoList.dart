import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kryptokasa/api/api.dart';

class CryptoList extends StatefulWidget {
  const CryptoList({super.key});

  @override
  CryptoListState createState() => CryptoListState();
}

class CryptoListState extends State<CryptoList> {
  List<CryptoRow> cryptoRows = [];

  CryptoTask task() {
    CryptoTask task = CryptoTask();
    task.cryptoPairs = [];
    for (var row in cryptoRows) {
      task.cryptoPairs.add(CryptoPair((row.key.currentState as _CryptoRowState).selectedCrypto!,
          (row.key.currentState as _CryptoRowState).amount!));
    }
    return task;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
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
                  key: GlobalKey(), // using keys to identify rows uniquely
                  onDelete: (key) {
                    setState(() {
                      cryptoRows.removeWhere((row) => row.key == key);
                    });
                  },
                ));
              });
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1), // Zaokrąglenie rogu
              ),
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
  final GlobalKey key;
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
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 36,
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.all(12),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black12, // Kolor border w normalnym stanie
                      width: 1.0, // Szerokość border w normalnym stanie
                    ),
                    borderRadius: BorderRadius.circular(1), // Usuwanie zaokrąglenia
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black, // Kolor border w stanie zaznaczenia
                      width: 2.0, // Szerokość border w stanie zaznaczenia
                    ),
                    borderRadius: BorderRadius.circular(1), // Usuwanie zaokrąglenia
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
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 36,
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
          ),
          SizedBox(
            height: 36,
            child: ElevatedButton(
              onPressed: () {
                widget.onDelete(widget.key);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 220, 0, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1), // Zaokrąglenie rogu
                ),
              ),
              child: Text(
                'Usuń',
                style: GoogleFonts.inter(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
