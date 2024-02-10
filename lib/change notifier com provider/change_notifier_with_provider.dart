import 'package:flutter/material.dart';
import 'package:flutter_change_notifier/notifier/item_notifier.dart';
import 'package:flutter_change_notifier/widgets/app_bar.dart';
import 'package:flutter_change_notifier/widgets/list_tile.dart';
import 'package:provider/provider.dart';

class ChangeNotifierWithProvider extends StatefulWidget {
  const ChangeNotifierWithProvider({Key? key}) : super(key: key);

  @override
  State<ChangeNotifierWithProvider> createState() =>
      _ChangeNotifierWithProviderState();
}

class _ChangeNotifierWithProviderState
    extends State<ChangeNotifierWithProvider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("ChangeNotifier with provider"),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const AddPage()),
        ),
        child: const Icon(Icons.add),
      ),
      body: Consumer<ItemNotifier>(builder: (context, value, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => ModifyPage(index: index)),
              ),
              child: getListTile(value.getItems(), index),
            );
          },
          itemCount: value.getSize(),
        );
      }),
    );
  }
}

class AddPage extends StatelessWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController =
        TextEditingController(text: "Default Text");

    return Scaffold(
      appBar: getAppBar("Add ToDoItem"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<ItemNotifier>(context, listen: false)
              .add(textEditingController.text);
          Navigator.pop(context);
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: TextField(
            controller: textEditingController,
          ),
        ),
      ),
    );
  }
}

class ModifyPage extends StatelessWidget {
  const ModifyPage({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController(
      text: Provider.of<ItemNotifier>(context, listen: false).getItems()[index],
    );

    return Scaffold(
      appBar: getAppBar("Update ToDoItem"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<ItemNotifier>(context, listen: false)
              .modify(index, textEditingController.text);
          Navigator.pop(context);
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: TextField(
            controller: textEditingController,
          ),
        ),
      ),
    );
  }
}
