import 'dart:io';
import 'package:http/http.dart' as http;

void main(List<String> arguments) async  {

  print("Select the font number you need:");
  var fonts = await fontsList();

  fonts.asMap().forEach((index, elem) {
    print("[$index] $elem");
  });

  print("Select the font number you need:");
  int? fontId = int.parse(stdin.readLineSync()!);
  String selectedFont = fonts[fontId];
  print("-------------------------");
  print("You Have Selected: $selectedFont" );
  print("Write Down the Text you wish to convert");
  String? text = stdin.readLineSync()!;
  var response = await convertToAscii(text , selectedFont);

  print(response);
}

Future<String> convertToAscii(String? text, String? selectedFont) async {
  var url = Uri.parse('https://artii.herokuapp.com/make?text=$text&font=$selectedFont');
  var response = await http.get(url);
  return response.body;
}

Future<List> fontsList() async {
  var url = Uri.parse("https://artii.herokuapp.com/fonts_list");
  var response = await http.get(url);
  List<String> result = response.body.split('\n');
  return result;
}




