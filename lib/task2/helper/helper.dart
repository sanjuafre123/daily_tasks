import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class UserApiHelper {
  Future<List> fetchApiData() async {
    final url = Uri.parse("https://api.escuelajs.co/api/v1/users");
    Response response = await http.get(url);

    try{
      if(response.statusCode == 200)
        {
          List data = jsonDecode(response.body);
          return data;
        }
      else
        {
          throw Exception("Data did not fetched");
        }
    }
    catch(e)
    {
      throw Exception("Failed to fetch : $e");
    }
  }
}
