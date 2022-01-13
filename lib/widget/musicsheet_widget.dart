import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haring3/config/palette.dart';
import 'package:haring3/controller/data_controller.dart';

// Global Variables

final DataController contData = Get.put(DataController());
const double sheetWidth = 540.0;
const double sheetHeight = 700.0;

// Global Methods

void _deselectAll() {
  contData.deselectAll();
}

void _toggleSelection(int num) {
  if (contData.selectedNum.value != num) _deselectAll();
  contData.toggleSelection(num);
}

void _delImage(int num) {
  contData.delDatum(num);
}

// Widget List

List<Widget> musicSheets(bool isLeader) {
  final List<Widget> _list = [];

  for (int i = 0; i < (contData.getData().length - 1) / 2; i++) {
    _list.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MusicSheetWidget(
            isLeader: isLeader,
            datum: contData.getData()[2 * i]
          ),
          const SizedBox(width: 10.0),
          MusicSheetWidget(
            isLeader: isLeader,
            datum: contData.getData()[2 * i + 1]
          ),
        ],
      ),
    );
  }
  if (contData.getData().length % 2 == 1) {
    _list.add(
      MusicSheetWidget(
        isLeader: isLeader,
        datum: contData.getData().last
      ),
    );
  }

  return _list;
}

// Widget

class SheetScrollView extends StatefulWidget {
  const SheetScrollView({Key? key, required this.isLeader}) : super(key: key);

  final bool isLeader;

  @override
  SheetScrollViewState createState() => SheetScrollViewState();
}

class SheetScrollViewState extends State<SheetScrollView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: musicSheets(widget.isLeader),
        ),
      ),
    );
  }
}

class MusicSheetWidget extends StatefulWidget {
  const MusicSheetWidget({Key? key, required this.isLeader, required this.datum}) : super(key: key);

  final bool isLeader;
  final Datum datum;

  @override
  _MusicSheetWidgetState createState() => _MusicSheetWidgetState();
}

class _MusicSheetWidgetState extends State<MusicSheetWidget> {

  @override
  Widget build(BuildContext context) {
    SheetScrollViewState? parent = context.findAncestorStateOfType<SheetScrollViewState>();

    return Container(
      key: ValueKey(widget.datum.num),
      margin: const EdgeInsets.symmetric(vertical: 20.0,),
      width: sheetWidth,
      height: sheetHeight,
      decoration: BoxDecoration(
        color: widget.datum.isSelected ?
          Palette.themeColor1.withOpacity(.5) :
          Colors.grey.withOpacity(.5),
        border: Border.all(
          width: 3.0,
          color: widget.datum.isSelected ?
            Palette.themeColor1 : Colors.transparent,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0.0,
            child: IconButton(
              icon: const Icon(
                Icons.brush,
                color: Colors.white,
              ),
              onPressed: () {
                parent!.setState(() {
                  _toggleSelection(widget.datum.num);
                });
              },
            ),
          ),
          if (widget.isLeader)
          Positioned(
            right: 0.0,
            child: IconButton(
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              ),
              onPressed: () {
                parent!.setState(() {
                  _delImage(widget.datum.num);
                });
              },
            ),
          ),
          Positioned(
            child: Center(
              child: Text(
                '${widget.datum.num}',
                style: TextStyle(
                  color: Colors.white.withOpacity(.5),
                  fontSize: 180.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}