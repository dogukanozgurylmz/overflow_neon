// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:neon_overflow/core/responsive.dart';
import 'package:neon_overflow/presentation/widgets/sidebar/sidebar_provider.dart';
import 'package:provider/provider.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  int selectedIndex = 0;
  bool iconSidebarResponsive(context) {
    var result = Responsive.isMedium(context) || Responsive.isLarge(context);
    if (!result) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var selectedIndex = context.watch<SidebarProvider>().selectedIndex;
    print(selectedIndex);
    return Theme(
      data: Theme.of(context).copyWith(
        navigationRailTheme: const NavigationRailThemeData(
          labelType: NavigationRailLabelType.none,
          unselectedLabelTextStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
          unselectedIconTheme: IconThemeData(color: Colors.grey),
          selectedLabelTextStyle: TextStyle(
            color: Color(0xff7D00AA),
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
          selectedIconTheme: IconThemeData(color: Color(0xfffafafa)),
          backgroundColor: Color(0xFF202020),
          elevation: 0,
        ),
      ),
      child: NavigationRail(
        destinations: [
          NavigationRailDestination(
            icon: Icon(
              Icons.home,
              color: selectedIndex == 0 ? Colors.white : null,
            ),
            label: const Text('Home'),
          ),
          NavigationRailDestination(
            icon: Icon(
              Icons.category_outlined,
              color: selectedIndex == 1 ? Colors.white : null,
            ),
            label: const Text('Categories'),
          ),
          const NavigationRailDestination(
            icon: Icon(Icons.notifications_none_outlined),
            label: Text('Notifications'),
          ),
          const NavigationRailDestination(
            icon: Icon(Icons.bookmark_border_outlined),
            label: Text('Favorites'),
          ),
          const NavigationRailDestination(
            icon: Icon(Icons.question_mark_sharp),
            label: Text('My Questions'),
          ),
          const NavigationRailDestination(
            icon: Icon(Icons.settings),
            label: Text('Settings'),
          ),
        ],
        extended: Responsive.isMedium(context) || Responsive.isLarge(context)
            ? false
            : true,
        selectedIndex: context.watch<SidebarProvider>().selectedIndex,
        onDestinationSelected: (int index) {
          context
              .read<SidebarProvider>()
              .setStatus(SidebarStatus.values[index]);
          _updateUrlAndNavigate("/${SidebarStatus.values[index].name}");
          var result =
              Responsive.isExtraSmall(context) || Responsive.isSmall(context);
          if (result) {
            Navigator.pop(context);
          }
          context.read<SidebarProvider>().setSelectedIndex(index);
        },
        labelType: NavigationRailLabelType.none,
        backgroundColor: const Color(0xFF202020),
        leading: Responsive.isExtraSmall(context) || Responsive.isSmall(context)
            ? const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'neon',
                      style: TextStyle(
                        color: Color(0xFF7D00AA),
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: ' overflow',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              )
            : null,
        trailing:
            Responsive.isExtraSmall(context) || Responsive.isSmall(context)
                ? IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  )
                : null,
      ),
    );
  }
}

void _updateUrlAndNavigate(String path) {
  final newUrl = Uri.parse(path);
  html.window.history.pushState(null, '', newUrl.toString());
}

//600
//1000