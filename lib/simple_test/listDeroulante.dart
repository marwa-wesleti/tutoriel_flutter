import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ExamplePage extends StatefulWidget {
  const ExamplePage({Key? key}) : super(key: key);

  @override
  _ExamplePageState createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  late List<String> _list1;
  late List<String> _list2;
  late List<String> _list3;

  @override
  void initState() {
    super.initState();
    _list1 = ['Item 1.1', 'Item 1.2', 'Item 1.3'];
    _list2 = ['Item 2.1', 'Item 2.2', 'Item 2.3'];
    _list3 = ['Item 3.1', 'Item 3.2', 'Item 3.3'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 375),
            childAnimationBuilder: (widget) => SlideAnimation(
              horizontalOffset: 50.0,
              child: FadeInAnimation(
                child: widget,
              ),
            ),
            children: [
              _buildListTile('List 1', _list1),
              _buildListTile('List 2', _list2),
              _buildListTile('List 3', _list3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListTile(String title, List<String> items) {
    return ListTile(
      title: Text(title),
      trailing: DropdownButton(
        items: items
            .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(item),
                ))
            .toList(),
        onChanged: (value) {},
      ),
    );
  }
}