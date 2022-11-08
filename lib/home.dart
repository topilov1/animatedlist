import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _items = [];
  final GlobalKey<AnimatedListState> key = GlobalKey();

// add inm
  void _addItems() {
    _items.insert(0, 'Topilov ${_items.length + 1}');
    key.currentState!.insertItem(
      0,
      duration: const Duration(seconds: 1),
    );
  }

// delet inem
  void _removeItems(int index) {
    key.currentState!.removeItem(
      index,
      (_, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: Card(
            color: Colors.red[500],
            margin: const EdgeInsets.all(10),
            child: const ListTile(title: Text('DeletItem')),
          ),
        );
      },
      duration: const Duration(milliseconds: 400),
    );
    _items.removeAt(index);
    // remov faqat 1 index dan boshlap ochradi
    // removAt osha oshajoydagi bosilgan indexni ochradi
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 50),
            IconButton(onPressed: _addItems, icon: const Icon(Icons.add)),
            //main
            Expanded(
              child: AnimatedList(
                key: key,
                initialItemCount: 0,
                padding: const EdgeInsets.all(20),
                itemBuilder: (_, index, animation) {
                  return SizeTransition(
                    key: UniqueKey(),
                    sizeFactor: animation,

                    // Mina Card
                    child: Card(
                      margin: const EdgeInsets.all(10),
                      color: Colors.grey[500],
                      child: ListTile(
                        title: Text(
                          _items[index],
                          style: const TextStyle(fontSize: 26),
                        ),
                        trailing: IconButton(
                          onPressed: (() {
                            _removeItems(index);
                          }),
                          icon: const Icon(Icons.delete),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
