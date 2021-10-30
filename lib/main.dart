import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ExpansionTile Examble',
      home: ExpansionTileExamble(),
    );
  }
}

class ExpansionTileExamble extends StatelessWidget {
  const ExpansionTileExamble({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            EntryItem(data[index]),
        itemCount: data.length,
      ),
    );
  }
}

class Entry {
  const Entry(this.title, [this.children = const <Entry>[]]);
  final String title;
  final List<Entry> children;
}

const List<Entry> data = <Entry>[
  Entry('Chapter A', <Entry>[
    Entry('Section A0', <Entry>[
      Entry('Item A0.1', <Entry>[Entry('Item A0.1.1'), Entry('Item A0.1.2')]),
      Entry('Item A0.2')
    ])
  ]),
  Entry('Chapter B', <Entry>[Entry('Section B0'), Entry('Section B1')])
];

class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) {
      return ListTile(title: Text(root.title));
    }
    return ExpansionTile(
        title: Text(root.title),
        key: PageStorageKey<Entry>(root),
        // trailing: const Icon(Icons.ac_unit),
        // leading: const Icon(Icons.access_alarm),
        children: root.children.map((e) => _buildTiles(e)).toList());
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}
