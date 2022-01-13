import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SidebarController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }
  void closeDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }
}