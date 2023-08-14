import 'package:flutter/material.dart';
import 'package:neon_overflow/presentation/provider/route_provider.dart';
import 'package:provider/provider.dart';

class QuestionDetailsView extends StatelessWidget {
  const QuestionDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = context.read<RouteProvider>();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Title"),
          Text("Date"),
          Divider(
            indent: 30,
            endIndent: 30,
            color: Colors.black26,
          ),
          Text("body"),
          Text("quill body"),
          Divider(
            indent: 30,
            endIndent: 30,
            color: Colors.black26,
          ),
          Text("Your answer"),
          Text("Answers"),
        ],
      ),
    );
  }
}
