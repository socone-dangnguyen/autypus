import 'dart:convert';

import 'package:autypus/configs/socket/app_socket.dart';
import 'package:autypus/features/dashboard/domain/models/car_data_model.dart';
import 'package:autypus/features/dashboard/presentation/widgets/dashboard_items/drop.dart';
import 'package:autypus/features/dashboard/presentation/widgets/dashboard_items/resize.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class DragBody extends StatefulWidget {
  const DragBody({super.key});

  @override
  State<DragBody> createState() => _DragBodyState();
}

class _DragBodyState extends State<DragBody> {
  final List<DropItem> dashboardWidgets = [];
  late final WebSocketChannel _channel;

  void _removeWidget(DropItem itemToRemove) {
    setState(() {
      dashboardWidgets.remove(itemToRemove);
    });
  }

  @override
  void initState() {
    super.initState();
    _channel = WebSocketChannel.connect(Uri.parse(AppSocket.url));
    _channel.stream.listen(
      (data) {
        Map<String, dynamic> jsonData = jsonDecode(data);
        if (mounted) {
          Provider.of<CarDataModel>(context, listen: false)
              .updateData(jsonData);
        }
      },
      onError: (error) {
        print('WebSocket Error: $error');
      },
      onDone: () {
        print('WebSocket closed');
      },
    );
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<Widget>(
      onAcceptWithDetails: (details) {
        setState(() {
          final newDropItem = DropItem(
            widget: details.data,
            offset: details.offset,
          );
          dashboardWidgets.add(newDropItem);
        });
      },
      builder: (context, candidateData, rejectedData) {
        return Container(
          color: Colors.transparent,
          child: Stack(
            children: [
              // Render all the dropped widgets with delete functionality
              ...dashboardWidgets.map((droppedWidget) {
                return Resizable(
                  top: droppedWidget.offset.dy,
                  left: droppedWidget.offset.dx,
                  child: droppedWidget.widget,
                  // Add delete functionality
                  onDelete: () => _removeWidget(droppedWidget),
                );
              }),

              // Show a hint when dragging
              if (candidateData.isNotEmpty)
                Center(
                  child: Text(
                    'Drop here',
                    style: TextStyle(fontSize: 24, color: Colors.grey.shade600),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
