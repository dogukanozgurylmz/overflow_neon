import 'package:flutter/material.dart';
import 'package:neon_overflow/presentation/categories/categories_view.dart';
import 'package:neon_overflow/presentation/home/home_view.dart';
import 'package:neon_overflow/presentation/widgets/sidebar/header/header.dart';
import 'package:neon_overflow/presentation/widgets/sidebar/sidebar.dart';
import 'package:neon_overflow/presentation/widgets/sidebar/sidebar_provider.dart';
import 'package:provider/provider.dart';

import '../core/responsive.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Row(
            children: [
              Responsive.isMobile(context)
                  ? const SizedBox.shrink()
                  : const Sidebar(),
              Column(
                children: [
                  const Header(),
                  Consumer<SidebarProvider>(
                    builder: (context, value, child) {
                      var getStatus = context.read<SidebarProvider>().getStatus;
                      if (getStatus == SidebarStatus.home) {
                        return HomeView();
                      } else if (getStatus == SidebarStatus.categories) {
                        return const CategoriesView();
                      } else if (getStatus == SidebarStatus.notifications) {
                        return const Text("notification");
                      } else if (getStatus == SidebarStatus.favorites) {
                        return const Text("favorites");
                      } else if (getStatus == SidebarStatus.myquestions) {
                        return const Text("myquestions");
                      } else if (getStatus == SidebarStatus.settings) {
                        return const Text("settings");
                      } else {
                        return const Text("Default Data");
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
