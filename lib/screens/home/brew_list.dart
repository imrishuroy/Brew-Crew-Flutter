import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/brew_tile.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context);

    // for (var item in brews.docs) {
    //   print(item.data());
    // }
    // brews.forEach((brew) {
    //   print(brew.name);
    //   print(brew.strength);
    //   print(brew.sugars);
    // });
    if (brews.length < 0) {
      return Center(
        child: Text('No Items Here'),
      );
    }
    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context, index) {
        return BrewTile(
          brew: brews[index],
        );
      },
    );
  }
}

// Column(
//           children: [
//             Text('${brews[index].name}'),
//             Text('${brews[index].strength}'),
//             Text('${brews[index].sugars}')
//           ],
//         );
