import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url, this.extraurl);

  final String url, extraurl;

  Future getData() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      return decodedData;
    } else {
      print(response.statusCode);
    }
  }
}

// class NetworkHelperExtra {
//   NetworkHelperExtra(this.extraurl);
//   final String extraurl;
//   Future getExtraData() async {
//     http.Response response = await http.get(extraurl);
//     if (response.statusCode == 200) {
//       String data = response.body;
//       var decodedData = jsonDecode(data);
//       return decodedData;
//     } else {
//       print(response.statusCode);
//     }
//   }
// }
