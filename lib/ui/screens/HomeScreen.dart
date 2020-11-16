import "package:flutter/material.dart";
import 'package:group_members/Modals/membersModal.dart';
import 'package:group_members/viewModals/HomeViewModal.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Group Members"),
      ),
      body: Container(
          child: FutureBuilder(
        future: HomeViewModal.getMemberList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Member> members = snapshot.data;
            return ListView.builder(
              itemCount: members.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        members[index].name,
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                    Divider()
                  ],
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )),
    );
  }
}
