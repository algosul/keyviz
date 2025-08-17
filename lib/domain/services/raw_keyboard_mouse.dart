import 'package:flutter/services.dart';

// key id's for fake mouse events
const leftClickId = 0x00900000011;
const middleClickId = 0x00900000015;
const rightClickId = 0x00900000012;
const dragId = 0x00900000013;
const scrollId = 0x00900000014;

// an implementation of [RawKeyEventData] which is used
// to fake mouse events as keyboard events
class RawKeyEventDataMouse extends RawKeyEventData {
  const RawKeyEventDataMouse(this.id);

  final int id;

  @override
  KeyboardSide? getModifierSide(ModifierKey key) {
    return null;
  }

  @override
  bool isModifierPressed(ModifierKey key,
      {KeyboardSide side = KeyboardSide.any}) {
    return false;
  }

  @override
  String get keyLabel {
    switch (id) {
      case leftClickId:
        return "左键";

      case middleClickId:
        return "中键";

      case rightClickId:
        return "右键";

      case dragId:
        return "拖动";

      case scrollId:
        return "缩放";
    }
    return '';
  }

  @override
  LogicalKeyboardKey get logicalKey => LogicalKeyboardKey(id);

  @override
  PhysicalKeyboardKey get physicalKey => PhysicalKeyboardKey(id);

  // mouse left button down/up
  const RawKeyEventDataMouse.leftClick() : id = leftClickId;

  // mouse middle button down/up
  const RawKeyEventDataMouse.middleClick() : id = middleClickId;

  // mouse right button down/up
  const RawKeyEventDataMouse.rightClick() : id = rightClickId;

  // mouse left/right button down and mouse moving
  const RawKeyEventDataMouse.drag() : id = dragId;

  // mouse wheel event
  const RawKeyEventDataMouse.scroll() : id = scrollId;
}
