import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/user_services.dart';

import '../model/user.dart';

class EditUser extends StatefulWidget {
  final User user;
  const EditUser({super.key, required this.user});

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final _userNameController = TextEditingController();
  final _userContactController = TextEditingController();
  final _userDescriptionController = TextEditingController();
  bool _validateName = false;
  bool _validateContact = false;
  bool _validateDescription = false;
  final _userService = UserService();
  void initState() {
    setState(() {
      _userNameController.text = widget.user.name ?? '';
      _userContactController.text = widget.user.contact ?? '';
      _userDescriptionController.text = widget.user.description ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text(
            "Edit new user",
            style: TextStyle(color: Colors.white, fontSize: 23),
          ),
          toolbarHeight: 80,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios_rounded)),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text("Edit User",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.teal,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(
                height: 20,
              ),
              TextField(
                  controller: _userNameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: "Enter Name",
                    labelText: "Name",
                    errorText:
                        _validateName ? "Name value Can't be Empty" : null,
                  )),
              const SizedBox(
                height: 20,
              ),
              TextField(
                  controller: _userContactController,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: "Enter Contact",
                      labelText: "Contact",
                      errorText: _validateContact
                          ? "Contact value Can't be Empty"
                          : null)),
              const SizedBox(
                height: 20,
              ),
              TextField(
                  controller: _userDescriptionController,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: "Enter Descripton",
                      labelText: "Description",
                      errorText: _validateDescription
                          ? "Description value Can't be Empty"
                          : null)),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.lightBlueAccent,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: (() async {
                        setState(() {
                          _userNameController.text.isEmpty
                              ? _validateName = true
                              : _validateName = false;
                          _userContactController.text.isEmpty
                              ? _validateContact = true
                              : _validateContact = false;
                          _userDescriptionController.text.isEmpty
                              ? _validateDescription = true
                              : _validateDescription = false;
                        });
                        if (_validateName == false &&
                            _validateContact == false &&
                            _validateDescription == false) {
                          var _user = User();
                          _user.id = widget.user.id;
                          _user.name = _userNameController.text;
                          _user.contact = _userContactController.text;
                          _user.description = _userDescriptionController.text;
                          var result = await _userService.UpdateUser(_user);
                          Navigator.pop(context, result);
                        }
                      }),
                      child: const Text('Update Details')),
                  const SizedBox(
                    width: 10,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.teal,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: (() {
                        _userNameController.text = '';
                        _userContactController.text = '';
                        _userDescriptionController.text = '';
                      }),
                      child: const Text('Clear Details'))
                ],
              )
            ]),
          ),
        ));
  }
}
