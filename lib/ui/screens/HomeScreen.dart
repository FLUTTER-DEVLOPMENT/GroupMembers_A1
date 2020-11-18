import "package:flutter/material.dart";
import 'package:group_members/Modals/membersModal.dart';
import 'package:group_members/viewModals/HomeViewModal.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController inputController = TextEditingController();

  bool isAdding = false;
  bool isUpdating = false;

  void showAddAlert() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Add New Member"),
        content: Container(
          width: double.maxFinite,
          child: TextField(
            controller: inputController,
            decoration: InputDecoration(
              labelText: "Enter Member",
            ),
          ),
        ),
        actions: [
          FlatButton(
              onPressed: () {
                if (inputController.text != '') {
                  Navigator.pop(context);
                  setState(() {
                    isAdding = true;
                  });
                  HomeViewModal.addMember(inputController.text.toString());
                  setState(() {
                    isAdding = false;
                    inputController.text = '';
                  });
                } else {
                  Navigator.pop(context);
                }
              },
              child: Text("Add")),
          FlatButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                inputController.text = '';
              });
            },
          ),
        ],
      ),
    );
  }

  void showUpdateAlert(Member member) {
    inputController.text = member.name.toString();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Update Member"),
        content: Container(
          width: double.maxFinite,
          child: TextField(
            controller: inputController,
            decoration: InputDecoration(
              labelText: "Enter Member Name",
            ),
          ),
        ),
        actions: [
          FlatButton(
              onPressed: () {
                if (inputController.text != '') {
                  Navigator.pop(context);
                  Member updatedMember = Member(
                      name: inputController.text, objectId: member.objectId);
                  HomeViewModal.updateMember(updatedMember);
                  setState(() {
                    inputController.text = "";
                  });
                } else {
                  Navigator.pop(context);
                }
              },
              child: Text("Update")),
          FlatButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                inputController.text = '';
              });
            },
          ),
        ],
      ),
    );
  }

  void showDelete(String objectId) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Delete Member"),
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.pop(context);
                HomeViewModal.deleteMember(objectId, () {
                  setState(() {});
                });
              },
              child: Text("Delete")),
          FlatButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

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
              padding: EdgeInsets.only(bottom: 100),
              itemCount: members.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        members[index].name,
                        style: TextStyle(fontSize: 22),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.orangeAccent,
                              size: 30,
                            ),
                            onPressed: () {
                              showUpdateAlert(members[index]);
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 30,
                            ),
                            onPressed: () {
                              showDelete(members[index].objectId);
                            },
                          ),
                        ],
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
      floatingActionButton: FloatingActionButton(
        child: !isAdding
            ? Icon(Icons.add)
            : CircularProgressIndicator(
                backgroundColor: Colors.white,
                strokeWidth: 5,
              ),
        onPressed: () {
          showAddAlert();
        },
      ),
    );
  }
}
