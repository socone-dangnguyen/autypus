import 'package:autypus/configs/socket/app_socket.dart';
import 'package:autypus/features/dashboard/models/driving_mode_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class KeyPressListenerPage extends StatefulWidget {
  final Widget child;
  const KeyPressListenerPage({Key? key, required this.child}) : super(key: key);

  @override
  _KeyPressListenerPageState createState() => _KeyPressListenerPageState();
}

class _KeyPressListenerPageState extends State<KeyPressListenerPage> {
  String _pressedKey = ''; // Variable to store the pressed key name
  final FocusNode _focusNode = FocusNode();
  late final WebSocketChannel _channel;
  void _sendKey(String key) {
    _channel.sink.add(key);
  }

  // This method will handle key events
  void _onKey(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      setState(() {
        // Get the name of the pressed key
        _pressedKey = event.logicalKey.keyLabel ?? 'Unknown key';
      });
      Provider.of<DrivingModeModel>(context, listen: false)
          .updateKey(_pressedKey);
      _sendKey(_pressedKey);
    }
  }

  @override
  void initState() {
    super.initState();
    // Request focus when the widget is initialized
    _channel = WebSocketChannel.connect(Uri.parse(AppSocket.url));
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _channel.sink.close();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RawKeyboardListener(
        focusNode: _focusNode, // Focus node to listen to keyboard events
        onKey: _onKey, // Callback when a key is pressed
        child: widget.child,
      ),
    );
  }
}
