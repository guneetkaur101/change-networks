import 'package:flutter/material.dart';

class QuoteToolsPage extends StatelessWidget {
  const QuoteToolsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _UnderConstructionPage(title: 'Quote Tools');
  }
}

class _UnderConstructionPage extends StatelessWidget {
  final String title;
  const _UnderConstructionPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.construction,
            size: 64,
            color: const Color.fromARGB(255, 72, 72, 72),
          ),
          SizedBox(height: 16),
          Text(
            '$title under construction',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 8),
          Text(
            'We are working hard to bring this page to you soon!',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
