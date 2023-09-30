// link https://sip.lex.pl/akty-prawne/dzu-dziennik-ustaw/wyznaczenie-organow-krajowej-administracji-skarbowej-do-wykonywania-18574815
// path is (div class="a_anx" >> div >> div >> div >> table >> tbody)
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

class NaczelnikUrzeduSkarbowego {
  final String idx;
  final String name;
  final String description;

  NaczelnikUrzeduSkarbowego({
    required this.idx,
    required this.name,
    required this.description,
  });
}

Future<List<NaczelnikUrzeduSkarbowego>>? getNaczelnicyUrzedowSkarbowych() async {
  List<NaczelnikUrzeduSkarbowego> result = [];

  //get the page
  var url = Uri.parse('https://sip.lex.pl/akty-prawne/dzu-dziennik-ustaw/wyznaczenie-organow-krajowej-administracji-skarbowej-do-wykonywania-18574815');
  var response = http.get(url);
  var document = parse(response.toString());

  //get the table
  var zal_1= document.getElementById('zal(1)');
  //Get all elements of type <tr>
  var trs = zal_1!.getElementsByTagName('tr');
  
  //iterate through all <tr> elements
  for (var tr in trs){
    //get all <td> elements
    var tds = tr.getElementsByTagName('td');
    //if there are not 3 <td> elements, skip this <tr>
    if (tds.length != 3) continue;
    var nus = NaczelnikUrzeduSkarbowego(idx: tds[0].text, name: tds[1].text, description: tds[2].text);
    result.add(nus);
  }
  return result;
}