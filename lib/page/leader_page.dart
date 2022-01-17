import 'package:flutter/material.dart';
import 'package:haring3/page/sheet_modification_page.dart';

class LeaderPage extends StatelessWidget {
  const LeaderPage({Key? key}) : super(key: key);

  final bool isLeader = true;

  @override
  Widget build(BuildContext context) {

    return SheetModificationPage(isLeader: isLeader);
  }
}