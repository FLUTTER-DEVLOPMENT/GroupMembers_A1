import 'dart:convert';

import 'package:group_members/Modals/membersModal.dart';
import 'package:group_members/networkHandling/membersNetworkRequests.dart';
import 'package:http/http.dart';

// this class handles all Ui data modal of home screen

class HomeViewModal {
  static Future<List<Member>> getMemberList() async {
    // this function  return ListOfMembers in future
    List<Member> membersList = [];

    Response response = await MemberNetwork
        .getMemberResponse(); // get response from http request. await keyword use to wait for response then go ahead

    // print("Code is ${response.statusCode}");
    // print("Response is ${response.body}");

    if (response.statusCode == 200) {
      //check response status code if is 200 it means All Good
      var body = json.decode(response.body); // decode response body
      List results = body[
          "results"]; // result store list of Maps  like [{"Name":"Nav" ,"ObjectId":"437473sd"},{}...,n]
      for (int i = 0; i < results.length; i++) {
        membersList.add(Member.fromJson(results[i]));
      }
    } else {
      //Handle error
      print("Error");
    }
    return membersList;
  }

  static addMember(String name) async {
    Response response = await MemberNetwork.addMember(Member(name: name));

    if (response.statusCode == 201) {
      print("Added Successfully");
    } else {
      print("Member Not Inserted");
    }
  }

  static updateMember(Member member) async {
    Response response = await MemberNetwork.updateMember(member);
    if (response.statusCode == 200) {
      print("Update Successfully");
    } else {
      print("Member Not Updated");
    }
  }

  static deleteMember(String objectId, Function callback) async {
    Response response = await MemberNetwork.deleteMember(objectId);
    if (response.statusCode == 200) {
      print("Member Deleted");
      if (callback != null) {
        callback();
      }
    } else {
      print("Member Not Deleted");
      print(response.body.toString());
    }
  }
}
