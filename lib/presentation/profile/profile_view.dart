import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Container(
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage("https://picsum.photos/1500"),
                minRadius: 70,
              ),
              Text(
                "firstname lastname",
                style: textTheme.headlineSmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
