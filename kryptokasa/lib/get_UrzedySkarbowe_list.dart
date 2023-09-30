// link https://sip.lex.pl/akty-prawne/dzu-dziennik-ustaw/wyznaczenie-organow-krajowej-administracji-skarbowej-do-wykonywania-18574815
// path is (div class="a_anx" >> div >> div >> div >> table >> tbody)
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:html/dom.dart';

class UrzadSkarbowy {
  final String idx;
  final String name;

  UrzadSkarbowy({
    required this.idx,
    required this.name,
  });
}

Future<List<UrzadSkarbowy>>? getUrzedySkarbowe() async {
  List<UrzadSkarbowy> result = [];

  var url = Uri.parse('https://www.e-pity.pl/lista-urzedow-skarbowych/');
  var response = await http.get(url);// make try catch for that
  /*
    Error: ClientException with SocketException: Failed host lookup: 'sip.lex.pľ (OS Error, Nieznany host., errno = 11001), uri=https://sip.lex.pl/akty-prawne/dzu-dziennik-ustaw/voznaczenie-
    organow-krajowej -administracji-skâ rbowej -do-wykonywania- 18574815
  */ 
  if(response.statusCode != 200){
    return Future.error(Exception('Nie udało się pobrać danych ze strony. Problem z połączeniem. Kod błędu:' + response.statusCode.toString()));
  }
  var document = parse(response.body);
  if (document.body == null){
    return Future.error(Exception('Nie udało się pobrać danych ze strony. Problem z ekstrakcją body'));
  }
  var table = document.body!.getElementsByTagName('ol');
  if (table.isEmpty){
      return Future.error(Exception('Nie udało się znaleźć tabelki na stronie'), StackTrace.fromString('getNaczelnicyUrzedowSkarbowych(), zal_1 == null '),);
  }

  var trs = table[0].getElementsByTagName('li');
  for (var tr in trs){
    String text = tr.text;
    String idx = text.substring(text.indexOf('[')+1, text.indexOf(']'));
    String name = text.substring(0, text.indexOf('['));
    result.add(UrzadSkarbowy(idx: idx, name: name));
  }
  return result;
}

//function to use tree search to find the element by type
Element? getElementByType(Element element, String type) {
  if (element.localName == type) return element;
  for (var child in element.children) {
    var result = getElementByType(child, type);
    if (result != null) return result;
  }
  return null;
}