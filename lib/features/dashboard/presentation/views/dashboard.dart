import 'package:autypus/configs/themes/app_colors.dart';
import 'package:autypus/features/dashboard/models/car_data_model.dart';
import 'package:autypus/features/dashboard/models/driving_mode_model.dart';
import 'package:autypus/features/dashboard/presentation/views/menu_extension.dart';
import 'package:autypus/features/dashboard/presentation/widgets/dashboard_items/circle_meter.dart';
import 'package:autypus/features/dashboard/presentation/widgets/dashboard_items/dashline_meter.dart';
import 'package:autypus/features/dashboard/presentation/widgets/dashboard_items/drag_body.dart';
import 'package:autypus/features/dashboard/presentation/widgets/dashboard_items/drawer_items.dart';
import 'package:autypus/features/dashboard/presentation/widgets/dashboard_items/highway.dart';
import 'package:autypus/features/dashboard/presentation/widgets/dashboard_items/items/tachometer.dart';
import 'package:autypus/features/dashboard/presentation/widgets/event/keyboard.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool _isDrawerOpen = false;

  void _toggleDrawer() {
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.darkColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MenuExtension(),
                  ),
                );
              },
              icon: Icon(
                Icons.arrow_circle_right,
                size: 50,
                color: AppColors.primary100Color,
              ),
            )
          ],
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(
                  Icons.menu,
                  size: 50,
                  color: AppColors.primary100Color,
                ),
                onPressed: () {
                  _toggleDrawer();
                },
              );
            },
          ),
        ),
        body: Stack(
          children: [
            // Highway(),
            // DashlineMeter(
            //   value: 6,
            //   startLabel: 'E',
            //   endLabel: 'F',
            //   numberDivisions: 10,
            //   iconPath: 'assets/icons/fuel_gauge.png',
            // ),
            const Positioned(
              right: 0,
              left: 0,
              bottom: 20,
              child: SizedBox(
                height: 450,
                child: ModelViewer(
                  backgroundColor: Colors.transparent,
                  src: 'assets/glb/bmw_i8.glb',
                  alt: 'BMW i8 3D Model',
                  ar: true,
                  cameraControls: false,
                  cameraOrbit: '180deg 75deg',
                  iosSrc: 'assets/glb/bmw_i8.glb',
                  disableZoom: false,
                  animationCrossfadeDuration: 500,
                ),
              ),
            ),
            MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) => CarDataModel(),
                ),
                ChangeNotifierProvider(
                  create: (context) => DrivingModeModel(key: ''),
                ),
              ],
              child: const KeyPressListenerPage(
                child: DragBody(),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              left: _isDrawerOpen ? 0 : -300,
              top: 20,
              bottom: 0,
              child: const DrawerItems(),
            ),
          ],
        ));
  }
}
