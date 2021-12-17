import 'package:flutter/material.dart';

class WrapWidgetDemo extends StatefulWidget {
  const WrapWidgetDemo({Key? key}) : super(key: key);
  final String title = 'Wrap Widget,Chips Demo';

  @override
  _WrapWidgetDemoState createState() => _WrapWidgetDemoState();
}

class _WrapWidgetDemoState extends State<WrapWidgetDemo> {

  late GlobalKey<ScaffoldState> _key;
  late List<String> _dynamicChips;
  late bool _selected;
  late List<Company> _companies;
  late List<String> _filters;
  late List<String> _choices;
  late int _defaultChoiceIndex;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _key = GlobalKey<ScaffoldState> ();
    _dynamicChips = ['Health','Food','Nature','CuteSmile'];
    _selected = false;
    _defaultChoiceIndex =0;
    _filters = <String>[];
    _companies = <Company>[
      const Company('Google'),
      const Company('Apple'),
      const Company('Microsoft'),
      const Company('Sony'),
      const Company('Amazon'),
    ];
    _choices = ['choice-1','choice-2','choice-3','choice-4','choice-5',];

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Use-Chips',
          style: TextStyle(
            fontSize: 20.0,
            letterSpacing: 3.0,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: rowChips(),
          ),
          const Divider(),
          wrapWidget(),
          const Divider(),
          dynamicChips(),
          const Divider(),
          actionChips(),
          const Divider(),
          inputChips(),
          const Divider(),
          choiceChips(),
          const Divider(),
          Wrap(
            children: companyWidgets.toList(),
          ),
          Text('Selected ${_filters.join(',')}')
        ],

      ),
    );
  }




  rowChips(){
    return Row(
      children: [
        chipForRow('Health', Color(0xFFff8a65)),
        chipForRow('Food', Color(0xFF4fc3f7)),
        chipForRow('Lifestyle', Color(0xFF9575cd)),
        chipForRow('Sports', Color(0xFF4db6ac)),
        chipForRow('Nature', Colors.black),
        chipForRow('CuteSmile', Colors.greenAccent),

      ],
    );
  }

  wrapWidget(){
    return Wrap(
      spacing: 6.0,
      runSpacing: 6.0,
      children: [
      //   chipForRow('Health', Color(0xFFff8a65)),
      //   chipForRow('Food', Color(0xFF4fc3f7)),
      //   chipForRow('Lifestyle', Color(0xFF9575cd)),
      //   chipForRow('Sports', Color(0xFF4db6ac)),
      //   chipForRow('Nature', Colors.black),
      //   chipForRow('CuteSmile', Colors.greenAccent),

        chip('Health', Color(0xFFff8a65)),
        chip('Food', Color(0xFF4fc3f7)),
        chip('Lifestyle', Color(0xFF9575cd)),
        chip('Sports', Color(0xFF4db6ac)),
        chip('Nature', Colors.black),
        chip('CuteSmile', Colors.greenAccent),

      ],
    );
  }

  dynamicChips(){
    return Wrap(
        spacing: 6.0,
        runSpacing: 6.0,
        children: List<Widget>.generate(_dynamicChips.length,(int index){
          return Chip(
            label: Text(_dynamicChips[index]),
            onDeleted: (){
              setState(() {
                _dynamicChips.removeAt(index);
              });
            },
            deleteIcon: Icon(Icons.remove_circle_outline),
          );
        })
    );
  }


  Widget chipForRow(String label,Color color){
    return Container(
      margin: EdgeInsets.all(6.0),
      child: Chip(
        labelPadding: EdgeInsets.all(5.0),
          avatar: CircleAvatar(
            backgroundColor: Colors.grey.shade600,
            child: Text(label[0].toUpperCase()),
          ),
          label: Text(
            label,
            style: const TextStyle(
              color: Colors.white
            ),
          ),
        backgroundColor: color,
        elevation: 0.0,
        shadowColor: Colors.grey[60],
        padding: EdgeInsets.all(6.0),
      ),
    );
  }

  Widget chip(String label,Color color){
    return Chip(
      labelPadding: EdgeInsets.all(5.0),
        avatar: CircleAvatar(
          backgroundColor: Colors.grey.shade600,
          child: Text(label[0].toUpperCase()),
        ),
        label: Text(
          label,
          style: TextStyle(
            color: Colors.white
          ),
        ),
      backgroundColor: color,
      elevation: 0.0,
      shadowColor: Colors.grey[60],
      padding: const EdgeInsets.all(6.0),
    );
  }

  Widget actionChips(){
    return ActionChip(
      elevation: 6.0,
      onPressed: (){
        _key.currentState!.showSnackBar(SnackBar (
          content: Text('Calling...'),
        ));
      },
      backgroundColor: Colors.white,
      shape: StadiumBorder(
        side: BorderSide(
          width: 1.0,
          color: Colors.blueAccent
        )
      ),
      label: Text('Call'),
      padding: EdgeInsets.all(1.0),
      avatar: CircleAvatar(
        backgroundColor: Colors.green[60],
         child: Icon(Icons.call),
      ),

      
    );
  }

  Widget inputChips(){
    return InputChip(
      padding: EdgeInsets.all(2.0),
        avatar: CircleAvatar(
          backgroundColor: Colors.blue.shade600,
          child: Text('JW'),
        ),
        label: Text('Hello Mr.'),
      selected: _selected,
      selectedColor: Colors.green,
      onSelected: (bool selected){
       setState(() {
         _selected = selected;
       });
      },

      onDeleted: (){

      },
    );
  }

  Iterable<Widget> get companyWidgets sync* {
    for (Company company in _companies){
      yield Padding(
        padding: const EdgeInsets.all(6.0),
        child: FilterChip(
          label: Text(company.name),
          avatar: CircleAvatar(
            child: Text(company.name[0].toUpperCase()),
          ),
          selected: _filters.contains(company.name),
          onSelected: (bool selected){
            setState(() {
              if(selected){
                _filters.add(company.name);
              }else {
                _filters.removeWhere((String name){
                  return name == company.name;
                });
              }
            });
          },
        ),
      );
    }
  }

  Widget choiceChips(){
    return Expanded(
      child: ListView.builder(
        itemCount: _choices.length,
          itemBuilder: (BuildContext context,int index){
          return ChoiceChip(
            label: Text(_choices[index]),
            selected: _defaultChoiceIndex == index,
            selectedColor: Colors.green,
            onSelected: (bool selected){
              setState(() {
                _defaultChoiceIndex = (selected ? index : null)!;
              });
            },
            backgroundColor: Colors.blue,
            labelStyle: const TextStyle(
              color: Colors.white,
              
            ),
          );
          }),
    );

  }



}

class Company {
  final String name;
  const Company(this.name);
}