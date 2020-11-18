import 'dart:convert';

import 'package:group_members/Modals/membersModal.dart';
import 'package:group_members/constant.dart';
import 'package:http/http.dart';

class MemberNetwork {
  static Future<Response> getMemberResponse() async {
    // Getting Response From Server
    String _apiUrl = kServerUrl + "classes/Members";

    Response response = await get(_apiUrl, headers: {
      'X-Parse-Application-Id': kApplicationId,
      'X-Parse-REST-API-Key': kRestApiKey,
    });

    return response;
  }

  static Future<Response> addMember(Member member) async {
    String _apiUrl = kServerUrl + "classes/Members";

    Response response = await post(
      _apiUrl,
      headers: {
        'X-Parse-Application-Id': kApplicationId,
        'X-Parse-REST-API-Key': kRestApiKey,
        'Content-Type': 'application/json'
      },
      body: json.encode(member.toJson()),
    );

    return response;
  }

  static Future<Response> updateMember(Member member) async {
    String _apiUrl = kServerUrl + "classes/Members/${member.objectId}";
    Response response = await put(_apiUrl,
        headers: {
          'X-Parse-Application-Id': kApplicationId,
          'X-Parse-REST-API-Key': kRestApiKey,
          'Content-Type': 'application/json',
        },
        body: json.encode(member.toJson()));
    return response;
  }

  static Future<Response> deleteMember(String objectId) async {
    print(objectId);
    String _apiUrl = kServerUrl + "classes/Members/$objectId";
    Response response = await delete(_apiUrl, headers: {
      'X-Parse-Application-Id': kApplicationId,
      'X-Parse-REST-API-Key': kRestApiKey,
    });

    return response;
  }
}
