import 'package:flutter/material.dart';
import 'data_nofilter.dart';

class FastFilterBar extends StatefulWidget {
  @override
  FastFilterBarState createState() => FastFilterBarState();
}

class FastFilterBarState extends State<FastFilterBar> {
  List<String> _filterOptions = [];

  String? _selectedFilter;
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    _filterOptions = ['All'] + data.map((e) => e.category).toSet().toList();
    _selectedFilter = _filterOptions[0];
    _selectedIndex = 0;
    _applyFilter();
  }

  void _applyFilter() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _filterOptions.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ChoiceChip(
                  label: Text(_filterOptions[index]),
                  selected: _selectedIndex == index,
                  selectedColor: Colors.red,
                  onSelected: (selected) {
                    setState(() {
                      _selectedFilter = selected ? _filterOptions[index] : null;
                      _selectedIndex = selected ? index : null;
                      _applyFilter();
                    });
                  },
                ),
              );
            },
          ),
        ),
        Expanded(
          child: _selectedFilter == null || _selectedFilter == 'All'
              ? ListView.separated(
                  itemCount: data.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final item = data[index];
                    return ListTile(
                      title: Text(item.title),
                      subtitle: Text(item.description),
                    );
                  },
                )
              : ListView.separated(
                  itemCount: data
                      .where((element) => element.category == _selectedFilter)
                      .length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final item = data
                        .where((element) => element.category == _selectedFilter)
                        .toList()[index];
                    return ListTile(
                      title: Text(item.title),
                      subtitle: Text(item.description),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
