import 'package:group_members/constant.dart';
import 'package:http/http.dart';

class MemberNetwork {
  static Future<Response> getMemberResponse() async {
    // Getting Response From Server
    String apiUrl = kServerUrl + "classes/Members";

    Response response = await get(apiUrl, headers: {
      'X-Parse-Application-Id': kApplicationId,
      'X-Parse-REST-API-Key': 'hueIJGfs1NmI6NxO928UJQE5Ms7hkNBxxfrrT8hC',
    });

    return response;
  }
}
