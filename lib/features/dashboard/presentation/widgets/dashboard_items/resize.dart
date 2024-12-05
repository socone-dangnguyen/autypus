import 'package:autypus/configs/themes/app_colors.dart';
import 'package:autypus/core/utils/dashboard_item.dart';
import 'package:autypus/features/dashboard/models/car_data_model.dart';
import 'package:autypus/features/dashboard/models/driving_mode_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_box_transform/flutter_box_transform.dart';
import 'package:provider/provider.dart';

class Resizable extends StatefulWidget {
  final double top;
  final double left;
  final Widget child;
  final VoidCallback? onDelete; // Callback để xóa phần tử

  const Resizable(
      {Key? key,
      required this.child,
      required this.top,
      required this.left,
      this.onDelete})
      : super(key: key);

  @override
  _ResizableState createState() => _ResizableState();
}

class _ResizableState extends State<Resizable> {
  TransformableBoxController? controller;
  bool isSelected = false;
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Size size = MediaQuery.of(context).size;
      setState(() {
        controller = TransformableBoxController(
          rect: Rect.fromLTWH(widget.left, widget.top, 200, 200),
          clampingRect: Rect.fromLTWH(0, 0, size.width, size.height),
          constraints: BoxConstraints(
            minWidth: 100,
            minHeight: 100,
            maxWidth: 700,
            maxHeight: 700,
          ),
          resizeModeResolver: () => ResizeMode.scale,
        );
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final carDataModel = Provider.of<CarDataModel>(context);
    final drivingMode = Provider.of<DrivingModeModel>(context).key;
    carDataModel.updateDrivingMode(drivingMode);
    Widget copyWidget =
        DashboardItem.getCarInstance(widget.child, carDataModel);
    if (controller == null) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      child: Stack(
        children: [
          TransformableBox(
            controller: controller!,
            contentBuilder: (context, rect, flip) {
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary100Color
                            : Colors.transparent,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: copyWidget,
                  ),
                  // Nút xóa ở top right
                  if (isSelected)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          // Gọi callback xóa phần tử
                          widget.onDelete?.call();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child:
                              Icon(Icons.close, color: Colors.white, size: 16),
                        ),
                      ),
                    ),
                ],
              );
            },
            onTap: () {
              setState(() {
                isSelected = !isSelected;
              });
            },
            resizable: isSelected,
            draggable: true,
            onChanged: (result, details) {},
          ),
        ],
      ),
    );
  }
}
