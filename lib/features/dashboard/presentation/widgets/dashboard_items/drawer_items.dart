import 'package:autypus/configs/themes/app_colors.dart';
import 'package:autypus/features/dashboard/presentation/widgets/dashboard_items/list_items.dart';
import 'package:flutter/material.dart';

class DrawerItems extends StatefulWidget {
  const DrawerItems({super.key});

  @override
  State<DrawerItems> createState() => _DrawerItemsState();
}

class _DrawerItemsState extends State<DrawerItems> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
          color: AppColors.blackColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          )),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Dashboard Elements',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: ListView(
              children: ListItems.dashBoardItems.entries.map((entry) {
                final item = entry.value;

                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Card(
                    color: const Color(0xff343131),
                    child: Column(
                      children: [
                        ListTile(
                          leading: item['icon'],
                          title: Text(
                            entry.key,
                            style: const TextStyle(
                                fontSize: 15, color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 250,
                          width: 250,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Draggable<Widget>(
                              data: item['container'],
                              onDragCompleted:
                                  () {}, // Only the container is draggable
                              feedback: Material(
                                color: Colors.transparent,
                                child: Container(
                                  width: 250,
                                  height: 250,
                                  color: Colors.grey[800],
                                  child: item['container'],
                                ),
                              ),
                              child: item['container'] ??
                                  SizedBox.shrink(), // Displayed normally
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
