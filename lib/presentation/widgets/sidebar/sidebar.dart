import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neon_overflow/presentation/widgets/sidebar/sidebar_provider.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(left: 32),
      width: 270,
      height: size.height,
      decoration: const BoxDecoration(
        color: Color(0xFF202020),
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Expanded(
            flex: 1,
            child: Text.rich(
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
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                //status = SidebarStatus.home;
                context.read<SidebarProvider>().setStatus(SidebarStatus.home);
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.home,
                    color: Color(0xFFF9F9F9),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Home',
                    style: TextStyle(
                      color: Color(0xFFF9F9F9),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                // status = SidebarStatus.categories;
                context
                    .read<SidebarProvider>()
                    .setStatus(SidebarStatus.categories);
                print(context.read<SidebarProvider>().getStatus);
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.category,
                    color: Color(0xFFF9F9F9),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Categories',
                    style: TextStyle(
                      color: Color(0xFFF9F9F9),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                context
                    .read<SidebarProvider>()
                    .setStatus(SidebarStatus.notifications);
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.notifications,
                    color: Color(0xFFF9F9F9),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Notifications',
                    style: TextStyle(
                      color: Color(0xFFF9F9F9),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                context
                    .read<SidebarProvider>()
                    .setStatus(SidebarStatus.favorites);
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.bookmark,
                    color: Color(0xFFF9F9F9),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Favorites',
                    style: TextStyle(
                      color: Color(0xFFF9F9F9),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                context
                    .read<SidebarProvider>()
                    .setStatus(SidebarStatus.myquestions);
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.question_mark_sharp,
                    color: Color(0xFFF9F9F9),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'My Questions',
                    style: TextStyle(
                      color: Color(0xFFF9F9F9),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                context
                    .read<SidebarProvider>()
                    .setStatus(SidebarStatus.settings);
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.settings,
                    color: Color(0xFFF9F9F9),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Settings',
                    style: TextStyle(
                      color: Color(0xFFF9F9F9),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          const Spacer(),
          const Spacer(),
          const Spacer(),
          const Spacer(),
          const Spacer(),
        ],
      ),
    );
  }
}
