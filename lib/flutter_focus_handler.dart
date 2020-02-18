library flutter_focus_handler;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class FocusHandlerWidget extends StatefulWidget {
  final Widget child;

  FocusHandlerWidget({@required this.child});

  static FocusHandlerWidgetState of(BuildContext context) {
    assert(context != null);
    final FocusHandlerWidgetState focusHandler = context.findAncestorStateOfType<FocusHandlerWidgetState>();
    return focusHandler;
  }

  @override
  FocusHandlerWidgetState createState() => FocusHandlerWidgetState();
}

class FocusHandlerWidgetState extends State<FocusHandlerWidget> {
  FocusScopeNode currentFocus;

  unfocusNode() {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
  }

  registerNode(FocusNode node) {
    node.addListener(() {
      if (node.hasFocus) {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      },
      child: widget.child,
    );
  }
}