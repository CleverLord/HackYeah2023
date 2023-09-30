// link https://sip.lex.pl/akty-prawne/dzu-dziennik-ustaw/wyznaczenie-organow-krajowej-administracji-skarbowej-do-wykonywania-18574815
// path is (div class="a_anx" >> div >> div >> div >> table >> tbody)
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:html/dom.dart';

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

  var url = Uri.parse('https://sip.lex.pl/akty-prawne/dzu-dziennik-ustaw/wyznaczenie-organow-krajowej-administracji-skarbowej-do-wykonywania-18574815');
  var response = await http.get(url);
  if(response.statusCode != 200){
    return Future.error(Exception('Nie udało się pobrać danych ze strony. Problem z połączeniem. Kod błędu:' + response.statusCode.toString()));
  }
  var document = parse(response.body);
  if (document.body == null){
    return Future.error(Exception('Nie udało się pobrać danych ze strony. Problem z ekstrakcją body'));
  }
  var zal_1= getElementById(document.body!,'zal(1)');
  if (zal_1 == null){
      return Future.error(Exception('Nie udało się znaleźć tabelki na stronie'), StackTrace.fromString('getNaczelnicyUrzedowSkarbowych(), zal_1 == null '),);
  }

  var trs = zal_1.getElementsByTagName('tr');
  for (var tr in trs){
    var tds = tr.getElementsByTagName('td');
    if (tds.length != 3) continue;
    if (!tds[1].text.contains("Naczelnik")) continue;
    var nus = NaczelnikUrzeduSkarbowego(idx: tds[0].text, name: tds[1].text, description: tds[2].text);
    result.add(nus);
  }
  return result;
}
//function to use tree search to find the element by id
Element? getElementById(Element element, String id) {
  if (element.id == id) return element;
  for (var child in element.children) {
    var result = getElementById(child, id);
    if (result != null) return result;
  }
  return null;
}