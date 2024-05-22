import 'package:fast/product.dart';
import 'package:http/http.dart' as http;

class RemoteServices {
  static var client = http.Client();

  static Future<List<Product>?> fetchProducts() async {
    var response = await client
        .get(Uri.parse('https://nikhiltaral.github.io/Mackup/Mackup.json'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return productFromJson(jsonString);
    } else {
      
      return null;
    }
  }
}
