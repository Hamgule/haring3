import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haring3/controller/data_controller.dart';
import 'package:haring3/page/leader_page.dart';
import 'package:reorderables/reorderables.dart';

// Global Variables

const double _fontSize = 30.0;
const double _sheetWidth = 100.0;
const double _sheetHeight = 130.0;

final contData = Get.put(DataController());


class Sidebar extends StatefulWidget {
  const Sidebar({Key? key, required this.isLeader}) : super(key: key);

  final bool isLeader;

  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  List<Widget> _tiles = [];
  double marginHorizontal = 10.0;

  List<int> orderList = [];

  @override
  void initState() {
    super.initState();
    _tiles = <Widget>[
      for (Datum datum in contData.getData())
      Container(
        key: ValueKey('${datum.num}'),
        width: _sheetWidth,
        height: _sheetHeight,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(.5),
        ),
        child: Center(
          child: Text(
            '${datum.num}',
            style: TextStyle(
              fontSize: _fontSize,
              color: Colors.black.withOpacity(.5),
            ),
          ),
        ),
      )
    ];
  }

  void dataReorder(List<int> orderList) {
    RxList<Datum> _orderData = RxList<Datum>([]);

    for (int order in orderList) {
      _orderData.add(contData.getData().where((d) => (d.num == order)).first);
    }

    contData.setData(_orderData);
  }

  @override
  Widget build(BuildContext context) {
    LeaderPageState? parent = context.findAncestorStateOfType<LeaderPageState>();

    void _onReorder(int oldIndex, int newIndex) {
      Widget row = _tiles.removeAt(oldIndex);
      _tiles.insert(newIndex, row);
      orderList = [];

      for (Widget tile in _tiles) {
        orderList.add(int.parse((tile.key as ValueKey).value));
      }

      parent!.setState(() {
        dataReorder(orderList);
      });
    }

    final leaderWrap = ReorderableWrap(
      spacing: 8.0,
      runSpacing: 4.0,
      padding: const EdgeInsets.all(8),
      children: _tiles,
      onReorder: _onReorder,
      alignment: WrapAlignment.center,
    );

    final userWrap = Wrap(
      children: sidebarMusicSheets(),
    );

    return Drawer(
      child: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.only(top: 40.0),
        child: SingleChildScrollView(
          child: widget.isLeader ? leaderWrap : userWrap,
        ),
      ),
    );
  }

}

List<Widget> sidebarMusicSheets() {
  final List<Widget> _list = [];

  for (int i = 0; i < (contData.getData().length - 1) / 2; i++) {
    _list.add(
      ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SidebarMusicSheetWidget(datum: contData.getData()[2 * i]),
            const SizedBox(width: 10.0),
            SidebarMusicSheetWidget(datum: contData.getData()[2 * i + 1]),
          ],
        ),
      ),
    );
  }
  if (contData.getData().length % 2 == 1) {
    _list.add(
      Center(
        child: ListTile(
          title: SidebarMusicSheetWidget(
            datum: contData.getData().last,
          ),
        ),
      ),
    );
  }

  return _list;
}

class SidebarMusicSheetWidget extends StatefulWidget {
  const SidebarMusicSheetWidget({Key? key, required this.datum}) : super(key: key);
  final Datum datum;

  @override
  _SidebarMusicSheetWidgetState createState() => _SidebarMusicSheetWidgetState();
}

class _SidebarMusicSheetWidgetState extends State<SidebarMusicSheetWidget> {

  @override
  Widget build(BuildContext context) {

    return Container(
      width: _sheetWidth,
      height: _sheetHeight,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.5),
      ),
      child: Center(
        child: Text(
          '${widget.datum.num}',
          style: TextStyle(
            fontSize: 30.0,
            color: Colors.black.withOpacity(.5),
          ),
        ),
      ),
    );
  }
}