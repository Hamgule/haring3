import 'package:flutter/material.dart';
import 'package:haring3/page/sheet_modification_page.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  UserPageState createState() => UserPageState();
}

class UserPageState extends State<UserPage> {

  final bool isLeader = false;

  @override
  Widget build(BuildContext context) {

    return SheetModificationPage(isLeader: isLeader);
  }
}