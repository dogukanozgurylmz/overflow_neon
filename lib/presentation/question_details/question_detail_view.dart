import 'package:flutter/material.dart';
import 'package:neon_overflow/presentation/provider/route_provider.dart';
import 'package:provider/provider.dart';

class QuestionDetailsView extends StatelessWidget {
  const QuestionDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = context.read<RouteProvider>();
    return Text(provider.questionId);
  }
}
