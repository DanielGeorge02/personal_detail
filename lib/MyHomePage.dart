import 'package:flutter/material.dart';
import 'package:flutter_application_1/adduser.dart';
import 'package:flutter_application_1/model/user.dart';
import 'package:flutter_application_1/services/edituser.dart';
import 'package:flutter_application_1/services/user_services.dart';
import 'package:flutter_application_1/services/viewuser.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<User>? _userList;
  final _userService = UserService();

  getAllUserDetails() async {
    var users = await _userService.readAllUserS();
    _userList = <User>[];
    users.forEach((user) {
      setState(() {
        var userModel = User();
        userModel.id = user['id'];
        userModel.name = user['name'];
        userModel.contact = user['contact'];
        userModel.description = user['description'];
        _userList?.add(userModel);
      });
    });
  }

  @override
  void initState() {
    getAllUserDetails();
    super.initState();
  }

  _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  _deleteFormDialog(BuildContext context, userId) {
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: const Text(
              'Are you sure to Delete?',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.red),
                  onPressed: () async {
                    var result = await _userService.deleteUser(userId);
                    if (result != null) {
                      Navigator.pop(context);
                      getAllUserDetails();
                      _showSuccessSnackBar(
                          "User Details Deleted successfully ");
                    }
                  },
                  child: const Text('Delete')),
              TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.teal,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'))
            ],
          );
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CRUD"),
        toolbarHeight: 80,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 22, 52, 104),
      ),
      body: ListView.builder(
          itemCount: _userList?.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewUser(
                                user: _userList![index],
                              )));
                },
                leading: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Text(
                    _userList?[index]
                            .name
                            .toString()
                            .toUpperCase()
                            .substring(0, 1) ??
                        "",
                    style: TextStyle(
                      color: Color.fromARGB(255, 22, 52, 104),
                    ),
                  ),
                ),
                title: Text(
                  _userList?[index].name ?? '',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(_userList?[index].contact ?? ''),
                trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                  IconButton(
                    onPressed: (() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditUser(
                                    user: _userList![index],
                                  ))).then((data) {
                        if (data != null) {
                          getAllUserDetails();
                          _showSuccessSnackBar(
                              "User Details updated successfully ");
                        }
                      });
                      ;
                    }),
                    icon: const Icon(Icons.edit),
                    color: Colors.teal,
                  ),
                  IconButton(
                    onPressed: (() {
                      _deleteFormDialog(context, _userList?[index].id);
                    }),
                    icon: const Icon(Icons.delete),
                    color: Colors.red,
                  )
                ]),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 22, 52, 104),
        onPressed: () {
          Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddUser()))
              .then((data) {
            if (data != null) {
              getAllUserDetails();
              _showSuccessSnackBar("User Details added successfully ");
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
