import 'package:autypus/configs/themes/app_colors.dart';
import 'package:autypus/features/dashboard/presentation/views/menu_extension.dart';
import 'package:autypus/features/dashboard/presentation/widgets/dashboard_items/highway.dart';
import 'package:autypus/features/dashboard/presentation/widgets/dashboard_items/items/speedometer.dart';
import 'package:autypus/features/dashboard/presentation/widgets/dashboard_items/items/tachometer.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ),
        drawer: Drawer(
          backgroundColor: AppColors.darkColor,
          child: ListView(
            children: const [
              DrawerHeader(
                child: Center(
                  child: Text(
                    'Dashboard Items',
                    style: TextStyle(
                      color: AppColors.primary100Color,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            Highway(),
            Speedometer(),
            Tachometer(
              value: 5,
            ),
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
          ],
        ));
  }
}
