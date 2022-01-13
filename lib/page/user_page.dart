import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haring3/config/palette.dart';
import 'package:haring3/controller/data_controller.dart';
import 'package:haring3/controller/sidebar_controller.dart';
import 'package:haring3/page/sidebar.dart';
import 'package:haring3/widget/musicsheet_widget.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final double sheetWidth = 540.0;
  final double sheetHeight = 700.0;

  final DataController contData = Get.put(DataController());
  final SidebarController contSidebar = Get.put(SidebarController());

  void _toggleSelection(int num) {
    contData.toggleSelection(num);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: contSidebar.scaffoldKey,
      endDrawerEnableOpenDragGesture: false,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.0),
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: Palette.themeColor1,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.download,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.view_sidebar,
            ),
            onPressed: () {
              contSidebar.openDrawer();
            },
          ),
        ],
      ),
      body: SheetScrollView(isLeader: false),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.brush,
        ),
        backgroundColor: Palette.themeColor1,
      ),
      endDrawer: const Sidebar(isLeader: false),
    );
  }
}

