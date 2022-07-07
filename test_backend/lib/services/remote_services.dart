import 'package:test_backend/model/User.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<List<User>?> getUsers() async {
    var client = http.Client();
    var uri = Uri.parse('http://34.73.150.160:5000/user');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return userFromJson(json);
    }
  }
}
