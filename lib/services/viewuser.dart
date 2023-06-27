import 'package:flutter/material.dart';

import '../model/user.dart';

class ViewUser extends StatefulWidget {
  final User user;
  ViewUser({super.key, required this.user});

  @override
  State<ViewUser> createState() => _ViewUserState();
}

class _ViewUserState extends State<ViewUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 22, 52, 104),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios_rounded)),
        title: Text(
          widget.user.name ?? "",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        centerTitle: true,
        toolbarHeight: 80,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Full Details",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 22, 52, 104),
                fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                'Name              :',
                style: TextStyle(
                    color: Colors.teal,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 45),
                child: Text(
                  widget.user.name ?? '',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                'Contact          :',
                style: TextStyle(
                    color: Colors.teal,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  widget.user.contact ?? '',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Description   :',
                style: TextStyle(
                    color: Colors.teal,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                widget.user.description ?? '',
                style: TextStyle(
                  fontSize: 16,
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
